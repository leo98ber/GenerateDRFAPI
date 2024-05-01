#!/bin/bash

project_path=$1
current_path=$2

source ./mongo/AddMongoComposeService.sh
source ./mongo/AddMongoInSettings.sh
source ./mongo/AddMongoRequirements.sh


function create_mongo_service() {
  mkdir ${project_path}/mongo
  cp -r ${current_path}/mongo/mongo_utils/* ${project_path}/mongo/
  create_mongo_compose_service project_path
  add_mongo_in_settings project_name
  create_mongo_requirements
}

