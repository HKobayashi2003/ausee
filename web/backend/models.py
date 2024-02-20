from pydantic import BaseModel


class EditParams(BaseModel):
    url: str
    options: dict
