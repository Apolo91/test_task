FROM postgres:latest
ENV POSTGRES_PASSWORD=secret
ENV POSTGRES_USER=username
ENV POSTGRES_DB=database
ENV POSTGRES_HOST=db
COPY create_trigger.sql /docker-entrypoint-initdb.d/create_trigger.sql
COPY create_schema.sql /docker-entrypoint-initdb.d/create_schema.sql
