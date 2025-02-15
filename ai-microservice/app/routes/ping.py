# ping.py
"""
This module defines the ping endpoint for the FastAPI application.
It includes a simple GET endpoint that returns a ping response.
"""
from fastapi import APIRouter
from config.logging_config import logger

router = APIRouter()


@router.get(
    "/ping",
    summary="Ping API",
    description="Returns a simple ping response.",
    response_description="A JSON object with a ping message.",
)
def ping():
    """
    Handles the GET request for the ping endpoint.

    Returns:
        dict: A JSON object with a ping message.
    """
    logger.info("Ping endpoint was accessed")
    return {"message": "ping"}
