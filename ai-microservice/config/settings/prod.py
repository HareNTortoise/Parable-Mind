# prod.py
from pydantic import BaseSettings
class Settings(BaseSettings):
    APP_NAME: str = "AI Microservice - Prod"
    HOST: str = "0.0.0.0"
    PORT: int = 8002
    DEBUG: bool = False