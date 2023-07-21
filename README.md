# Movie library

### Educational project on Django from cource ["Уроки Django 3"](https://www.youtube.com/playlist?list=PLF-NY6ldwAWrb6nQcPL21XX_-AmivFAYq).

[*Try on my site*](http://movie.shevelev.site/)

## Technology stack:
- Python
- Django
- Gunicorn
- Nginx
- Docker

## Get started
### Way I: with Docker
```
$ docker compose -f docker-compose.example.yml up -d --build
```
Go to the http://localhost:8000/

To execute command inside docker container enter:
```
$ docker exec <container-name> <command>
```
**NOTE**: There is a filled database file `db.sqlite3` but if you want to create a new one delete `db.sqlite3` and enter:
```
$ docker exec django python manage.py makemigrations
$ docker exec django python manage.py migrate
$ docker exec django python manage.py createsuperuser
```
**NOTE**: Environment variables to run the project locally stored in `.env.example`. You can change `DJANGO_SECRET_KEY` variable via:
```
$ python manage.py shell  # On Windows
$ python3 manage.py shell  # On Linux / MacOS
>>> from django.core.management.utils import get_random_secret_key
>>> get_random_secret_key()
```

### Way II: manually
First create a virtual environment. [venv](https://docs.python.org/3/library/venv.html) module from standart python library uses here, but you can use another one ([pyenv](https://github.com/pyenv/pyenv), [pipenv](https://github.com/pypa/pipenv), [virtualenv](https://github.com/pypa/virtualenv)).
#### On Windows:
```
$ python -m venv .venv
$ .venv\scripts\activate
```
#### On Linux / MacOS:
```
$ python3 -m venv .venv
$ source .venv/bin/activate
```
To deactivate environment enter `deactivate`

Next install requirements.
#### On Windows:
```
$ pip install -r requirements.txt
```
#### On Linux / MacOS:
```
pip3 install -r requirements.txt
```
Next set environment variables.
#### On Windows:
```
set DJANGO_ENV=dev && set DJANGO_SECRET_KEY=testsecretkey && set DJANGO_ALLOWED_HOSTS='localhost:8000,127.0.0.1:8000' && set DJANGO_BASE_URL=localhost:8000/
```
#### On Linux / MacOS:
```
export DJANGO_ENV=dev && export DJANGO_SECRET_KEY=testsecretkey && export DJANGO_ALLOWED_HOSTS='localhost:8000,127.0.0.1:8000' && export DJANGO_BASE_URL=localhost:8000/
```
Further replace .venv/lib/python`<version>`/site-packages/snowpenguin/django/recaptcha3/fields.py with `fields.py` file in root of project, because `django-recaptcha3` library outdated for django last versions.

**NOTE**: Environment variables to run the project locally stored in `.env.example`. You can change `DJANGO_SECRET_KEY` variable via:
```
$ python manage.py shell  # On Windows
$ python3 manage.py shell  # On Linux / MacOS
>>> from django.core.management.utils import get_random_secret_key
>>> get_random_secret_key()
```
Next collect static files.
#### On Windows:
```
$ python manage.py collectstatic
```
#### On Linux / MacOS:
```
$ python3 manage.py collectstatic
```
**NOTE**: There is a filled database file `db.sqlite3` but if you want to create a new one delete `db.sqlite3` and next step enter:
#### On Windows:
```
$ python manage.py makemigrations
$ python manage.py migrate
$ python manage.py createsuperuser
```
#### On Linux / MacOS:
```
$ python3 manage.py makemigrations
$ python3 manage.py migrate
$ python3 manage.py createsuperuser
```
Finally run the server.
```
$ gunicorn --bind 0.0.0.0:8000 django_movie.wsgi:application
```
Go to the http://localhost:8000/
