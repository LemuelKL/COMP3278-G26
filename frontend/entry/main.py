# from faces import do_face_reg
import sys

from PyQt5.QtWidgets import QApplication, QMainWindow, QFrame
from webapp import WebApp

if __name__ == "__main__":
    app = QApplication(sys.argv)

    app.setApplicationName("UScheduler")

    web_app = WebApp()

    win = QMainWindow()
    win.setCentralWidget(web_app)
    win.resize(1280, 720)
    win.show()

    sys.exit(app.exec_())
