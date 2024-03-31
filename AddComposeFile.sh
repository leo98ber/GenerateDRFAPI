#!/bin/bash

function create_django_compose_file() {
  cat <<EOF >docker-compose.yml
version: '3'

services:
  django_server:
    build: ./django
    command: bash ./django/start
    container_name: django_service
    volumes:
      - .:/code
    env_file:
      - ./api.env
    ports:
      - "8000:8000"
EOF
  echo "Docker compose file generated successfully!"
  echo -e "\n" # Salto de linea
}





