# COMP3278 Group 26

## Stack

- VueJS 3
- Quasar
- PyQt
- MySQL
- OpenCV

## Technical Notes

- A VueJS 3 web app is hosted
- PyQt is used to create a native desktop app instance
- This instance has a webview that loads the VueJS app
- The video capture is done on the web app, and some frames are sent to the PyQt instance for the facial recognition
- The transfer of frames, and all communications between the Vue and PyQt instance are done via a Qt's `QWebChannel` and `QWebChannelAbstractTransport`
- The facial recognition is done on the PyQt side with OpenCV, and the result is sent back to the web app
- It is the PyQt instance's responsibility to keep track of the student's attendance
- The Vue app is responsible for the UI
- The PyQt exposes a API to the Vue app using Qt's Signals and Slots
- THe Vue app talks to this API for all the data it needs
- The PyQt instance talks to the MySQL database directly.

## Setup

### VueJS and Quasar

To proceed you need NodeJS, NPM, and Quasar CLI installed.

Then, under `/app`, install the packages:
```bash
npm install
```

To run:
```bash
quasar dev
```

### PyQt

To proceed you need Python 3 (3.10.5 tested) and pip3 installed.

Then, under `/host`, create a virtual environment and install the packages:
```bash
python -m venv .ve
./.ve/scripts/activate
pip install -r requirements.txt
```

To run:
```bash
python main.py
```

### MySQL Database

Install the MySQL database on your own. Then execute `reference/DB_query.sql`, it will set up the database schema and populate it with some dummy data.
