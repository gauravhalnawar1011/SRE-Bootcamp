import logging
import json

def setup_logging():
    logging.basicConfig(level=logging.INFO, format='%(message)s')
    return logging.getLogger(__name__)

logger = setup_logging()