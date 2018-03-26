# wait-for-mysql

These snippets can be used when an application needs to wait for a MySQL server to respond.

Tested with MySQL 5.7.

## Testing
## Without docker-compose
Create a test network to connect your containers.
```bash
docker network create test-net
```

Build the `wait-for-mysql` container.
```bash
docker build --tag wait-for-mysql .
```

Start the `wait-for-mysql` container. It will sit there waiting until the MySQL database is ready.

Note the MYSQL_ADDRESS variable: We are telling the container where to look for the database. Notice that we can use
the name of the `mysql` container (see below) directly instead of an IP address. This is because they are on the same
Docker network.
```bash
docker run --rm --network test-net --env MYSQL_ADDRESS=mysql wait-for-mysql
```

In another terminal start the `mysql` official container.
```bash
docker run --rm -it --network test-net --env MYSQL_RANDOM_ROOT_PASSWORD=true --name mysql mysql
```

Notice that after the `mysql` container prints that is is ready for connections, the `wait-for-mysql` one prints a
success message and exits. In your corresponding application, instead of exiting, you would continue with the rest of
your execution.

To stop the `mysql` container after the test is done, you can run
```bash
docker stop mysql
```

### With docker-compose
Run the following from this directory
```bash
docker-compose up
```

Both containers will start. Notice that `wait-for-mysql` will do nothing until the database is ready. Then it will print
a success message and exit.

## Dependencies
The shell scripts use **netcat**. It is light-weight so it will not negatively affect your image size.
License: GPL. 

Below you can find information relevant to the base image you are using in your Dockerfile. You can copy-paste the `RUN`
command into your Dockerfile to get `netcat`.

### Alpine
Size: 44 kB

Dockerfile command
**None needed**: Alpine already comes with netcat.

### Ubuntu and Debian
Size: 30 kB
Dockerfile command
```dockerfile
RUN apt-get update && apt-get install -y \
    netcat \
 && rm -rf /var/lib/apt/lists/*
```
