import os

class Config:
    DATABASE_URL = os.getenv("DATABASE_URL", "sqlite:///students.db")
    SQLALCHEMY_DATABASE_URI = DATABASE_URL
    SQLALCHEMY_TRACK_MODIFICATIONS = False