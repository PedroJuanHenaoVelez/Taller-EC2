from fastapi import FastAPI
from pydantic import BaseModel
import boto3
import json
import uuid

app = FastAPI()

# Nombre del bucket
BUCKET_NAME = "taller-ec2-so"

# Modelo de persona
class Persona(BaseModel):
    nombre: str
    edad: int
    correo: str
    cedula: str

# Cliente de S3
s3 = boto3.client("s3")

@app.post("/insert")
def insert_persona(persona: Persona):
    # Convertir a JSON
    data_json = persona.dict()

    # Nombre único del archivo
    file_name = f"{uuid.uuid4()}.json"

    # Subir a S3
    s3.put_object(
        Bucket=BUCKET_NAME,
        Key=file_name,
        Body=json.dumps(data_json)
    )

    # Contar cuantos archivos hay en el bucket
    response = s3.list_objects_v2(Bucket=BUCKET_NAME)
    total_archivos = response.get("KeyCount", 0)

    return {"archivos_actuales": total_archivos}
