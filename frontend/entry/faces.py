

# def do_face_reg() -> str:
#     # Define camera and detect face
    
#     cap = cv2.VideoCapture(0)

#     # 3 Open the camera and start face recognition
#     while True:
#         ret, frame = cap.read()
        

#         for (x, y, w, h) in faces:
#             print(x, w, y, h)
#             roi_gray = gray[y:y + h, x:x + w]
#             roi_color = frame[y:y + h, x:x + w]
#             # predict the id and confidence for faces
#             id_, conf = recognizer.predict(roi_gray)

#             # If the face is recognized
#             if conf >= 60:
#                 # print(id_)
#                 # print(labels[id_])
#                 font = cv2.QT_FONT_NORMAL
#                 id = 0
#                 id += 1
#                 name = labels[id_]
#                 current_name = name
#                 color = (255, 0, 0)
#                 stroke = 2
#                 cv2.putText(frame, name, (x, y), font, 1, color, stroke, cv2.LINE_AA)
#                 cv2.rectangle(frame, (x, y), (x + w, y + h), (255, 0, 0), (2))

#                 # Find the student's information in the database.
#                 select = "SELECT student_id, name, DAY(login_date), MONTH(login_date), YEAR(login_date) FROM Student WHERE name='%s'" % (name)
#                 name = cursor.execute(select)
#                 result = cursor.fetchall()
#                 # print(result)
#                 data = "error"

#                 for x in result:
#                     data = x

#                 # If the student's information is not found in the database
#                 if data == "error":
#                     print("The student", current_name, "is NOT FOUND in the database.")

#                 # If the student's information is found in the database
#                 else:
#                     # Update the data in database
#                     update =  "UPDATE Student SET login_date=%s WHERE name=%s"
#                     val = (date, current_name)
#                     cursor.execute(update, val)
#                     update = "UPDATE Student SET login_time=%s WHERE name=%s"
#                     val = (current_time, current_name)
#                     cursor.execute(update, val)
#                     myconn.commit()

#                     cap.release()
#                     cv2.destroyAllWindows()
#                     return current_name
#                     """
#                     Implement useful functions here.
#                     Check the course and classroom for the student.
#                         If the student has class room within one hour, the corresponding course materials
#                             will be presented in the GUI.
#                         if the student does not have class at the moment, the GUI presents a personal class 
#                             timetable for the student.

#                     """
                
#                     hello = ("Hello ", current_name, "You did attendance today")
#                     print(hello)


