#!/bin/bash

# set the version of the various services.
export VERSION_OWNCLOUD=7.3.1
export VERSION_TIKA=3.2.3.0

# export all environment variables from external .env file.
# the docker compose command can use these variables for substitution.
set -a;
source <(sed -e "s/\r//" .env);
set +a;

# the credentials for the service account are generated radomly.
# you don't have to know the credentials for the service account.
SERVICE_ACCOUNT_ID=$(uuidgen)
export SERVICE_ACCOUNT_ID
password=$(openssl passwd -6 "$(uuidgen)")
SERVICE_ACCOUNT_SECRET=${password:25:25}
export SERVICE_ACCOUNT_SECRET

debug() {
  docker stack config -c docker-compose.yml
}

help() {
  echo "This script installs ownCloud with all prerequisites."
  echo ""
  echo "Usage: bash install.sh [options...]"
  echo ""
  echo "The following options are available:"
  printf "%4s, %-10s %-70s\n" "-d" "--debug" "Shows the configuration for the Docker stack."
  printf "%4s, %-10s %-70s\n" "-h" "--help" "Shows this help."
  printf "%4s, %-10s %-70s\n" "-i" "--install" "Installs the ownCloud stack with all prerequisites."
  printf "%4s, %-10s %-70s\n" "-v" "--version" "Shows the version of the services."
}

install() {

  # create the directories for configuration and data.
  # you also have to set the ownership of these directories.
  mkdir -p config data
  chown 1000:1000 config data

  # deploy the docker stack.
  docker stack deploy -c docker-compose.yml owncloud
}

version() {
  printf "%-15s %-10s\n" "ownCloud:" "${VERSION_OWNCLOUD}"
  printf "%-15s %-10s\n" "Apache Tika:" "${VERSION_TIKA}"
}

if [[ "$#" == "0" ]]; then
  help
else
  while [[ "$#" != "0" ]]; do
    if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
      help
    elif [[ "$1" == "-d" ]] || [[ "$1" == "--debug" ]]; then
      debug
    elif [[ "$1" == "-i" ]] || [[ "$1" == "--install" ]]; then
      install
    elif [[ "$1" == "-v" ]] || [[ "$1" == "--version" ]]; then
      version
    fi
    shift
  done
fi
