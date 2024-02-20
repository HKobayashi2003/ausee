from fastapi import FastAPI, HTTPException
from fastapi.responses import StreamingResponse
from google.cloud import storage
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
from contextlib import asynccontextmanager
import os
from fastapi import FastAPI
from models import EditParams


@asynccontextmanager
async def app_lifespan(app: FastAPI):
    os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = (
        "/Users/hagiwaraleo/Development/ausee/web/secrets/ausee-414122-7e66ca065828.json"
    )
    yield  # The application starts serving requests here
    # Any cleanup can go here, after yield


app = FastAPI(lifespan=app_lifespan)
storage_client = storage.Client()


app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allows all origins for simplicity, adjust in production
    allow_credentials=True,
    allow_methods=["*"],  # Allows all methods
    allow_headers=["*"],  # Allows all headers
)


@app.post("/")
async def handle_post(params: EditParams):
    # Process the incoming data
    print("Data received")
    return {"message": "Data received", "data": params.model_dump()}
