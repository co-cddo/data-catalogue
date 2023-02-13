# DATA CATALOGUE

First time:

```console
$ docker compose build
$ docker compose run web bin/rails db:setup
$ docker compose up
```

Run specs:

```console
$ docker compose run -e RAILS_ENV=test web bin/rails db:setup
$ docker compose run -e RAILS_ENV=test web bundle exec rspec
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

## Add a source

To add a source using the rake task:

```console
$ docker compose run  web bundle exec rake sources:create\['test source','https://localhost/uri'\]
```

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

## Docker Desktop configuration for Ruby Rails CLI/console

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
