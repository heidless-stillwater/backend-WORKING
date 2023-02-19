# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:3.9-alpine3.13
LABEL maintainer="robsConsultancy"

#EXPOSE 8000

# Keeps Python from generating .pyc files in the container
#ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
#ENV PYTHONUNBUFFERED=1

# Install pip requirements
COPY ./requirements.txt /requirements.txt
COPY ./app /app
WORKDIR /app

RUN python -m venv /py && \
  /py/bin/pip install -r /requirements.txt && \
  adduser --disabled-password --no-create-home django-user

# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-python-configure-containers

#RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
#USER appuser

ENV PATH="/py/bin:$PATH"

USER django-user

# During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug
#CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app.wsgi"]
