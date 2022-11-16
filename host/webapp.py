from datetime import datetime
import json

import mysql.connector
from facerecognizer import FaceRecognizer
from PyQt5 import QtWebChannel
from PyQt5.QtCore import *
from PyQt5.QtWebEngineWidgets import *


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
        self.myconn = mysql.connector.connect(
            host="localhost",
            user="lemuelkl",
            passwd="294887601",
            database="facerecognition",
        )
        self.dbcursor = self.myconn.cursor()
        print("Connected to database")

        # holds
        self.student_id = None
        self.last_login_dt = None

        # Init face recognizer
        # self.recognizer = FaceRecognizer()
        self.recognizer = BypassFaceRecognizer()

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
    def getTimetable(self):
        q = """Select course_title, classroom, start_time, end_time from Student as s, hasCourse as hc, Course as c, TimeSlot as t
        where s.student_id = hc.student_id 
        and c.course_id = hc.course_id
        and t.timeSlot_id = c.timeSlot_id
        and s.student_id = %s"""
        self.dbcursor.execute(q, (self.student_id,))
        result = self.dbcursor.fetchall()

        return_json_dict = []

        for res in result:
            course_title, classroom, start_time, end_time = res
            return_json_dict.append(
                {
                    "course_title": course_title,
                    "classroom": classroom,
                    "start_time": str(start_time),
                    "end_time": str(end_time),
                }
            )

        return_json_str = json.dumps(return_json_dict)
        return return_json_str

    @pyqtSlot(result=str)
    def getUpcomingLesson(self):
        q = """Select course_title, classroom, start_time, end_time, message, zoomLink, notes, other from Student as s, hasCourse as hc, Course as c, TimeSlot as t
        where s.student_id = hc.student_id 
        and c.course_id = hc.course_id
        and t.timeSlot_id = c.timeSlot_id
        and s.student_id = %s
        and day = WEEKDAY(CURDATE())
        and (CURRENT_TIME() between start_time and end_time OR TIMEDIFF('01:30',    CURRENT_TIME()) < '01:00');"""
        self.dbcursor.execute(q, (self.student_id,))
        result = self.dbcursor.fetchone()

        if result is None:
            return ""

        (
            course_title,
            classroom,
            start_time,
            end_time,
            message,
            zoomLink,
            notes,
            other,
        ) = result
        return json.dumps(
            {
                "course_title": course_title,
                "classroom": classroom,
                "start_time": str(start_time),
                "end_time": str(end_time),
                "message": message,
                "zoomLink": zoomLink,
                "notes": notes,
                "other": other,
            }
        )

    @pyqtSlot(str)
    def updateStudentProfile(self, username: str):
        q = 'UPDATE Student SET username = %s WHERE student_id = %s'
        self.dbcursor.execute(q, (username, self.student_id))
        self.myconn.commit()
