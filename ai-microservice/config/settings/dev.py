from pydantic_settings import BaseSettings


class DevSettings(BaseSettings):
    APP_NAME: str = "AI Microservice - Dev"
    DEBUG: bool = True
    LOG_LEVEL: str = "DEBUG"
