FROM node:16.13-alpine

# Create newman dir
RUN mkdir /newman
WORKDIR /newman

# Copy files
COPY data.csv data.csv
COPY run.sh run.sh
COPY cronconfig cronconfig
COPY environment.postman_environment.json environment.postman_environment.json
COPY collection.postman_collection.json collection.postman_collection.json

# Install dos2unix and node
RUN apk update \
    apk --no-cache add dos2unix

# Install newman
RUN npm install -g newman

# ensure scripts are using correct line endings
RUN dos2unix "run.sh"

# Set permissions
RUN chmod 0644 "cronconfig"
RUN chmod 0744 "run.sh"

## setup cron configs
RUN crontab "cronconfig"

# start container with crond
CMD ["crond", "-f"]