FROM python:latest

ENV PYTHONUNBUFFERED 1

WORKDIR /code

COPY ./requirements /requirements
RUN pip install -r /requirements/production.txt

COPY . /code/

COPY ./django/production/start /start
RUN sed -i 's/\r//' /start
RUN chmod +x /start

EXPOSE 8000
