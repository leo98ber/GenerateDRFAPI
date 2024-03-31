#!/bin/bash

project_name=$1

function create_celery_cfg_file() {
  cat <<EOF >>"${project_name}"/celery_cfg.py
import os

from django.apps import AppConfig, apps

from celery import Celery

os.environ.setdefault('DJANGO_SETTINGS_MODULE', '${project_name}.settings')

app = Celery('${project_name}')

app.config_from_object("django.conf:settings", namespace="CELERY")

app.autodiscover_tasks()

class CeleryAppConfig(AppConfig):
    name = 'tasks'
    verbose_name = 'Celery Config'

    def ready(self):
        installed_apps = [app_config.name for app_config in apps.get_app_configs()]
        app.autodiscover_tasks(lambda: installed_apps, force=True)

EOF
  mkdir tasks
  touch tasks/__init__.py
  echo "File celery_cfg.py created successfully!"

}

