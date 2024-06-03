#!/bin/bash

project_name=$1

source ./celery/AddCeleryCfgFile.sh
source ./celery/AddCeleryRequirements.sh
source ./celery/AddCeleryComposeService.sh
source ./celery/AddCeleryInSettings.sh

function create_celery_service() {
  create_celery_cfg_file project_name
  create_celery_requirements
  create_celery_compose_file project_name
  add_celery_in_settings project_name

  echo "
# Celery
CELERY_BROKER_URL=redis://redis:6379/0
CELERY_BACKEND=redis://redis:6379/0

" >> django/development/dev.env

  echo "
# Celery
CELERY_BROKER_URL=redis://redis:6379/0
CELERY_BACKEND=redis://redis:6379/0

" >> django/production/api.env

}

