#!/bin/bash

drf_version=$1
django_version=$2

source ./django/AddDjangoDocker.sh
source ./django/AddRequirements.sh drf_version django_version
source ./django/AddStartService.sh

function create_django_service() {
  mkdir django
  create_django_dockerfile
  create_django_entrypoint
  create_django_requirements
}

