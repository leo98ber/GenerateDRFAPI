#!/bin/bash

project_name=$1

function create_celery_compose_file() {
  echo "
  redis:
    image: redis:latest
    container_name: redis_service
    ports:
      - '6379:6379'

  celery-worker:
    container_name: celery_worker_service
    build:
      context: ./django
      dockerfile: Dockerfile
    volumes:
      - .:/code
    command: celery -A ${project_name}.celery_cfg worker --loglevel=info
    env_file:
      - ./api.env
    depends_on:
      - redis
      - django_server

  celery-beat:
    container_name: celery_beat_service
    build:
      context: ./django
      dockerfile: Dockerfile
    volumes:
      - .:/code
    command: celery -A ${project_name}.celery_cfg beat --loglevel=info
    env_file:
      - ./api.env
    depends_on:
      - redis
      - django_server
  " >> ./docker-compose.yml

  echo "Celery compose service added successfully!"

}