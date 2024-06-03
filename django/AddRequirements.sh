#!/bin/bash

drf_version=$1
django_version=$2
project_name=$3

function create_django_requirements() {
mkdir requirements
cat <<EOF >requirements/base.txt
djangorestframework==${drf_version}
Django==${django_version}

#Swagger
drf-yasg

EOF

# Cors
echo "Ingrese la versión de django-cors-headers que desea instalar:"
read library_version
echo -e "\n"

if [ -z "$library_version" ]; then
  echo "django-cors-headers" >> requirements/base.txt
else
  echo "django-cors-headers==$library_version" >> requirements/base.txt
fi


echo "
# CORS
CORS_ORIGIN_WHITELIST=" >> django/development/dev.env

echo "
# CORS
CORS_ORIGIN_WHITELIST=" >> django/production/api.env

# JWT
read -p "Desea instalar utilizar JWT? (y/N) " -r confirm

if [[ $confirm =~ ^[Yy]$ ]]; then
  echo "Ingrese la versión de djangorestframework-simplejwt que desea instalar:"
  read library_version
  echo -e "\n"

  if [ -z "$library_version" ]; then
    echo "djangorestframework-simplejwt" >> requirements/base.txt
  else
    echo "djangorestframework-simplejwt==$library_version" >> requirements/base.txt
  fi

  echo "
REST_FRAMEWORK['DEFAULT_AUTHENTICATION_CLASSES'] = [
        'rest_framework_simplejwt.authentication.JWTAuthentication',
    ],

try:
    ACCESS_TOKEN_LIFETIME = int(os.environ.get('ACCESS_TOKEN_LIFETIME', 5))
    REFRESH_TOKEN_LIFETIME = int(os.environ.get('ACCESS_TOKEN_LIFETIME', 1))
except ValueError:
    logger.critical(f'ACCESS_TOKEN_LIFETIME and REFRESH_TOKEN_LIFETIME must be defined numbers not string')
    exit(-1)

SIMPLE_JWT = {
    'ACCESS_TOKEN_LIFETIME': timedelta(minutes=ACCESS_TOKEN_LIFETIME),
    'REFRESH_TOKEN_LIFETIME': timedelta(days=REFRESH_TOKEN_LIFETIME),
    # 'ROTATE_REFRESH_TOKENS': True,
    # 'BLACKLIST_AFTER_ROTATION': True
}

" >> ${project_name}/settings/__init__.py
fi

  echo "
# JWT
ACCESS_TOKEN_LIFETIME=600
REFRESH_TOKEN_LIFETIME=10

" >> django/development/dev.env

  echo "
# JWT
ACCESS_TOKEN_LIFETIME=600
REFRESH_TOKEN_LIFETIME=10

" >> django/production/api.env

# Others
declare -A libraries=(
  ["django-filter"]="django-filter"
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
      echo "${libraries[$library_name]}" >> requirements/base.txt
    else
      echo "${libraries[$library_name]}==$library_version" >> requirements/base.txt
    fi
  fi
done


cat <<EOF >requirements/local.txt
-r ./base.txt
EOF

cat <<EOF >requirements/production.txt
-r ./base.txt
gunicorn
whitenoise

# Static files
django-storages[boto3]
EOF

echo "Requirements generated successfully!"
echo -e "\n"
}
