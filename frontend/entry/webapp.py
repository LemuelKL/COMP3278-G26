import sys
from PyQt5.QtCore import *
from PyQt5.QtWebEngineWidgets import *
from PyQt5 import QtWebChannel

import base64
import numpy as np
import mysql.connector
import cv2
import pickle
from datetime import datetime

class FaceRecognizer:
    def __init__(self):
        # 1 Create database connection
        self.myconn = mysql.connector.connect(host="localhost", user="lemuelkl", passwd="294887601", database="facerecognition")
        self.date = datetime.utcnow()
        self.now = datetime.now()
        self.current_time = self.now.strftime("%H:%M:%S")
        self.cursor = self.myconn.cursor()
        print("Connected to database")

        #2 Load recognize and read label from model
        self.recognizer = cv2.face.LBPHFaceRecognizer_create()
        self.recognizer.read("train.yml")
        print("Face recognizer model loaded")

        #3 Load labels
        self.labels = {"person_name": 1}
        with open("labels.pickle", "rb") as f:
            self.labels = pickle.load(f)
            self.labels = {v: k for k, v in self.labels.items()}
        print("Labels loaded")


    def readb64(self, uri):
        encoded_data = uri.split(',')[1]
        nparr = np.fromstring(base64.b64decode(encoded_data), np.uint8)
        img = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
        return img

    def recognize(self, username: str, image: str) -> bool:
        frame = self.readb64(image)
        face_cascade = cv2.CascadeClassifier('haarcascade/haarcascade_frontalface_default.xml')
        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        faces = face_cascade.detectMultiScale(gray, scaleFactor=1.5, minNeighbors=5)
        for (x, y, w, h) in faces:
            roi_gray = gray[y:y + h, x:x + w]
            id_, conf = self.recognizer.predict(roi_gray)
            if (conf >= 60):
                pred_username = self.labels[id_]
                if (pred_username == username):
                    return True

        return False
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


class WebApp(QWebEngineView):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.recognizer = FaceRecognizer()

        self.setPage(WebEnginePage(self))
        self.channel = QtWebChannel.QWebChannel()
        self.channel.registerObject("web_app_host", self)
        self.page().setWebChannel(self.channel)
        self.load(QUrl("http://localhost:9000/login"))
        self.show()

    @pyqtSlot(str)
    def sayMsg(self, msg):
        print(msg)

    @pyqtSlot(str, str, result=bool)
    def recognizeFace(self, username, image):
        return self.recognizer.recognize(username, image)
