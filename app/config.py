import os

class Config:
    DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://admin:admin@localhost:5433/students_db")
    SQLALCHEMY_DATABASE_URI = DATABASE_URL
    SQLALCHEMY_TRACK_MODIFICATIONS = False
