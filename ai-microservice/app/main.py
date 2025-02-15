# main.py
from fastapi import FastAPI
from fastapi.openapi.utils import get_openapi
from app.routes.ping import router as ping_router
from config.logging_config import logger

app = FastAPI(
    title="AI Microservice",
    description="A simple AI microservice with a ping endpoint and logging.",
    version="1.0.0",
    contact={
        "name": "Support",
        "url": "https://example.com/support",
        "email": "support@example.com"
    },
    license_info={
        "name": "MIT",
        "url": "https://opensource.org/licenses/MIT",
    }
)

logger.info("Starting AI Microservice")

app.include_router(ping_router, prefix="", tags=["Ping"])

# Custom OpenAPI Schema

def custom_openapi():
    if app.openapi_schema:
        return app.openapi_schema
    openapi_schema = get_openapi(
        title=app.title,
        version=app.version,
        description=app.description,
        routes=app.routes,
    )
    app.openapi_schema = openapi_schema
    return app.openapi_schema

app.openapi = custom_openapi