# DATA CATALOGUE

First time:

```console
$ docker compose build
$ docker compose run web bin/rails db:setup
$ docker compose up
```

Run specs:

```console
$ docker compose run web bundle exec rspec
```


## Windows Installation Guide
Prerequisites:

Windows Subsystem for Linux (WSL) must be installed.

Docker Desktop must be installed.


Steps:

Open a WSL terminal instance with the path set to the project folder.
Run the following command:
```
docker-compose build 
```
Once complete, run this command:
```
docker-compose up 
```
This terminal instance will be responsible for running the project container.

Next, open a new instance of a WSL terminal while the other terminal is still running.
Run the following command to set the environment and set up the database:
```
docker-compose run web bin/rails db:environment:set RAILS_ENV=development db:setup 
```
To view the application in the browser, use the following url:
http://localhost:3000/

The second terminal is where you can enter other docker commands, such as the following to run specs:
```
docker compose run web bundle exec rspec
```
### NB: Windows uses a line-ending system that is different to Linux. 
If you find that you receive the following error: 
```
/usr/bin/env: 'ruby\r': No such file or directory
```
 you may not have the right line-ending format.
To rectify this in VSCode, go to File -> Preferences -> Settings -> Search for EOL and change it to \n. This will change the formatting from CRLF (Windows default) to LF.