from faces import do_face_reg
from web_app import run

if __name__ == "__main__":
    username = do_face_reg()
    print("Username:", username)
    run(username)
