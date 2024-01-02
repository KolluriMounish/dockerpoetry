from pydantic import BaseModel
from datetime import date
from .models import TaskStatus
# from enum import Enum

# class TaskStatus(str, Enum):
#     PENDING = 'pending'
#     IN_PROGRESS = 'in progress'
#     COMPLETED = 'completed'


class Task(BaseModel):
    title: str
    description: str
    status: TaskStatus
    due_date: date


class User(BaseModel):
    name : str
    email : str
    password : str

# class ShowTask(Task):
#     class Config():
#         orm_model = True

# class ShowTask(BaseModel):
#     title: str
#     description: str
#     status: TaskStatus
#     due_date: date
#     class Config():
#         orm_model = True

# class UpdateTask(BaseModel):
#     id: int
#     title: str
#     description: str
#     status: TaskStatus
#     due_date: date

# class CreateTask(BaseModel):
#     # id: int
#     title: str
#     description: str
#     status: TaskStatus
#     due_date: date
    # class Config:
    #     schema_extra = {
    #         "example": {
    #             "id": 1,
    #             "title": "My Task",
    #             "description": "This is my task",
    #             "status": "not_started",
    #             "due_date": "2022-01-01",
    #         }
    #     }