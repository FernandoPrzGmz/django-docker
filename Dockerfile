FROM python:3.6

ARG PROJECT_DIR=/var/wapps/sitios/django_docker

# Create the work directory
RUN mkdir -p ${PROJECT_DIR}

# Instalar dependencias de la aplicación
RUN apt-get update && \
    apt-get install -y systemd nginx supervisor


# Copy requirements to install project's dependencies
COPY ./requirements.txt ${PROJECT_DIR}/requirements.txt
WORKDIR ${PROJECT_DIR}
RUN pip install -r requirements.txt

# Copy project source
COPY ./ ${PROJECT_DIR}

RUN python manage.py migrate


# Configurar Nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
COPY .config/nginx.conf /etc/nginx/sites-available/default

# Configurar Supervisor
RUN mkdir -p /var/log/supervisor
COPY .config/supervisord.conf /etc/supervisor/conf.d/django_docker.conf