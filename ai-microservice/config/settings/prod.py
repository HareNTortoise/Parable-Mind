# settings/prod.py
from pydantic_settings import BaseSettings


class ProdSettings(BaseSettings):
    APP_NAME: str = "AI Microservice - Prod"
    DEBUG: bool = False
    LOG_LEVEL: str = "WARNING"
