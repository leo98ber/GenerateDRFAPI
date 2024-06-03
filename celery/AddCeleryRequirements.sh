#!/bin/bash

django_version=$1

function create_celery_requirements() {

declare -A libraries=(
  ["celery"]="celery"
  ["flower"]="flower"
)

for library_name in "${!libraries[@]}"; do
  echo "Ingrese la versión de $library_name que desea instalar:"
  read library_version
  echo -e "\n"

  if [ -z "$library_version" ]; then
    echo "${libraries[$library_name]}" >> requirements/base.txt
  else
    echo "${libraries[$library_name]}==$library_version" >> requirements/base.txt
  fi
done


echo "Celery requirements added successfully!"
echo -e "\n"
}
