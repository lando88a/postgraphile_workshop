# Postgraphile Workshop

This workshop is a simple guide to practice the basics of [Postgraphile](https://www.graphile.org/postgraphile/).

## Data structure

The workshop utilizes an existen database example taken from [Pagila](https://www.postgresqltutorial.com/postgresql-getting-started/postgresql-sample-database/) open source project,
which is a DVD rental database.

You can find a diagrama and metadata in the following file inside the current folder:

```./Films.pdf```

## Required Software

[Docker](https://www.docker.com/) is the only one requiement.


## How To Start

Please just open a terminal and run the RUNME.sh script to see the commands you require to start with the workshop.

```./RUNME.sh```

## Clean Up

To clean everything related with this workshop, you just need to ensure all Docker containers are stopped and deleted, and finally remove the Docker network and Docker images if you don't need them anymore:

```docker network rm pggraphnet```
```docker rmi postgres:latest```
```docker rmi node:latest```

Also, don't forget to delete the project repository folder.
