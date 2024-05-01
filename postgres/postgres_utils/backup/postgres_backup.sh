#!/bin/bash

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

mariadb-dump --host="$db_host" --port="$db_port" --user="$username" --password="$password" "$db_name" > "$backup_dir/backup.sql"

echo "Copia de seguridad completada en: $backup_dir/backup.sql"

read -p "Este programa va a restaurar los datos del respaldo (backup) creado en la base de datos '$db_name'. ¿Estás seguro de que quieres continuar? (y/N) " -r confirm

if [[ ! $confirm =~ ^[Yy]$ ]]; then
  echo "Restauración automática cancelada."
  exit 0
fi

read -p "Introduce el nombre de usuario de la base de datos a restaurar: " target_username
read -p "Introduce la contraseña de la base de datos a restaurar: " target_password
read -p "Introduce el nombre de la base de datos a restaurar: " db_target_name

bash mongo_restore_backup.sh "$backup_dir" mysql_server "3306" "$db_target_name" "$target_username" "$target_password"

echo "Restauración completada en la base de datos '$db_target_name'."