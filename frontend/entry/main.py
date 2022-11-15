import sys
from PyQt5.QtWidgets import QApplication, QMainWindow, QFrame
from webapp import WebApp

class UScheduler():
    def __init__(self):
        self.app = QApplication(sys.argv)
        self.app.setApplicationName("UScheduler")
        self.main_window = QMainWindow()
        self.main_window.setCentralWidget(WebApp())
        self.main_window.resize(1280, 720)
        
    def run(self):
        self.main_window.show()
        sys.exit(self.app.exec_())

if __name__ == "__main__":
    uscheduler = UScheduler()
    uscheduler.run()
