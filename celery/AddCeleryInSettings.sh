#!/bin/bash

project_name=$1

function add_celery_in_settings() {
    echo "
import os

INSTALLED_APPS.append('${project_name}.celery_cfg.CeleryAppConfig')
CELERY_BROKER_URL = os.environ.get('CELERY_BROKER_URL')
CELERY_RESULT_BACKEND = CELERY_BROKER_URL
CELERY_ACCEPT_CONTENT = ['application/json']
CELERY_RESULT_SERIALIZER = 'json'
CELERY_TASK_SERIALIZER = 'json'
CELERY_TIMEZONE = 'UTC'
CELERY_CONFIG_MODULE = '${project_name}.celery_cfg'
  " >> ${project_name}/settings/__init__.py

}

