import os
from pydantic import BaseSettings
from config.settings import dev, test, prod


class Settings(BaseSettings):
    APP_NAME: str
    HOST: str
    PORT: int
    DEBUG: bool

    class Config:
        env_file = "../.env"


ENV = os.getenv("ENV", "dev")
if ENV == "dev":
    settings = dev.DevSettings()
elif ENV == "test":
    settings = test.TestSettings()
elif ENV == "prod":
    settings = prod.ProdSettings()
else:
    settings = dev.DevSettings()
