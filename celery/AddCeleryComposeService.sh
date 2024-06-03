#!/bin/bash

project_name=$1

function create_celery_compose_file() {
  echo "
  celery-worker:
    container_name: celery_worker_service_${project_name}
    build:
      context: .
      dockerfile: django/development/Dockerfile
    volumes:
      - .:/code
    command: celery -A ${project_name}.celery_cfg worker --loglevel=info
    env_file:
      - django/development/api.env
    depends_on:
      - redis
      - django_server
    networks:
      - django_net

  celery-beat:
    container_name: celery_beat_service_${project_name}
    build:
      context: .
      dockerfile: django/development/Dockerfile
    volumes:
      - .:/code
    command: celery -A ${project_name}.celery_cfg beat --loglevel=info
    env_file:
      - django/development/api.env
    depends_on:
      - redis
      - django_server
    networks:
      - django_net
  " >> ./docker-compose-development.yml


    echo "
  celery-worker:
    container_name: celery_worker_service_${project_name}
    build:
      context: .
      dockerfile: django/production/Dockerfile
    volumes:
      - .:/code
    command: celery -A ${project_name}.celery_cfg worker --loglevel=info
    env_file:
      - django/production/api.env
    depends_on:
      - redis
      - django_server
    networks:
      - django_net

  celery-beat:
    container_name: celery_beat_service_${project_name}
    build:
      context: .
      dockerfile: django/production/Dockerfile
    volumes:
      - .:/code
    command: celery -A ${project_name}.celery_cfg beat --loglevel=info
    env_file:
      - django/production/api.env
    depends_on:
      - redis
      - django_server
    networks:
      - django_net
  " >> ./docker-compose-production.yml

  echo "Celery compose service added successfully!"

}