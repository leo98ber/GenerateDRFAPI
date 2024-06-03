#!/bin/bash

project_name=$1

function add_redis_in_settings() {
    echo "

REDIS_URL = os.environ.get('REDIS_URL')
CACHES = {
    'default': {
        'BACKEND': 'django_redis.cache.RedisCache',
        'LOCATION': REDIS_URL,
        'OPTIONS': {
            'CLIENT_CLASS': 'django_redis.client.DefaultClient',
            'IGNORE_EXCEPTIONS': True
        }
    }
}


SESSION_ENGINE = 'django.contrib.sessions.backends.cache'
SESSION_CACHE_ALIAS = 'default'

  " >> ${project_name}/settings/__init__.py

  echo "
# Redis
REDIS_URL=redis://redis:6379/0

" >> django/development/dev.env

  echo "
# Redis
REDIS_URL=redis://redis:6379/0

" >> django/production/api.env

}

