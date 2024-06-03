#!/bin/bash

echo

if [ $# -lt 7 ]; then
  echo "Uso: $0 <backup_dir> <db_host> <db_port> <db_name> <username> <password> <db_name>"
  echo "  backup_dir: Ruta al directorio que contiene la carpeta del backup (ej.: backup_regional_prod_ve_20240320201720)"
  echo "  db_host: Nombre de host o dirección IP del servidor MongoDB"
  echo "  db_port: Puerto en el que escucha el servidor MongoDB (predeterminado: 27017)"
  echo "  db_name: Nombre de la base de datos a restaurar"
  echo "  username: Nombre de usuario de la base de datos a restaurar"
  echo "  password: Contraseña de la base de datos a restaurar"
  echo "  origin_db_name: Base de datos origen"
  exit 1
fi

# Extract arguments
backup_dir="$1"
db_host="$2"
db_port="${3:-27017}"  # Set default port if not provided
db_name="$4"
username="$5"
password="$6"
origin_db_name="$7"

# Check if backup directory exists
if [ ! -d "$backup_dir/$origin_db_name" ]; then
  echo "Error: Carpeta o directorio '$backup_dir/$origin_db_name' no encontrado!"
  exit 1
fi

db_url="mongodb://${username}:${password}@${db_host}:${db_port}/?authSource=${db_name}&readPreference=primary&appname=MongoDB%20Compass&ssl=false"

for bson_file in "${backup_dir}/${origin_db_name}"/*.bson; do
  collection=$(basename "$bson_file" .bson)
  restore_cmd="mongorestore --uri '${db_url}' --db '${db_name}' --collection '${collection}' '$bson_file'"
  echo "Restaurando colección: $collection"
  eval "$restore_cmd"
done

echo "Restore completed!"