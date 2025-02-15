import os
from config.settings.dev import DevSettings
from config.settings.test import TestSettings
from config.settings.prod import ProdSettings

ENV = os.getenv("ENV", "dev")

if ENV == "dev":
    settings = DevSettings()
elif ENV == "test":
    settings = TestSettings()
elif ENV == "prod":
    settings = ProdSettings()
else:
    settings = DevSettings()
