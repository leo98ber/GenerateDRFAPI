#!/bin/bash

drf_version=$1
django_version=$2
project_name=$3

source ./django/AddRequirements.sh drf_version django_version project_name
source ./django/AddSettings.sh project_name

function create_django_service() {
  mkdir django
  cp -r ${current_path}/django/utils/* ${project_path}/django/

  create_django_settings
  create_django_requirements
}

