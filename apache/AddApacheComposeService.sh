#!/bin/bash

project_name=$1

function create_apache_compose_file() {
  echo "
  apache2-container:
    build: ./apache
    image: ubuntu/apache2:2.4-22.04_beta
    restart: always
    container_name: apache2_container_${project_name}
    command: ./setup.sh
    environment:
      - TZ=UTC
    ports:
      - 9088:9088
    networks:
      - django_net
    depends_on:
      - django_server
    volumes:
      - /var/${project_name}/log/apache2/:/var/log/apache2/api
      - /etc/${project_name}/apache2/sites-available/:/etc/apache2/sites-available/

  " >> ./docker-compose-production.yml

  echo "Apache compose service added successfully!"

}