# :whale: Docker Stacks - Cloud Services
Docker Stacks to provide various cloud services on a server (e.g. VPS) or device (e.g. Raspberry Pi) with Docker Stack.

- Traefik: [Docker Hub](https://hub.docker.com/_/traefik) - [GitHub](https://github.com/traefik/traefik)
- ownCloud Infinite Scale: [Docker Hub](https://hub.docker.com/r/owncloud/ocis) - [GitHub](https://github.com/owncloud/ocis)
- Syncthing: [Docker Hub](https://hub.docker.com/r/syncthing/syncthing) - [GitHub](https://github.com/syncthing/syncthing)
- Baikal: [Docker Hub (*unofficial*)](https://hub.docker.com/r/ckulka/baikal) - [GitHub](https://github.com/sabre-io/Baikal)

It is possible to combine these stacks to provide the desired services.

## Traefik
Traefik is a HTTP reverse proxy and load balancer. Traefik is used to reach different services with different domains or URLs. Also make sure to change the email address of the ACME certificate resolver in `traefik.yml`.

**Environment Variables**

- `SERVER_DOMAIN`: The domain to access the instace of Traefik.
- `TRAEFIK_USERNAME`: The username to access the dashboard using basic authentication.
- `TRAEFIK_PASSWORD`: The password to access the dashboard using basic authentication.

## ownCloud Infinite Scale
ownCloud Infinite Scale is a revised and modernized version of ownCloud 10. In addition to ownCloud Infinite Scale, Apache Tika is also installed. Apache Tika indexes the content of documents so that they can be searched with ownCloud Infinite Scale.

**Environment Variables**

- `SERVER_DOMAIN`: The domain to access the instance of ownCloud Infinite Scale.
- `ADMIN_PASSWORD`: The password to access ownCloud Infinite Scale with admin user.

## Syncthing
Syncthing is a tool for synchronizing data between different devices in real time.

**Environment Variables**

- `SERVER_DOMAIN`: The domain to access the instance of Syncthing.

## Baikal
Baikal is a tool for synchronizing appointments and contacts across multiple devices.

**Environment Variables**

- `SERVER_DOMAIN`: The domain to access the instance of Baikal.

## Wiki.js

[Wiki.js](https://js.wiki/) is a modern, web-based, open-source software for creating and managing knowledge bases and documentation.

### Environment Variables

| Variable | Default |
| --- | --- |
| `DATABASE_HOST` | wikijs-db |
| `DATABASE_NAME` | wikijs |
| `DATABASE_PASS` | wikijs |
| `DATABASE_USER` | wikijs |
| `SERVER_DOMAIN` | example.org |
| `VERSION_POSTGRES` | 18.7 |
| `VERSION_WIKIJS` | 3.5.0 |

You can define these environment variables in a `.env` file next to the `compose.yaml` file.

## Install a Docker Stack
You can use the install script `install.sh` to install a Docker Stack. The install script supports the following parameters:

- `-d`, `--debug`: Shows the configuration for the Docker Stack.
- `-h`, `--help`: Shows the help of the install script.
- `-i`, `--install`: Installs the Docker Stack with all prerequisites.
- `-v`, `--version`: Shows the version of the services.

Before installing a Docker Stack, make sure that you have configured all available environment variables using a `.env` file next to the install script (`install.sh`).