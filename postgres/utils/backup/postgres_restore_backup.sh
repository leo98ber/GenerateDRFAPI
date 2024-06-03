#!/bin/bash

if [ $# -lt 6 ]; then
  echo "Uso: $0 <backup_dir> <db_host> <db_port> <db_name> <username> <password>"
  echo "  backup_dir: Ruta al directorio que contiene el respaldo (ej.: backup_regional_prod_ve_20240320201720)"
  echo "  db_host: Nombre de host o dirección IP del servidor MariaDB"
  echo "  db_port: Puerto en el que escucha el servidor MariaDB (predeterminado: 3306)"
  echo "  db_name: Nombre de la base de datos a restaurar"
  echo "  username: Nombre de usuario de la base de datos a restaurar"
  echo "  password: Contraseña de la base de datos a restaurar"
  exit 1
fi

backup_dir="$1"
db_host="$2"
db_port="${3:-3306}"
db_name="$4"
username="$5"
password="$6"

if [ ! -d "$backup_dir" ]; then
  echo "Error: Directorio de respaldo '$backup_dir' no encontrado."
  exit 1
fi

sql_file="$backup_dir/backup.sql"

if [ ! -f "$sql_file" ]; then
  echo "Error: Archivo de respaldo '$sql_file' no encontrado."
  exit 1
fi

mariadb --host="$db_host" --port="$db_port" --user="$username" --password="$password" "$db_name" < "$sql_file"

echo "Restauración completada en la base de datos '$db_name'."