# main.py
"""
This module initializes and configures the FastAPI application.
It sets up the application with routes, logging, and custom OpenAPI schema.
"""
from fastapi import FastAPI
from fastapi.openapi.utils import get_openapi
import uvicorn
from app.routes.ping import router as ping_router
from app.routes.context_generator import router as context_generator_router
from app.routes.mcq_variation_generator import router as mcq_variation_generator_router
from app.routes.msq_variation_generator import router as msq_variation_generator_router
from app.routes.variable_randomizer import router as variable_randomizer_router
from app.routes.variable_detector import router as variable_detector_router
from app.routes.question_segmentation import router as question_segmentation_router
from config.logging_config import logger
from config.settings import settings
from fastapi.middleware.cors import CORSMiddleware


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

origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


logger.info("Starting %s", settings.APP_NAME)

app.include_router(ping_router, prefix="", tags=["Ping"])
app.include_router(context_generator_router, prefix="",
                   tags=["Context Generator"])
app.include_router(mcq_variation_generator_router,
                   prefix="", tags=["MCQ Variation Generator"])
app.include_router(msq_variation_generator_router,
                   prefix="", tags=["MSQ Variation Generator"])
app.include_router(variable_detector_router,
                   prefix="", tags=["Variable Detector"])
app.include_router(variable_randomizer_router,
                   prefix="", tags=["Variable Randomizer"])
app.include_router(question_segmentation_router,
                   prefix="", tags=["Question Segmentation"])


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
