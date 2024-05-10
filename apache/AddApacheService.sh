#!/bin/bash

project_path=$1
current_path=$2

source ./apache/AddApacheComposeService.sh

function create_apache_service() {
  mkdir ${project_path}/apache
  cp -r ${current_path}/apache/* ${project_path}/apache/
  create_apache_compose_file

}

