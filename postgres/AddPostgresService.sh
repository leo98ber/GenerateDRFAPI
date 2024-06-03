#!/bin/bash

project_path=$1
current_path=$2

source ./postgres/AddPostgresComposeService.sh
source ./postgres/AddPostgresInSettings.sh
source ./postgres/AddPostgresRequirements.sh


function create_postgres_service() {
  mkdir ${project_path}/postgres
  cp -r ${current_path}/postgres/utils/* ${project_path}/postgres/
  create_postgres_compose_service project_path
  create_postgres_requirements
  add_postgres_in_settings project_name


}

