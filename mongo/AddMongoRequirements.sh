#!/bin/bash

django_version=$1

function create_mongo_requirements() {

declare -A libraries=(
  ["mongoengine"]="mongoengine"
  ["django-rest-framework-mongoengine"]="django-rest-framework-mongoengine"
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

echo "Mongo requirements added successfully!"
echo -e "\n"
}
