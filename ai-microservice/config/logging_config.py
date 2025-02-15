import logging
import sys

LOG_FORMAT = "%(asctime)s - %(levelname)s - %(name)s - %(message)s"

logging.basicConfig(
    level=logging.INFO,
    format=LOG_FORMAT,
    handlers=[
        logging.StreamHandler(sys.stdout),
        logging.FileHandler("ai_microservice.log", mode='a')
    ]
)

logger = logging.getLogger("AI Microservice")
