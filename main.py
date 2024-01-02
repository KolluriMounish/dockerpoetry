import uvicorn
from fastapi import FastAPI
from app.routers import default
from app.config import settings


def include_router(app):
    app.include_router(default.router)


def start_application():
    app= FastAPI(title=settings.APP_TITLE, version=settings.APP_VERSION, host= settings.APP_HOST, port=settings.APP_PORT)
    include_router(app)
    return app

app = start_application()

# if __name__ == '__main__':
#     app=start_application()
#     uvicorn.run(app,host=settings.APP_HOST,port=int(settings.APP_PORT))
# @app.get("/")
# def read_root():
#     return {"Hello": "World"}