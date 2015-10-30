# Inquisi
## Backend

### Set up
This project requires the following:

    - Ruby
    -nginx
    -mysql
    -gulp (for testing)
    NO LONGER USE DOCKER
    - Docker
    - Docker Compose

### Running
To run this application, simply run `docker-compose up` in the application's top level directory.

### Docker tips
Docker runs applications in their own virtual environments (containers).
Docker-compose orchestrates (manages) many docker containers together.
This application runs Rails in one container, and MySQL in another.

After running docker-compose, you can interact with the individual containers via the `docker` command, e.g., to view a list of running containers, run `docker ps`.

After running docker-compose, you can interact with a group of containers via the `docker-compose` command, e.g., to kill all the containers started with `docker-compose up`, simply run `docker-compose kill`.

`Issue one-off commands to a container` Once docker-compose has been started, run `docker-compose run CONTAINER_NAME COMMAND` where `CONTAINER_NAME` is the name of a container defined in your `docker-compose.yml` and `COMMAND` is the command you'd like to run in that container.


### Config File Descriptions
`Dockerfile` - is `Docker`'s config file. It tells `Docker` how to build a container (a virtual machine) that will run the rails application. Think of each container as it's own service.

`docker-compose.yml` - is `docker-compose`'s config file. It tells `docker-compose` how to manage the services created by Docker (containers) and run them together.

`docker-compose.backend.sh` - is simply a script that's run when the 'backend' service is started by `docker-compose`.
