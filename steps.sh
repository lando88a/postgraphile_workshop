if [ ! -d /pgraphws ]; then
  echo '________________________________________
WARNING... You are NOT inside the workspace container!!!

Please be sure your are working this under the workspace Docker container,
if you have not run the container, then run it first with the ./RUNME.sh tool.
'
  exit 1
fi

case "$1" in
"1")
    echo '________________________________________
Step 1:

Current workspace environment has NodeJS ready to be used,
also there are several tools like npm and yarn available.

Start the node project, run this command:
  - yarn init -y
'
    ;;
"2")
    echo '________________________________________
Step 2:

Install postgraphile dependency, run this command:
  - yarn add postgraphile
'
    ;;
"3")
    echo '________________________________________
Step 3:

Excecute postgraphile as service, run this command:
  - yarn postgraphile -w -o \
      -n "0.0.0.0" \
      -p 3000 \
      -c "postgres://postgres:postgres@localhost:5432/postgres" &
  Note: adjust the postgraphile port (3000) if you require it, it should match with the port set when you ran the workspace Docker container
  Note: adjust the database port (5432) if you have changed it at the moment you ran the PostgreSQL database Docker container
  Note: you can use any PostgreSQL URL connection:
    - postgres://pg_user:pg_pass@pg_host:pg_port/pg_db?ssl=true
  Note: the command is running as background in order to avoid a terminal block
'
    ;;
"4")
    echo '________________________________________
Step 4:

Open Apollo Studio Sandbox, open following addres in your browser:
  https://studio.apollographql.com/sandbox/explorer/

Configure the service URL at the top-left corner as following:
  http://localhost:3000/graphql
  Note: use the same postgraphile port established at step 3

Explore the tool to interact with the graphql service
'
    ;;
"5")
    echo '________________________________________
Step 5:

Install Advance Filter PlugIn, run this command:
  - yarn add postgraphile-plugin-connection-filter

Now we must restart the service to use the PlugIn:
  First let'\''s recover the background process running this command:
    - fg
  Second stop the service pressing "Ctrl" + "c"
  Now add this to the running service command: --append-plugins postgraphile-plugin-connection-filter
  Then, the final command to start the service would be this one:
    - yarn postgraphile -w -o \
        --append-plugins postgraphile-plugin-connection-filter \
        -p 3000 \
        -c "postgres://postgres:postgres@localhost:5432/postgres" &
    Note: use the same ports established at step 3

Explore the Apollo Studio Sandbox again to see the PlugIn'\''s effect
  Run the command with step 4 if you need help to open it
'
    ;;
"6")
    echo '________________________________________
Step 6:

Install Advance Filter PlugIn, run this command:
  - yarn add postgraphile-plugin-nested-mutations

Now we must restart the service to use the PlugIn:
  First let'\''s recover the background process running this command:
    - fg
  Second stop the service pressing "Ctrl" + "c"
  Now add ",postgraphile-plugin-nested-mutations" to the PlugIns list of in the running service command
  Then, the final command to start the service would be this one:
    - yarn postgraphile -w -o \
        --append-plugins postgraphile-plugin-connection-filter,postgraphile-plugin-nested-mutations \
        -p 3000 \
        -c "postgres://postgres:postgres@localhost:5432/postgres" &
    Note: use the same ports established at step 3

Explore the Apollo Studio Sandbox again to see the PlugIn'\''s effect
  Run the command with step 4 if you need help to open it

Several PlugIns are referenced by the Postgraphile official documentation site:
  - https://www.graphile.org/postgraphile/introduction/
  Schema PlugIns are focused on customize the final GraphQL schema result. The ones we have integrated are example of these ones.
  Server PlugIns are focused on customize a different data source. For example to work with MongoDB instead of PostgreSQL.
'
    ;;
"7")
    echo '________________________________________
Step 7:

Customization by PostgreSQL views:

  First let'\''s connect to PostgreSQL with any client you prefer.
  You can still use psql client, just open a new terminal and run ./RUNME.sh to see how to do it.

  Second create any view you want, for example:
    CREATE VIEW store_films_count_view AS
    SELECT count(1), store_id
    FROM inventory
    GROUP BY store_id;

Explore the Apollo Studio Sandbox again to see the customization'\''s effect
  Run the command with step 4 if you need help to open it
'
    ;;
"8")
    echo '________________________________________
Step 8:

Customizing Queries by PostgreSQL functions:

  First let'\''s connect to PostgreSQL with any client you prefer.
  You can still use psql client, just open a new terminal and run ./RUNME.sh to see how to do it.

  Second create any function you want, for example:
    CREATE FUNCTION store_films_count_function(store_id int) RETURNS int AS $$
      SELECT count(1)
      FROM inventory
      WHERE inventory.store_id = store_films_count_function.store_id
    $$ LANGUAGE sql STABLE;

Explore the Apollo Studio Sandbox again to see the customization'\''s effect
  Run the command with step 4 if you need help to open it
'
    ;;
"9")
    echo '________________________________________
Step 9:

Customizing Computed Columns by PostgreSQL functions:

  First let'\''s connect to PostgreSQL with any client you prefer.
  You can still use psql client, just open a new terminal and run ./RUNME.sh to see how to do it.

  Second create any function you want, for example:
    CREATE FUNCTION customer_full_name(c customer) RETURNS text AS $$
      SELECT c.first_name || '\'' '\'' || c.last_name
    $$ LANGUAGE sql STABLE;

Explore the Apollo Studio Sandbox again to see the customization'\''s effect
  Run the command with step 4 if you need help to open it
'
    ;;
"10")
    echo '________________________________________
Step 10:

Customizing Mutations by PostgreSQL functions:

  First let'\''s connect to PostgreSQL with any client you prefer.
  You can still use psql client, just open a new terminal and run ./RUNME.sh to see how to do it.

  Second create any function you want, for example:
    CREATE FUNCTION rent_a_film(inventory_id int, customer_id int, staff_id int) RETURNS int AS $$
      INSERT INTO rental VALUES (
        DEFAULT,
        now(),
        inventory_id,
        customer_id,
        NULL,
        staff_id,
        DEFAULT
      )
      RETURNING rental_id;
    $$ LANGUAGE sql VOLATILE;

Explore the Apollo Studio Sandbox again to see the customization'\''s effect
  Run the command with step 4 if you need help to open it
'
    ;;
"11")
    echo '________________________________________
Step 11:

Customization by Smart Comments:

  First let'\''s create any comment you want, for example:
    COMMENT ON TABLE customer IS E'\''@name buyer'\'';
    COMMENT ON COLUMN rental.rental_date IS E'\''@name controlled_rental_date'\'';
    COMMENT ON TABLE rental IS E'\''@name controlled_rental\n@omit insert,update,delete'\'';
    COMMENT ON VIEW store_films_count_view IS E'\''@foreignKey (store_id) references store (store_id)'\'';
    COMMENT ON TABLE actor IS E'\''@omit'\'';

Several functionality can be customized by Smart Comments, you can visit this site to see more about it:
  - https://www.graphile.org/postgraphile/smart-tags/
'
    ;;
"12")
    echo '________________________________________
Step 12:

Add Security, Postgraphile JWT generation resources:

  First let'\''s connect to PostgreSQL with any client you prefer.
  You can still use psql client, just open a new terminal and run ./RUNME.sh to see how to do it.

  Second let'\''s create a PostgreSQL type to be used under the JWT_TOKEN metadata creation process:
    CREATE TYPE jwt_token_type AS (
      role text,
      exp integer,
      staff_id integer,
      username text
    );

  Third let'\''s activate the "pgcrypto" extension with this SQL command:
    CREATE EXTENSION pgcrypto;

  Fourth let'\''s create a password_hash column for staff table:
    ALTER TABLE staff ADD COLUMN password_hash text;

  Fifth let'\''s create a PostgreSQL trigger to crypt password automatically:
    CREATE FUNCTION crypt_password_function() RETURNS TRIGGER AS $$
    BEGIN
      NEW.password_hash := gen_salt('\''md5'\'');
      NEW.password := crypt(NEW.password, NEW.password_hash);
      RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;
    CREATE TRIGGER crypt_password_trigger
      BEFORE INSERT OR UPDATE OF password ON staff
    FOR EACH ROW EXECUTE PROCEDURE crypt_password_function();

  Now let'\''s create a PostgreSQL function to authenticate:
    CREATE FUNCTION authenticate(username text, password text) RETURNS jwt_token_type AS $$
    DECLARE
      staff_record staff;
    BEGIN
      SELECT * into staff_record FROM staff WHERE staff.username = authenticate.username;

      IF staff_record.password = crypt(authenticate.password, staff_record.password_hash) THEN
        RETURN (
          COALESCE(
            (
              SELECT '\''manager_role'\''
              FROM store
              WHERE manager_staff_id = staff_record.staff_id
            ),
            '\''staff_role'\''
          ),
          extract(epoch from now() + interval '\''5 minutes'\''),
          staff_record.staff_id,
          staff_record.username
        )::jwt_token_type;
      ELSE
        RETURN null;
      END IF;
    END;
    $$ LANGUAGE plpgsql STRICT SECURITY definer;
'
    ;;
"13")
    echo '________________________________________
Step 13:

Add Security, Creating PostgreSQL roles:

  First let'\''s connect to PostgreSQL with any client you prefer.
  You can still use psql client, just open a new terminal and run ./RUNME.sh to see how to do it.

  Second let'\''s create possible roles:
    CREATE ROLE manager_role; CREATE ROLE staff_role; CREATE ROLE default_role;

  Third let'\''s create a new staff record for staff_role:
    Use the Apollo Studio Sandbox again to run a mutation that creates the staff record
    Run the command with step 4 if you need help to open it

  Now let'\''s test the "authenticate" function created at step 12
    Use the Apollo Studio Sandbox again to run the mutation associated with the "authenticate" function
'
    ;;
"14")
    echo '________________________________________
Step 14:

Add Security, Apply grants to users:

We must restart the service to activate the Postgraphile JWT functionality:
  First let'\''s recover the background process running this command:
    - fg
  Second stop the service pressing "Ctrl" + "c"
  Now add the following options to the running service command:
    - --jwt-token-identifier public.jwt_token_type
    - --jwt-secret secret-word
    - --default-role default_role
  Then, the final command to start the service would be this one:
    - yarn postgraphile -w -o \
        --append-plugins postgraphile-plugin-connection-filter,postgraphile-plugin-nested-mutations \
        --jwt-token-identifier public.jwt_token_type \
        --jwt-secret secret-word \
        --default-role default_role \
        -p 3000 \
        -c "postgres://postgres:postgres@localhost:5432/postgres" &
    Note: use the same ports established at step 3

Now resources are not available to be used, so confirm you are not able to interact
with the service in the Apollo Studio Sandbox:
  Run the command with step 4 if you need help to open it

Apply grants to created roles:
  First let'\''s connect to PostgreSQL with any client you prefer.
  You can still use psql client, just open a new terminal and run ./RUNME.sh to see how to do it.

  Second run this SQL grants:
    - GRANT select ON customer TO staff_role;
    - GRANT select ON store TO manager_role;
    - GRANT select ON film TO default_role;

Generate JWT tokens running the mutation associated with the "authenticate" function,
same that we used at step 13, use the Apollo Studio Sandbox for this.
    Run the command with step 4 if you need help to open its
Note: This time the mutation'\''s result its different than last time, currently we are getting the JWT token.
Generate one token by each created role.

Test JWT tokens, configure the following HTTP header in the Apollo Studio Sandbox:
  HTTP header key: Authorization
  HTTP header value: Bearer JWT_TOKEN_HERE
  So HTTP header should be perceived in this way:
    Authorization: Bearer JWT_TOKEN_HERE
  Note: you can generate tokens again through the "authenticate" mutation if you need it, for example when they are expired

To read more about security in Postgraphile, you can visit this page:
  - https://www.graphile.org/postgraphile/security/
'
    ;;
"15")
    echo '________________________________________
Step 15:

Stop postgraphile service:
  First let'\''s recover the background process running this command:
    - fg
  Second stop the service pressing "Ctrl" + "c"
'
    ;;
"16")
    echo '________________________________________
Step 16:

Install ExpressJS dependency, run this command:
  - yarn add express

Install cors dependency, run this command:
  - yarn add cors
'
    ;;
"17")
    echo '________________________________________
Step 17:

Add an index.js file with an example code, run this command:
  Note: adjust the ExpressJS port (3000) if you require it, it should match with the port set when you ran the workspace Docker container

  - cat > index.js <<EOF
const express = require('\''express'\'')
const app = express()
const port = 3000

app.get('\''/'\'', (req, res) => {
  res.send("Hello world!")
})

app.listen(port, () => {
  console.log(\`ExpressJS listening on port \${port}\`)
})
EOF
'
    ;;
"18")
    echo '________________________________________
Step 18:

Update the index.js file with the Postgraphile library usage, run this command:
  Note: adjust the ExpressJS port (3000) if you require it, it should match with the port set when you ran the workspace Docker container
  Note: adjust the database port (5432) if you have changed it at the moment you ran the PostgreSQL database Docker container

  - cat > index.js <<EOF
const { postgraphile } = require('\''postgraphile'\'')
const Pool = require('\''pg-pool'\'')
const PostGraphileNestedMutations = require('\''postgraphile-plugin-nested-mutations'\'')
const ConnectionFilterPlugin = require('\''postgraphile-plugin-connection-filter'\'')
const cors = require('\''cors'\'')
const express = require('\''express'\'')
const app = express()
const port = 3000

const pool = new Pool({
  host: '\''localhost'\'',
  port: 5432,
  database: '\''postgres'\'',
  user: '\''postgres'\'',
  password: '\''postgres'\'',
  idleTimeoutMillis: 0.001,
})

const postgraphileOptions = {
  dynamicJson: true,
  cors: true,
  showErrorStack: '\''json'\'',
  extendedErrors: ['\''hint'\'', '\''detail'\'', '\''errcode'\''],
  legacyRelations: '\''omit'\'',
  jwtSecret: '\''secret-word'\'',
  jwtPgTypeIdentifier: '\''public.jwt_token_type'\'',
  appendPlugins: [PostGraphileNestedMutations, ConnectionFilterPlugin],
  graphileBuildOptions: {
    connectionFilterRelations: true,
  },
  watchPg: true,
  graphiql: true,
  pgDefaultRole: '\''default_role'\'',
}

app.use(cors())

app.use(
  postgraphile(pool, '\''public'\'', postgraphileOptions)
)

app.get('\''/'\'', function(req, res) {
  res.send("Hello world!")
})

app.listen(port, () => {
  console.log(\`ExpressJS listening on port \${port}\`)
})
EOF
'
    ;;
"19")
    echo '________________________________________
Step 19:

Excecute postgraphile as library, run this command:
  - node index.js &
  Note: the command is running as background in order to avoid a terminal block
'
    ;;
"20")
    echo '________________________________________
Step 20:

Open Apollo Studio Sandbox, open following addres in your browser:
  https://studio.apollographql.com/sandbox/explorer/

Configure the service URL at the top-left corner as following:
  http://localhost:3000/graphql
  Note: use the same ExpressJS port established at step 18

Explore the tool to interact with the graphql service
'
    ;;
"21")
    echo '________________________________________
Step 21 (Bonus):

Create a TypeScript client:

  Install TypeScript, run this command:
    - yarn add typescript

  Install ts-node to run typescript without transpiling it, run this command:
    - yarn add ts-node

  Install GenQL generator, run this command:
    - yarn add @genql/cli

  Install GenQL, run this command:
    - yarn add @genql/runtime

  Generate the GQL client, run this command:
    - yarn genql --endpoint http://localhost:3000/graphql --output ./gql_client
    Note: use the same ExpressJS port established at step 18

  Create code using the the generated client, create the file with this command:
    - cat > index.ts <<EOF
import { createClient } from "./gql_client"

const jwt_token = null
const client = createClient({
  headers: {
    ...(
      jwt_token ?
        { '\''Authorization'\'': \`Bearer \${jwt_token}\` } :
        {}
    )
  },
})

const runQuery = async () => {
  const queryResult = await client.query(
    {
      allFilms: [
        {
          first: 5,
          offset: 0
        },
        {
          nodes: {
            filmId: true,
            description: true
          }
        }
      ]
    }
  )
  console.log(queryResult.allFilms?.nodes)
}

runQuery()
EOF
'
    ;;
"22")
    echo '________________________________________
Step 22 (Bonus):

Run the TypeScript client:

  Run the client created at step 21, run this command:
    - yarn ts-node index.ts
'
    ;;
"23")
    echo '________________________________________
Step 23 (Bonus):

Create a ReactJS app to use the GQL client:

  Install create-react-app dependency, run this command:
    - yarn add create-react-app

  Create the ReactJS app using create-react-app library, run this command:
    Note: Please ignore the guide you are going to see when run the followin command, instead continue with the rest of the step 24
    - yarn create react-app gql-app --template typescript && echo "Please ignore the create-react-app guide and continue with step 24"

  Go inside gql-app, run this command:
    - cd gql-app

  Add GenQL client dependency to the react app, run this command:
    - yarn add @genql/runtime

  Add any ReactJS Hook Fetcher, for example SWR, run this command:
    - yarn add swr

  Copy the GQL client generate in step 21, run this command:
    - cp -r ../gql_client ./src
'
    ;;
"24")
    echo '________________________________________
Step 24 (Bonus):

Run the ReactJS app:

  Update the App.tsx file with the GQL client usage, run this command:
    - cat > src/App.tsx <<EOF
import '\''./App.css'\''
import useSWR from '\''swr'\''
import { createClient } from '\''./gql_client'\''

const client = createClient()

function App() {
  const fetcher = (params: object) =>
    client.query({
      allFilms: [
        {
          first: 5,
          offset: 0
        },
        {
          nodes: {
            filmId: true,
            description: true
          }
        }
      ],
    })
  const { data } = useSWR({}, fetcher)

  return (
    <div className="App">
      {
        data?.allFilms?.nodes.map(
          (film) => <div>{film.filmId}: {film.description}</div>
        )
      }
    </div>
  )
}

export default App
EOF

  Run the ReactJS gql-app aplication, run this command:
    Note: you can stop the ReactJS app by pressing "Ctrl" + "c"
    - yarn start
    Note: the ReactJS app will assign the port 3001, which should match the one set when we ran the workspace Docker container,
          if other port is assigned, then this could not work if you don'\''t re-run the workspace container with the
          corresponding port mapping.
'
    ;;
"25")
    echo '________________________________________
Step 25:

Clean Up everything:

  Frist stop the ReactJS app pressing "Ctrl" + "c"

  Second let'\''s recover the background process running this command:
    - fg

  Third stop the ExpressJS service pressing "Ctrl" + "c"

  Now let'\''s go out from the Docker container, run this command:
    - exit

  Stop the database Docker container, run this command:
    - docker stop pgraphdb

  Remove the Docker images, run these commands:
    - docker rmi postgres:latest
    - docker rmi node:latest

  And finally remove the Docker network, run these commands:
    - docker network rm pgraphnet

  We are done! Thanks for your time! I hope you enjoyed it!
'
    ;;
*)
    echo '________________________________________
This is a help tool to list all steps to be applied in the workshop

  Run again this tool using the step number (between 1 and 25) as parameter:
    - ./steps.sh 1
    - ./steps.sh 2
         ...
    - ./steps.sh 25

  Note: Last step is for Clean Up everything
'
    ;;
esac
