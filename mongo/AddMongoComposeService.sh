#!/bin/bash

project_name=$1

function create_mongo_compose_service() {
  echo "
  mongodb:
    image: mongo
    restart: always
    container_name: mongoserver_${project_name}
    volumes:
      - /var/${project_name}/mongodata/db:/data/db
      - /var/${project_name}/mongodata/mongod.conf:/etc/mongod.conf
      - ./mongo/backup:/bash_backup
    ports:
      - 27017:27017

    env_file:
      - mongo/mongo_cfg.env

    networks:
      - django_net

  mongo_create_user:
    build:
      context: .
      dockerfile: ./mongo/Dockerfile

    container_name: container_to_create_mongo_user_${project_name}

    env_file:
      - mongo/mongo_cfg.env
    networks:
      - django_net
    depends_on:
      - mongodb

    command: sh -c 'sleep 10 && sh ./tmp/start'
  " >> ./docker-compose-development.yml


  echo "
  mongodb:
    image: mongo
    restart: always
    container_name: mongoserver_${project_name}
    volumes:
      - /var/${project_name}/mongodata/db:/data/db
      - /var/${project_name}/mongodata/mongod.conf:/etc/mongod.conf
      - ./mongo/backup:/bash_backup
    ports:
      - 27017:27017

    env_file:
      - mongo/mongo_cfg.env

    networks:
      - django_net

  mongo_create_user:
    build:
      context: .
      dockerfile: ./mongo/Dockerfile

    container_name: container_to_create_mongo_user_${project_name}

    env_file:
      - mongo/mongo_cfg.env
    networks:
      - django_net
    depends_on:
      - mongodb

    command: sh -c 'sleep 10 && sh ./tmp/start'
  " >> ./docker-compose-production.yml

  echo "Mongo compose service added successfully!"

}