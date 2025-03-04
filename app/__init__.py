from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_limiter import Limiter
from flask_limiter.util import get_remote_address
from .config import Config

# Initialize Flask app
app = Flask(__name__)
app.config.from_object(Config)

# Initialize extensions
db = SQLAlchemy(app)
migrate = Migrate(app, db)

# Use in-memory storage for rate limiter (removes Redis dependency)
limiter = Limiter(get_remote_address, app=app, default_limits=["100 per minute"], storage_uri="memory://")

from . import routes  # Import routes