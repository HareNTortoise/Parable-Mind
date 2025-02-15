# ping.py
from fastapi import APIRouter
from config.logging_config import logger

router = APIRouter()

@router.get("/ping", summary="Ping API", description="Returns a simple ping response.", response_description="A JSON object with a ping message.")
def ping():
    logger.info("Ping endpoint was accessed")
    return {"message": "ping"}