# test.py
from pydantic import BaseSettings
class Settings(BaseSettings):
    APP_NAME: str = "AI Microservice - Test"
    HOST: str = "0.0.0.0"
    PORT: int = 8001
    DEBUG: bool = False