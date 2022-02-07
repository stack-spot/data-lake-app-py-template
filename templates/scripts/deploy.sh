#!/bin/sh

set -e

if [ -z "$AWS_ACCESS_KEY_ID" ]; then
    echo "You must specify AWS_ACCESS_KEY_ID env. Exiting..." >&2
    exit 1
elif [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
    echo "You must specify AWS_SECRET_ACCESS_KEY env. Exiting..." >&2
    exit 1
elif [ -z "$AWS_SESSION_TOKEN" ]; then
    echo "You must specify AWS_SESSION_TOKEN env. Exiting..." >&2
    exit 1
fi

echo "Creating datalake component..."

docker run \
  -e "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" \
  -e "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" \
  -e "AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN" \
  -v "$PWD/components/datalake:/src/template" \
  -i "datalake-component:latest" \
  create datalake -f /src/template/manifest.yaml

