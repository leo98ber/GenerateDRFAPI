#!/bin/bash

project_name=$1

function add_postgres_in_settings() {
        echo "
DB_HOST = os.environ.get('DB_HOST')
DB_PORT = os.environ.get('DB_PORT')
DB_NAME = os.environ.get('DB_NAME')
DB_USER = os.environ.get('DB_USER')
DB_PASSW = os.environ.get('DB_PASSWORD')

# Load DBs config: Relational Database
DB_HOST_DICT = {'value': DB_HOST, 'name': 'HOST'}
DB_PORT_DICT = {'value': DB_PORT, 'name': 'PORT'}
DB_NAME_DICT = {'value': DB_NAME, 'name': 'NAME'}
DB_USER_DICT = {'value': DB_USER, 'name': 'USER'}
DB_PASSW_DICT = {'value': DB_PASSW, 'name': 'PASSWORD'}

DATABASES_CREDENTIALS = [DB_HOST_DICT, DB_PORT_DICT, DB_NAME_DICT, DB_USER_DICT, DB_PASSW_DICT]

for each in DATABASES_CREDENTIALS:
    if not each.get('value'):
        credential_name = each.get('name')
        logger.critical(f'{credential_name} must be defined in os environment')
        exit(-1)

DATABASES['default'] = {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': DB_NAME,
        'USER': DB_USER,
        'PASSWORD': DB_PASSW,
        'HOST': DB_HOST,
        'PORT': DB_PORT,
    }

  " >> ${project_name}/settings.py

}

