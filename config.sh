#!/bin/bash

# Actualizar paquetes
sudo yum update -y

# Instalar git y python3
sudo yum install -y git python3 python3-venv

# Crear carpeta del proyecto
mkdir -p /home/ec2-user/app
cd /home/ec2-user/app

# Clonar el repositorio
git clone https://github.com/PedroJuanHenaoVelez/Taller-EC2.git apprepo

# Entrar al repositorio descargado
cd apprepo

# Crear entorno virtual
python3 -m venv /home/ec2-user/app/venv

# Activar entorno virtual
source /home/ec2-user/app/venv/bin/activate

# Instalar dependencias
pip install --upgrade pip
pip install -r requirements.txt

# Copiar el servicio systemd
sudo cp fastapi.service /etc/systemd/system/fastapi.service

# Recargar systemd
sudo systemctl daemon-reload

# Habilitar el servicio al iniciar EC2
sudo systemctl enable fastapi.service

# Iniciar el servicio
sudo systemctl start fastapi.service

echo "Instalación completada. El servicio FastAPI está ejecutándose."
