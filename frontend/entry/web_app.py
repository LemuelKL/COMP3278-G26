import sys
from PyQt5.QtCore import *
from PyQt5.QtWebEngineWidgets import *
from PyQt5.QtWidgets import QApplication

def run(username: str):
    app = QApplication(sys.argv)

    web = QWebEngineView()
    web.load(QUrl(f"http://localhost:9000/login/{username}"))
    web.show()

    sys.exit(app.exec_())