#!/bin/bash
source ./AddComposeFile.sh
source django/AddDjangoService.sh
source celery/AddCeleryService.sh
source mongo/AddMongoService.sh
source postgres/AddPostgresService.sh


echo "Ingrese la ubicación donde desea crear el proyecto:"
read project_path
echo -e "\n"
current_path=`pwd`

#
cd "$project_path"

python3 -m venv venv

source venv/bin/activate

echo "Ingrese la versión de Django REST Framework que desea instalar:"
read drf_version
echo -e "\n"


if [ -z "$drf_version" ]; then
  pip install djangorestframework --upgrade
  drf_version=$(pip show djangorestframework | grep Version | awk '{print $2}')
  django_version=$(pip show Django | grep Version | awk '{print $2}')
else
  pip install "djangorestframework==$drf_version"
  django_version=$(pip show Django | grep Version | awk '{print $2}')
fi
#

cp ${current_path}/.gitignore ${project_path}

read -p "Ingrese el nombre del proyecto (por defecto: my_project): " project_name
project_name=${project_name:-my_project}
echo -e "\n"

# Validate project name
if [[ ! "$project_name" =~ ^[a-zA-Z0-9_-]+$ ]]; then
  echo "Error: El nombre del proyecto solo puede tener letras, numeros, guiones bajos, and guiones."
  echo -e "\n"
  exit 1
fi

create_django_compose_file


touch api.env
create_django_service drf_version django_version

django-admin startproject "${project_name}"

mv "${project_name}"/manage.py .
mv "${project_name}"/"${project_name}"/* ./"${project_name}"
rm -r "${project_name}"/"${project_name}"

echo `pwd`


read -p "Desea agregar celery? (y/N) " -r confirm
echo -e "\n"

if [[ $confirm =~ ^[Yy]$ ]]; then
  create_celery_service project_name
fi


read -p "Desea agregar mongo db? (y/N) " -r confirm
echo -e "\n"

if [[ $confirm =~ ^[Yy]$ ]]; then
  create_mongo_service project_path current_path
fi


read -p "Desea agregar postgres db? (y/N) " -r confirm
echo -e "\n"

if [[ $confirm =~ ^[Yy]$ ]]; then
  create_postgres_service project_path current_path
fi


deactivate


