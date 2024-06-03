#!/bin/bash

project_name=$1

function add_mongo_in_settings() {
    echo "
import mongoengine
# Load DBs config: MongoDB
MONGODB_URL = os.environ.get('MONGODB_URL')
MONGODB_USER = os.environ.get('MONGODB_USER')
MONGODB_PASSW = os.environ.get('MONGODB_PASSW')

if not (MONGODB_URL and MONGODB_USER and MONGODB_PASSW):
    logger.error('MONGODB_URL, MONGODB_USER, MONGODB_PASSW must be defined in os environment')
    exit(-1)

mongoengine.connect(host=MONGODB_URL, username=MONGODB_USER, password=MONGODB_PASSW)
  " >> ${project_name}/settings/__init__.py

  echo "
MONGODB_URL=mongodb://mongodb:27017/test_database
MONGODB_USER=db_user
MONGODB_PASSW=7a89_jaJA1239

" >> django/development/dev.env

  echo "
MONGODB_URL=mongodb://mongodb:27017/test_database
MONGODB_USER=db_user
MONGODB_PASSW=7a89_jaJA1239

" >> django/production/api.env

}

