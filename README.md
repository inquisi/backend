# Inquisi
## Backend

### Set up
This project requires the following:

    - Ruby
    - Docker
    - Docker Compose

### Running
To run this application, simply run `docker-compose up` in the application's top level directory.

### Config File Descriptions
`Dockerfile` - is `Docker`'s config file. It tells `Docker` how to build a container (a virtual machine) that will run the rails application. Think of each container as it's own service.

`docker-compose.yml` - is `docker-compose`'s config file. It tells `docker-compose` how to manage the services created by Docker (containers) and run them together.

`docker-compose.backend.sh` - is simply a script that's run when the 'backend' service is started by `docker-compose`.