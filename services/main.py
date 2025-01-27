
import uvicorn

if __name__ == "__main__":
    uvicorn.run(
        "api.routes:app",
        host="0.0.0.0",
        port=8000,
        reload=True,  # Enable auto-reload
        workers=1,  # Number of worker processes
        log_level="info",
    )
    