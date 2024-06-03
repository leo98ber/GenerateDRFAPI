#!/bin/bash

function create_django_compose_file() {
  echo "
version: '3'
services:
  django_server:
    build:
      context: .
      dockerfile: django/development/Dockerfile
    command: bash ./django/development/start
    container_name: django_service_${project_name}
    networks:
      - django_net
    volumes:
      - .:/code
    env_file:
      - django/development/api.env
    ports:
      - '8000:8000'

  " >> ./docker-compose-development.yml

  echo "Development docker compose file generated successfully!"
  echo -e "\n"

  echo "
version: '3'
services:
  django_server:
    build:
      context: .
      dockerfile: django/production/Dockerfile
    command: bash ./django/production/start
    container_name: django_service_${project_name}
    networks:
      - django_net
    volumes:
      - .:/code
    env_file:
      - django/production/api.env
    ports:
      - '8000:8000'

  " >> ./docker-compose-production.yml

  echo "Production docker compose file generated successfully!"
  echo -e "\n"

}





