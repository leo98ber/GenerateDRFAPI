#!/bin/bash

function create_django_compose_file() {
  echo "
  django_server:
    build: ./django
    command: bash ./django/start
    container_name: django_service_${project_name}
    networks:
      - django_net
    volumes:
      - .:/code
    env_file:
      - ./api.env
    ports:
      - 8000:8000

  " >> ./docker-compose.yml

  echo "Docker compose file generated successfully!"
  echo -e "\n"
}





