import sys
from PyQt5.QtCore import *
from PyQt5.QtWebEngineWidgets import *

from PyQt5 import QtWebChannel


class WebApp(QWebEngineView):
    def __init__(self, parent=None):
        super().__init__(parent)

        self.load(QUrl("http://localhost:9000/login"))

        # Create a QWebChannel instance
        self.channel = QtWebChannel.QWebChannel()
        self.channel.registerObject("web_app_host", self)
        self.page().setWebChannel(self.channel)
        self.show()

    @pyqtSlot(str)
    def sayMsg(self, msg):
        print(msg)


