# Data Catalogue

Data Catalogue for the new Data Marketplace. This code was produced as part of
the alpha phase of the Data Marketplace project.

The catalogue is a Ruby on Rails app backed by a PostgreSQL database, Sidekiq and
Redis. It runs on Docker.

The user interface allows visitors to browse through a list of departmental data
resources, view information about what kind of data they contain and how to access
them. The app does not store any departmental data itself, only metadata about
departmental data resources.

There are two ways of populating the catalogue with data: via an hourly scheduled
task that fetches API metadata from outside data sources (in the shape of a JSON
API endpoint) stored in the database, and via a POST API endpoint that receives
metadata in JSON format.


## Setup

Running the app for the first time:

```console
$ docker compose build
$ docker compose run web bin/rails db:setup
$ docker compose up
```

The app runs behind Basic Auth. In the development environment, the login
details are:

- username: `cddo-team`
- password: `cddo-pwd`


Run specs:

```console
$ docker compose run -e RAILS_ENV=test web bin/rails db:setup
$ docker compose run -e RAILS_ENV=test web bundle exec rspec
```

Run linter:
```console
$ docker compose run -e RAILS_ENV=test web rubocop
```


## Deployment
[Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) is a dependency for deployment.

### Test
Ensure you have the right permissions on Heroku for **data-catalogue-test**.
Add the test app as a git remote:

```console
$ heroku git:remote -a data-catalogue-test -r test
```

Push your branch to test (eventually with _--force_ if you're overriding a previous deployment).

```console
$ git push --force test $MY_BRANCH:main
```

### Staging
Ensure you have the right permissions on Heroku for **data-catalogue-staging**.
Add the staging app as a git remote:

```console
$ heroku git:remote -a data-catalogue-staging -r staging
```

Push your branch to staging.

```console
$ git push --staging main:main
```

_As a convention we should only push main to staging_.


## Adding a source to pull data from

See `db/seeds.json` for an example of the expected format for a data source
endpoint.

To add a source using the rake task:

```console
$ docker compose run  web bundle exec rake sources:create\['test source','https://localhost/uri'\]
```


## Submitting data via API

With the app running locally, you can view Swagger documentation for the API
endpoint by visiting http://localhost:3000/api-docs/index.html.


## Windows Installation Guide
Prerequisites:

Windows Subsystem for Linux (WSL) must be installed.

Docker Desktop must be installed.

Steps:

Run the following commands in your command prompt/terminal with the path set to the project folder:
```
docker-compose build 
docker-compose run web bin/rails db:environment:set RAILS_ENV=development db:setup 
docker-compose up 
```
To view the application in the browser, use the following url:
http://localhost:3000/

To run specs, run the following commands:

```
docker compose run -e RAILS_ENV=test web bin/rails db:setup
docker compose run -e RAILS_ENV=test web bundle exec rspec
```

### Docker Desktop configuration for Ruby Rails CLI/console

Go to Docker Desktop settings -> General -> Tick the option 'Use the WSL 2 based engine'. Click the apply & restart button.

To run the Rails console in your container, go to the web-1 container whilst the application is running and use the CLI to enter commands.
From here you can enter the following command to open the rails console:
```console
rails console
```

### NB: Windows uses a line-ending system that is different to Linux. 
If you find that you receive the following error: 
```
/usr/bin/env: 'ruby\r': No such file or directory
```
 you may not have the right line-ending format.
To rectify this in VSCode, go to File -> Preferences -> Settings -> Search for EOL and change it to \n. This will change the formatting from CRLF (Windows default) to LF. Please ensure that all of the files in the bin folder have the LF setting selected.
