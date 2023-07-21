#!/bin/bash

set -euo pipefail

python manage.py collectstatic --no-input
python manage.py migrate
if [[ "$DJANGO_ENV" = "prod" ]]; then
  mv /app/.env.prod /app/.env
else
  mv /app/.env.example /app/.env
fi
  gunicorn --bind 0.0.0.0:8000 django_movie.wsgi:application
