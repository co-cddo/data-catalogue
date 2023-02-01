#!/bin/sh

(ls tmp/pids/server.pid && echo yes) && rm -f tmp/pids/server.pid
./bin/rails server -b 0.0.0.0