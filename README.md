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
