#!/bin/bash

export VERSION_WIKIJS=3.5.0
export VERSION_POSTGRES=18.7

if [ -f .env ]; then
  set -a;
  source <(sed -e "s/\r//" .env);
  set +a;
fi

debug() {
  docker stack config -c compose.yaml
}

help() {
  echo "Script for installing Wiki.js with all prerequisites."
  echo ""
  echo "Usage: bash install.sh [options...]"
  echo ""
  echo "The following options are available:"
  printf "%4s, %-10s %-70s\n" "-d" "--debug" "Shows the configuration for the Docker stack."
  printf "%4s, %-10s %-70s\n" "-h" "--help" "Shows this help."
  printf "%4s, %-10s %-70s\n" "-i" "--install" "Installs the Wiki.js stack with all prerequisites."
  printf "%4s, %-10s %-70s\n" "-v" "--version" "Shows the version of the services."
}

install() {
  docker stack deploy -c compose.yaml wikijs
}

version() {
  printf "%-15s %-10s\n" "Wiki.js:" "${VERSION_WIKIJS}"
  printf "%-15s %-10s\n" "PostgreSQL:" "${VERSION_POSTGRES}"
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
