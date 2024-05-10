#!/bin/bash

echo "${db_host}"

if [ $# -ne 5 ]; then
  echo "Credenciales requeridas: $0 <db_host> <db_port> <db_name> <username> <password>"
  exit 1
fi

db_host="$1"
db_port="$2"
db_name="$3"
username="$4"
password="$5"
timestamp=$(date +%Y%m%d%H%M%S)
backup_dir="backup_${db_name}_${timestamp}"
mkdir "$backup_dir"

read -p "Introduce las colecciones a respaldar (separadas por espacios; dejar en blanco para respaldo completo): " -a collections

if [ ${#collections[@]} -eq 0 ]; then
  collections=()
fi

db_url="mongodb://${username}:${password}@${db_host}:${db_port}/?authSource=${db_name}&readPreference=primary&appname=MongoDB%20Compass&ssl=false"
echo "MONGO URL: ${db_url}"
backup_cmd="mongodump --uri '${db_url}' --db '${db_name}' --out '${backup_dir}'"

for collection in "${collections[@]}"; do
  backup_cmd="mongodump --uri '${db_url}' --db '${db_name}' --out '${backup_dir}' --collection '${collection}'"
  echo "$backup_cmd"
  eval "$backup_cmd"
done

echo "$backup_cmd"
eval "$backup_cmd"

echo "Copia de seguridad completada"

read -p "Este programa va a restaurar los datos del respaldo (bakcup) creado en la base de datos '$db_name'. Estas seguro que quieres continuar? (y/N) " -r confirm

if [[ ! $confirm =~ ^[Yy]$ ]]; then
  echo "Restauracion automatica cancelada."
  exit 0
fi

read -p "Introduzca el nombre de usuario de la base de datos a restaurar: " target_username
read -p "Introduzca el nombre de la base de datos a restaurar: " db_target_name
read -sp "Introduzca la contraseña de la base de datos a restaurar: " target_password

read -p "Ingrese el nombre del contenedor de docker de mongo" server_name
server_name=${project_name:-my_project}
echo -e "\n"

bash mongo_restore_backup.sh "$backup_dir" "${server_name}" "27017" "$db_target_name" "$target_username" "$target_password" "$db_name"