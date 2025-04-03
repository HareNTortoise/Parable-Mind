# main.py
"""
This module initializes and configures the FastAPI application.
It sets up the application with routes, logging, and custom OpenAPI schema.
"""
from fastapi import FastAPI
from fastapi.openapi.utils import get_openapi
from app.routes.ping import router as ping_router
from app.routes.context_generator import router as context_generator_router
from config.logging_config import logger
from config.settings import settings


app = FastAPI(
    title=settings.APP_NAME,
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

logger.info("Starting %s", settings.APP_NAME)

app.include_router(ping_router, prefix="", tags=["Ping"])
app.include_router(context_generator_router, prefix="", tags=["Context Generator"])

# Custom OpenAPI Schema

def custom_openapi():
    """
    Generates a custom OpenAPI schema for the FastAPI application.

    Returns:
        dict: The OpenAPI schema.
    """
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
