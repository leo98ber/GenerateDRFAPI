#!/bin/bash

django_version=$1

function create_celery_requirements() {

declare -A libraries=(
  ["redis"]="redis"
  ["celery"]="celery"
  ["django-redis"]="django-redis"
  ["tornado"]="tornado"
  ["flower"]="flower"
)

for library_name in "${!libraries[@]}"; do
  echo "Ingrese la versión de $library_name que desea instalar:"
  read library_version
  echo -e "\n"

  if [ -z "$library_version" ]; then
    echo "${libraries[$library_name]}" >> django/requirements.txt
  else
    echo "${libraries[$library_name]}==$library_version" >> django/requirements.txt
  fi
done


echo "Celery requirements added successfully!"
echo -e "\n"
}
