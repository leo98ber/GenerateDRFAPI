#!/bin/bash

project_name=$1

function create_redis_compose_file() {
  echo "
  redis:
    image: redis:latest
    container_name: redis_service_${project_name}
    ports:
      - '6379:6379'
    networks:
      - django_net
  " >> ./docker-compose-production.yml

  echo "
  redis:
    image: redis:latest
    container_name: redis_service_${project_name}
    ports:
      - '6379:6379'
    networks:
      - django_net
  " >> ./docker-compose-development.yml


  echo "Redis compose service added successfully!"

}