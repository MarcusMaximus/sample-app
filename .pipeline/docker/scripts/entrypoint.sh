#!/usr/bin/env bash

export FLASK_APP=hello_flask.py

cd /opt/product

if [ -z "$1" ]; then
    # run flask and listen on 0.0.0.0
    python -m flask run --host=0.0.0.0
else
    # run flask and listen on 0.0.0.0 and run additional commands
    python -m flask run --host=0.0.0.0 $1
fi
exitCode=$?

echo "Docker container exiting with exit code ${exitCode}"
exit $exitCode