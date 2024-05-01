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
  " >> ${project_name}/settings.py

}

