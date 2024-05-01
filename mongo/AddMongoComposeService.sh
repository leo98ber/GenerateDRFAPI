#!/bin/bash

project_name=$1

function create_mongo_compose_service() {
  echo "
  mongodb:
    image: mongo
    restart: always
    container_name: mongoserver
    volumes:
      - /var/mongodata/db:/data/db
      - /var/mongodata/mongod.conf:/etc/mongod.conf
      - ./mongo/backup:/bash_backup
    ports:
      - 27018:27017

    env_file:
      - mongo/mongo_cfg.env

    networks:
      - mongo_net

  mongo_create_user:
    build:
      context: .
      dockerfile: ./mongo/Dockerfile

    container_name: container_to_create_mongo_user

    env_file:
      - mongo/mongo_cfg.env
    networks:
      - mongo_net
    depends_on:
      - mongodb

    command: sh -c 'sleep 10 && sh ./tmp/start'
  " >> ./docker-compose.yml

  echo "Mongo compose service added successfully!"

}