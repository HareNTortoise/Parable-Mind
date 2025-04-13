"""
This module initializes and configures the FastAPI application.
It sets up the application with routes, logging, and custom OpenAPI schema.
"""

import os
from contextlib import asynccontextmanager
from fastapi import FastAPI, Request
from fastapi.openapi.utils import get_openapi
from fastapi.middleware.cors import CORSMiddleware
from config.logging_config import logger
from config.settings import settings

# Routers
from app.routes.ping import router as ping_router
from app.routes.context_generator import router as context_generator_router
from app.routes.mcq_variation_generator import router as mcq_variation_generator_router
from app.routes.msq_variation_generator import router as msq_variation_generator_router
from app.routes.variable_randomizer import router as variable_randomizer_router
from app.routes.variable_detector import router as variable_detector_router
from app.routes.question_segmentation import router as question_segmentation_router

# ─────────────────────────────────────────────────────────────────────────────

@asynccontextmanager
async def lifespan(app: FastAPI):
    logger.info("🔄 Application startup")
    yield
    logger.info("🔻 Application shutdown")

app = FastAPI(
    title=settings.APP_NAME,
    description="A simple AI microservice with a ping endpoint and logging.",
    version="1.0.0",
    docs_url="/docs",
    redoc_url=None,
    openapi_url="/openapi.json",
    contact={
        "name": "Support",
        "url": "https://example.com/support",
        "email": "support@example.com"
    },
    license_info={
        "name": "MIT",
        "url": "https://opensource.org/licenses/MIT",
    },
    lifespan=lifespan
)

# ─────────────────────────────────────────────────────────────────────────────

# 🌐 CORS configuration
origins = [
    "*"  # Change to your frontend URL in prod (e.g., "https://yourdomain.com")
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 🔐 Log key environment values
logger.info("🔧 App: %s", settings.APP_NAME)
logger.info("🔑 GOOGLE_API_KEY loaded: %s", bool(os.getenv("GOOGLE_API_KEY")))
logger.info("🚪 PORT set to: %s", os.getenv("PORT", "8000"))

# 🧠 Register routers
app.include_router(ping_router, prefix="", tags=["Ping"])
app.include_router(context_generator_router, prefix="", tags=["Context Generator"])
app.include_router(mcq_variation_generator_router, prefix="", tags=["MCQ Variation Generator"])
app.include_router(msq_variation_generator_router, prefix="", tags=["MSQ Variation Generator"])
app.include_router(variable_detector_router, prefix="", tags=["Variable Detector"])
app.include_router(variable_randomizer_router, prefix="", tags=["Variable Randomizer"])
app.include_router(question_segmentation_router, prefix="", tags=["Question Segmentation"])

# 📦 Custom OpenAPI schema
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

# ─────────────────────────────────────────────────────────────────────────────

# ✅ Health check endpoint
@app.get("/health", tags=["Health"])
async def health():
    return {"status": "ok"}

# ✅ Root endpoint
@app.get("/", tags=["Root"])
async def root():
    return {"message": f"{settings.APP_NAME} is running."}

# ✅ Log each request
@app.middleware("http")
async def log_requests(request: Request, call_next):
    logger.info(f"📥 {request.method} {request.url}")
    response = await call_next(request)
    logger.info(f"📤 Status code: {response.status_code}")
    return response

# ✅ Run via CLI: python main.py (for local testing)
if __name__ == "__main__":
    import uvicorn
    port = int(os.getenv("PORT", 8000))
    uvicorn.run("main:app", host="0.0.0.0", port=port, reload=False)
