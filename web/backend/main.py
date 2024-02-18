from fastapi import FastAPI
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware


app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allows all origins for simplicity, adjust in production
    allow_credentials=True,
    allow_methods=["*"],  # Allows all methods
    allow_headers=["*"],  # Allows all headers
)


class EditParams(BaseModel):
    url: str
    options: dict


@app.post("/")
async def handle_post(params: EditParams):
    # Process the incoming data
    print("Data received")
    return {"message": "Data received", "data": params.model_dump()}
