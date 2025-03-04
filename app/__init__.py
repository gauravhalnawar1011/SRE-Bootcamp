import sys
import os
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

# Ensure the root directory is in Python's path
sys.path.append(os.path.abspath(os.path.dirname(__file__)))

from config import Config  # ✅ Ensure correct config import

# Initialize database
db = SQLAlchemy()
migrate = Migrate()  # ✅ Added Flask-Migrate for handling migrations

def create_app():
    app = Flask(__name__)
    
    # Load configuration
    app.config.from_object(Config)

    # Initialize extensions
    db.init_app(app)
    migrate.init_app(app, db)  # ✅ Initialize Flask-Migrate

    # Import and register Blueprints after initializing db
    from app.routes import student_bp  # ✅ Import Blueprint
    app.register_blueprint(student_bp)  # ✅ Register Blueprint

    return app
