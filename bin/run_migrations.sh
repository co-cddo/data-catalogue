#!/bin/sh

set -e

echo "Running migrations"
bundle exec rails db:migrate

