echo '
This is a help tool to start working with this repository

We assume you have Docker installed and working

  Run this command to start the example PostgreSQL database we have:
    - docker run -d --rm -v $PWD/db/dump:/docker-entrypoint-initdb.d --name pgraphdb -e POSTGRES_PASSWORD=postgres -p 5432:5432 postgres:latest
    Note: you can adjust the mapped port if you require it

  You can use any database tool to connect to the postgres database,
  but, if you need|want to connect using psql command, then run this:
    - docker exec -it pgraphdb psql postgres postgres

  Run this command to start the workspace:
    - docker run -it --rm -v $PWD:/pgraphws -w /pgraphws --net="host" --name pgraphws --user node node:latest bash

Inside the workspace (session oppened with the command above)
  Run this command to see all the steps:
    - ./steps.sh

Clean Up:
  The only thing we provoked in your local machine, it was the download of two docker images, so you can delete them in this way:
    - docker stop pgraphdb
    - docker stop pgraphws
    - docker rmi postgres:latest
    - docker rmi node:latest
  Finally delete the entire repository folder
'