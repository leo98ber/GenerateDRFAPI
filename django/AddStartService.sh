#!/bin/bash


function create_django_entrypoint() {
cat <<EOF >django/start
#!/bin/sh

set -o errexit
set -o nounset

python manage.py migrate
python manage.py runserver 0.0.0.0:8000

EOF

echo "Start django service generated successfully!"
echo -e "\n" # Salto de linea
}

