FROM python:latest

ENV PYTHONUNBUFFERED 1

WORKDIR /code

COPY ./requirements /requirements
RUN pip install -r /requirements/local.txt

COPY . /code/

COPY ./django/development/start /start
RUN sed -i 's/\r//' /start
RUN chmod +x /start

EXPOSE 8000
