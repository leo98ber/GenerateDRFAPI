#!/bin/bash

project_name=$1

source ./redis/AddRedisRequirements.sh
source ./redis/AddRedisComposeService.sh
source ./redis/AddRedisInSettings.sh

function create_redis_service() {
  create_redis_requirements
  create_redis_compose_file project_name
  add_redis_in_settings project_name
}

