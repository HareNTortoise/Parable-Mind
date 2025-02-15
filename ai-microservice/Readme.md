# README.md
# AI Microservice

This is a simple AI microservice built with FastAPI.

## Features
- A single `/ping` endpoint that returns `{ "message": "ping" }`.
- Logging configuration to track service events.
- Structured project directory for scalability.
- OpenAPI documentation available at `/docs` and `/redoc`.

## Installation
```sh
pip install -r requirements.txt
```

## Running the Service
```sh
uvicorn app.main:app --host 0.0.0.0 --port 8000
```

## API Endpoints
| Method | Endpoint | Description |
|--------|---------|-------------|
| GET    | `/ping` | Returns `{ "message": "ping" }` |

## OpenAPI Documentation
Once the server is running, visit:
- [Swagger UI](http://127.0.0.1:8000/docs)
- [ReDoc UI](http://127.0.0.1:8000/redoc)

## Logging
Logs are stored in `ai_microservice.log`.

## License
MIT
