# Docker Service Discovery spike

Who would have thought the world needs yet another spike for this?

## Getting IP of your box

    export EXAMPLE_ADDR=$(boot2docker ip) # I know...

## Running Consul

    docker run -d -p 8400:8400 -p 8500:8500 -p 8600:53/udp -h node1 progrium/consul -server -bootstrap -ui-dir /ui

## Starting registrator

    docker run -d -v /var/run/docker.sock:/tmp/docker.sock -h ${EXAMPLE_ADDR} gliderlabs/registrator consul://${EXAMPLE_ADDR}:8500/services

## Building and starting proxy

Proxy uses confd to current available services from Consul and to update
the haproxy configuration file.

    docker build -t examplehaproxy .
    docker run --rm -p 80:80 -p 1936:1936 -e CONSUL_ADDR=${EXAMPLE_ADDR}:8500 examplehaproxy:latest

Check port 1936 for fancy interface.

## Starting some "whoami" apps

    docker run -d -P -t jwilder/whoami

## Checking it out

    curl http://${EXAMPLE_ADDR}
