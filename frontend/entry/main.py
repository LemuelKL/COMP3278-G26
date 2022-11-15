# from faces import do_face_reg
import sys
from PyQt5.QtWidgets import QApplication

from webapp import WebApp

if __name__ == "__main__":
    app = QApplication(sys.argv)
    web_app = WebApp()
    web_app.show()
    sys.exit(app.exec_())
