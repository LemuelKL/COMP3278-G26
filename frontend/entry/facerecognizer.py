import base64
import numpy as np
import cv2
import pickle


class FaceRecognizer:
    def __init__(self):
        # Load recognize and read label from model
        self.recognizer = cv2.face.LBPHFaceRecognizer_create()
        self.recognizer.read("train.yml")
        print("Face recognizer model loaded")

        # Load labels
        self.labels = {"person_name": 1}
        with open("labels.pickle", "rb") as f:
            self.labels = pickle.load(f)
            self.labels = {v: k for k, v in self.labels.items()}
        print("Labels loaded")

    def readb64(self, uri):
        encoded_data = uri.split(",")[1]
        nparr = np.fromstring(base64.b64decode(encoded_data), np.uint8)
        img = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
        return img

    def recognize(self, username: str, image: str) -> bool:
        frame = self.readb64(image)
        face_cascade = cv2.CascadeClassifier(
            "haarcascade/haarcascade_frontalface_default.xml"
        )
        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        faces = face_cascade.detectMultiScale(gray, scaleFactor=1.5, minNeighbors=5)
        for (x, y, w, h) in faces:
            roi_gray = gray[y : y + h, x : x + w]
            id_, conf = self.recognizer.predict(roi_gray)
            if conf >= 60:
                pred_username = self.labels[id_]
                if pred_username == username:
                    return True

        return False
