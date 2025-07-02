FROM python:3.9-alpine3.13
LABEL maintainers="shivamkumar10305@gmail.com"

ENV PYTHONUNBUFFERED=1
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false 
RUN python -m venv /py 
RUN /py/bin/pip install --upgrade pip
RUN /py/bin/pip install -r /tmp/requirements.txt
RUN rm -rf /tmp
RUN adduser --disabled-password --no-create-home django-user

RUN if [ $DEV = 'true']; \
    then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi 


ENV PATH="/py/bin:$PATH"

USER django-user

