#!/bin/bash

# set the version of the various services.
export VERSION_SYNCTHING=2.1.5

# export all environment variables from external .env file.
# the docker stack deploy command can use these variables for substitution.
set -a;
source <(sed -e "s/\r//" .env);
set +a;

debug() {
  docker stack config -c docker-compose.yml
}

help() {
  echo "This script installs Syncthing with all prerequisites."
  echo ""
  echo "Usage: bash install.sh [options...]"
  echo ""
  echo "The following options are available:"
  printf "%4s, %-10s %-70s\n" "-d" "--debug" "Shows the configuration for the Docker stack."
  printf "%4s, %-10s %-70s\n" "-h" "--help" "Shows this help."
  printf "%4s, %-10s %-70s\n" "-i" "--install" "Installs the Syncthing stack with all prerequisites."
  printf "%4s, %-10s %-70s\n" "-v" "--version" "Shows the version of the services."
}

install() {

  # create the missing folders.
  mkdir -p sync-folders
  chown 1000:1000 sync-folders

  # create stack.
  docker stack deploy -c docker-compose.yml syncthing
}

version() {
  printf "%-15s %-10s\n" "Syncthing:" "${VERSION_SYNCTHING}"
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
