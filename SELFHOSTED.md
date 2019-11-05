### Self Hosting with Docker

Prerequisites:
* Server running docker and docker-compose
* This `standardnote/rails-server` repository cloned on the server

### Development

If you just want to try out hosting or want to create a feature, the quickest way to get up and running is to use the Docker image contained in this repository.

You should be able to run the following two commands to get up and running:

```
# Note the period at the end of this next line:
$ docker build -t stdnote_server .

$ docker run -d -p 3000:3000 stdnote_server
```

A few notes:
* This will start the server in "detached" mode so you will get your terminal prompt back.
* Remove the `-d` of the `docker run` command to leave the server running in the foreground
* To stop the server in "detached" mode, run `docker stop stdnote_server`
* To change the port mappings, change the `-p 3000:3000` line:
  * Format: `-p HOST_PORT:CONTAINER:PORT`
  * Example: `-p 8080:3000` would let you access the server on port 8080 of your server.

### Production

It's recommended to run production instances of Standard Note using `docker-compose`. This will set up and use a MySQL database and will provide more security. To do this we need to add a few environment variables to our `.env` file

Copy the `env.sample` to `.env`

```bash
$ cp env.sample .env
```

Then we will need to obtain or `APP_SECRET`

```bash
$ docker build -t stdnote_server .
$ docker run --rm stdnote_server bundle exec rake secret
```

The last command will spit out a really long string. Copy that string.

Inside of the `.env` file, we will configure the database and set the application secret.

```
SECRET_KEY_BASE=really-long-string-from-above

DB_USERNAME=your-db-user
DB_PASSWORD=your-db-users-password
DB_DATABASE=standardnote_db
DB_HOST=stdnote_db
DB_PORT=3306
```

Once you've set your environment variables we'll set up the rails application and database connection

```bash
$ docker-compose build

$ docker-compose up -d
```

Then we'll need to allow the server to write to the db. We need to attach to the database container:

```bash
$ docker exec -it ruby-server_db_1 /bin/bash
```

Then log into MySQL and make the necessary changes:

```bash
$ mysql -u root -p
# You'll be prompted for your root password

mysql> ALTER USER 'your-standard-note-database-user]'@'%' IDENTIFIED WITH mysql_native_password BY 'your-standard-note-db-user-password';
```

If successful you'll see

```bash
Query OK, 0 rows affected (0.00 sec)
```

Then we can exit out of the program and container by typing `exit` twice.

Finally, we just need to run the migration on the database:

```bash
$ docker exec ruby-server_server_1 rails db:migrate
```

This will leave you with a production instance of standardnote server in the background and can be accessible via the web app at `http://localhost:3000` or at your IP address, port 3000
