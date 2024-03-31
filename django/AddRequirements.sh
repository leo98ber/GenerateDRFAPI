#!/bin/bash

django_version=$1

function create_django_requirements() {
cat <<EOF >django/requirements.txt
djangorestframework==${drf_version}
Django==${django_version}
EOF

declare -A libraries=(
  ["django-filter"]="django-filter"
  ["django-cors-headers"]="django-cors-headers"
  ["djangorestframework-simplejwt"]="djangorestframework-simplejwt"
  ["django-role-permissions"]="django-role-permissions"
  ["djangorestframework-recursive"]="djangorestframework-recursive"
)

for library_name in "${!libraries[@]}"; do
   read -p "Desea instalar la libreria '$library_name'? (y/N) " -r confirm

  if [[ $confirm =~ ^[Yy]$ ]]; then
    echo "Ingrese la versión de $library_name que desea instalar:"
    read library_version
    echo -e "\n"

    if [ -z "$library_version" ]; then
      echo "${libraries[$library_name]}" >> django/requirements.txt
    else
      echo "${libraries[$library_name]}==$library_version" >> django/requirements.txt
    fi
  fi
done

echo "Requirements generated successfully!"
echo -e "\n" # Salto de linea
}
