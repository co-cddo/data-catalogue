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