import os
from pydantic import BaseSettings
from ai_microservice.config.settings import dev, test, prod

class Settings(BaseSettings):
    APP_NAME: str
    HOST: str
    PORT: int
    DEBUG: bool
    
    class Config:
        env_file = f"../.env"

ENV = os.getenv("ENV", "dev")
if ENV == "dev":
    settings = dev.Settings()
elif ENV == "test":
    settings = test.Settings()
elif ENV == "prod":
    settings = prod.Settings()
else:
    settings = dev.Settings()
