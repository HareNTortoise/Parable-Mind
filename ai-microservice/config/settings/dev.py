# dev.py
from pydantic import BaseSettings
class Settings(BaseSettings):
    APP_NAME: str = "AI Microservice - Dev"
    HOST: str = "0.0.0.0"
    PORT: int = 8000
    DEBUG: bool = True