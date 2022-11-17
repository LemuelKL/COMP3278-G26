import os
import json
from datetime import datetime

import mysql.connector
import requests
from facerecognizer import FaceRecognizer
from PyQt5 import QtWebChannel
from PyQt5.QtCore import *
from PyQt5.QtWebEngineWidgets import *

from dotenv import load_dotenv


class WebEnginePage(QWebEnginePage):
    def __init__(self, *args, **kwargs):
        QWebEnginePage.__init__(self, *args, **kwargs)
        self.featurePermissionRequested.connect(self.onFeaturePermissionRequested)

    def onFeaturePermissionRequested(self, url, feature):
        if feature in (
            QWebEnginePage.MediaAudioCapture,
            QWebEnginePage.MediaVideoCapture,
            QWebEnginePage.MediaAudioVideoCapture,
        ):
            self.setFeaturePermission(
                url, feature, QWebEnginePage.PermissionGrantedByUser
            )
        else:
            self.setFeaturePermission(
                url, feature, QWebEnginePage.PermissionDeniedByUser
            )

class BypassFaceRecognizer:
    def __init__(self, parent=None):
        pass

    def recognize(self, username, image):
        return True

class WebApp(QWebEngineView):
    def __init__(self, parent=None):
        super().__init__(parent)

        # Establish connection to database
        load_dotenv()
        self.myconn = mysql.connector.connect(
            host="localhost",
            user=os.environ.get("DB_USER", "root"),
            passwd=os.environ.get("DB_PASSWD", "root"),
            database="facerecognition",
        )
        self.dbcursor = self.myconn.cursor()
        print("Connected to database")

        # sort of like a session
        self.student_id = None
        self.last_login_dt = None
        self.student_email = None

        # Init face recognizer
        self.recognizer = FaceRecognizer()
        # self.recognizer = BypassFaceRecognizer()

        # Init web interfaces
        self.setPage(WebEnginePage(self))
        self.channel = QtWebChannel.QWebChannel()
        self.channel.registerObject("web_app_host", self)
        self.page().setWebChannel(self.channel)
        self.load(QUrl("http://localhost:9000/login"))
        self.show()

    @pyqtSlot(str, str, result=bool)
    def recognizeFace(self, username, image):
        success = self.recognizer.recognize(username, image)
        if success and self.checkUsername(username):
            self.dbcursor.execute(
                "SELECT student_id FROM student WHERE username = %s", (username,)
            )
            self.student_id = self.dbcursor.fetchone()[0]
            self.last_login_dt = datetime.now()
            
            q = 'SELECT email FROM student WHERE student_id = %s'
            self.dbcursor.execute(q, (self.student_id,))
            result = self.dbcursor.fetchone()
            if result is not None:
                self.student_email = result[0]

            # DEBUG
            print('student_id: ', self.student_id)
            print('last_login_dt: ', self.last_login_dt)
            print('student_email: ', self.student_email)

        return success

    @pyqtSlot()
    def recordLogout(self):
        if self.student_id is None:
            return
        login_dt_str = self.last_login_dt.strftime("%Y-%m-%d %H:%M:%S")
        now = datetime.now()
        logout_dt_str = now.strftime("%Y-%m-%d %H:%M:%S")
        self.dbcursor.execute(
            "INSERT INTO record (student_id, login_time, logout_time, duration) VALUES (%s, %s, %s, %s)",
            (
                self.student_id,
                login_dt_str,
                logout_dt_str,
                (now - self.last_login_dt).seconds,
            ),
        )
        self.myconn.commit()

    @pyqtSlot(str, result=bool)
    def checkUsername(self, username):
        self.dbcursor.execute("SELECT * FROM student WHERE username = %s", (username,))
        user = self.dbcursor.fetchone()
        if user is None:
            return False
        else:
            return True

    @pyqtSlot(result=str)
    def getLastLoginDtStr(self):
        return self.last_login_dt.strftime("%Y-%m-%d %H:%M:%S")

    @pyqtSlot(result=str)
    def getUsername(self):
        self.dbcursor.execute(
            "SELECT username FROM student WHERE student_id = %s", (self.student_id,)
        )
        usnername = self.dbcursor.fetchone()[0]
        if usnername is None:
            return ""
        return usnername

    @pyqtSlot(result=str)
    def getStudentEmail(self):
        return self.student_email

    @pyqtSlot(result=str)
    def getTimetable(self):
        q = """Select course_title, classroom, start_time, end_time, day from Student as s, hasCourse as hc, Course as c, TimeSlot as t
        where s.student_id = hc.student_id 
        and c.course_id = hc.course_id
        and t.timeSlot_id = c.timeSlot_id
        and s.student_id = %s
        ORDER BY day ASC, start_time ASC;"""
        self.dbcursor.execute(q, (self.student_id,))
        result = self.dbcursor.fetchall()

        return_json_dict = []

        for res in result:
            course_title, classroom, start_time, end_time, day = res
            return_json_dict.append(
                {
                    "course_title": course_title,
                    "classroom": classroom,
                    "start_time": str(start_time),
                    "end_time": str(end_time),
                    "day": day,
                }
            )

        return_json_str = json.dumps(return_json_dict)
        return return_json_str

    @pyqtSlot(result=str)
    def getUpcomingLesson(self):
        q = """Select c.course_id, course_title, classroom, start_time, end_time, message, zoomLink from Student as s, hasCourse as hc, Course as c, TimeSlot as t
        where s.student_id = hc.student_id 
        and c.course_id = hc.course_id
        and t.timeSlot_id = c.timeSlot_id
        and s.student_id = %s
        and day = WEEKDAY(CURDATE())
        and (CURRENT_TIME() between start_time and end_time OR TIMEDIFF(start_time, CURRENT_TIME()) between '00:00:00' and '01:00:00');"""
        self.dbcursor.execute(q, (self.student_id,))
        result = self.dbcursor.fetchone()

        if result is None:
            return ""

        (
            course_id,
            course_title,
            classroom,
            start_time,
            end_time,
            message,
            zoomLink,
        ) = result

        q = '''SELECT name, url FROM Resource WHERE course_id = %s'''
        self.dbcursor.execute(q, (course_id,))
        resources = self.dbcursor.fetchall()

        return json.dumps(
            {
                "course_title": course_title,
                "classroom": classroom,
                "start_time": str(start_time),
                "end_time": str(end_time),
                "message": message,
                "zoomLink": zoomLink,
                "resources": [{"name": r[0], "url": r[1]} for r in resources] if resources is not None else [],
            }
        )

    @pyqtSlot(str, result=bool)
    def updateStudentProfile(self, email: str):
        q = 'UPDATE Student SET email = %s WHERE student_id = %s'
        self.dbcursor.execute(q, (email, self.student_id))
        self.myconn.commit()

        return True

    @pyqtSlot(result=str)
    def emailMyself(self):
        data = self.getUpcomingLesson()

        if data == "":
            return "No upcoming lesson" # should not occur

        data = json.loads(data)

        body = f'''Course: {data['course_title']}
Classroom: {data['classroom']}
Time: {data['start_time']} - {data['end_time']}
Message: {data['message']}
Zoom Link: {data['zoomLink']}
Resources:\n''' + '\n'.join([f"        {r['name']}: {r['url']}" for r in data['resources']])

        status = requests.post(
        "https://api.mailgun.net/v3/sandbox183730ff4e7d4918b3576af185dd82bb.mailgun.org/messages",
        auth=("api", "1d36cbc327e7599f2f323ea1a76c392c-2de3d545-8fb76959"),
        data={"from": "uscheduler@sandbox183730ff4e7d4918b3576af185dd82bb.mailgun.org",
              "to": [self.student_email if self.student_email is not None else '@@@'], # deliberately trigger API to return 400 Bad Request
              "subject": "Your Upcoming Lesson",
              "text": body})
        return "Sent successfully!" if status.status_code == 200 else "Failed to send!"