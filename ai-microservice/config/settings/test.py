# settings/test.py
from pydantic_settings import BaseSettings


class TestSettings(BaseSettings):
    APP_NAME: str = "AI Microservice - Test"
    DEBUG: bool = False
    LOG_LEVEL: str = "INFO"
