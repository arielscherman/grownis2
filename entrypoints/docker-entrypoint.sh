#!/bin/sh

# tells the /bin/sh shell that runs the script to fail fast if
# there are any problems later in the script.
set -e

# ensure that there won’t be server conflicts when we start the application.
if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

bundle exec rails s -b 0.0.0.0
