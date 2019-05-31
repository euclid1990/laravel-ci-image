#!/bin/bash

# Define variables
homeDir=/home/circleci
projectDir=${homeDir}/project

# Copy development environment file if not existing
if [[ ! -f ${projectDir}/.env && -f ${projectDir}/.env.dev.example ]]; then
  cp ${projectDir}/.env.dev.example ${projectDir}/.env
fi

# Generate application key if it not set
APP_KEY=$(cat .env | sed -n 's/^APP_KEY=/ /p')
if [[ -z "${APP_KEY// }" ]]; then
  php artisan key:generate
fi

standardPath=${projectDir}/vendor/squizlabs/php_codesniffer/src/Standards/SunOS
if [ ! -d "$standardPath" ]; then
  # Copy php code sniff to vendor
  cp -i -r ${homeDir}/phpcs/SunOS/ ${standardPath}
fi
