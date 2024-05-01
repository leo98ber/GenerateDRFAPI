#!/bin/bash

project_name=$1

function create_postgres_compose_service() {
  echo "
  postgres_server:
    build:
      context: .
      dockerfile: ./postgres/Dockerfile
    container_name: postgres_server
    ports:
      - 9432:5432
    networks:
      - postgres_net
    volumes:
      - /var/postgres_docker_data:/var/lib/postgresql/data
      - ./postgres/backup:/bash_backup

    env_file:
      - postgres/postgres_cfg.env

  postgres_create_user:

    image: postgres
    container_name: postgres_client

    volumes:
      - ./postgresql/start:/start

    env_file:
      - postgres/mariadb_cfg.env
    networks:
      - postgres_net

    command: sh -c 'sleep 10 && sh ./start'
  " >> ./docker-compose.yml

  echo "Postgres compose service added successfully!"

}