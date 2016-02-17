#!/bin/env bash

bucket=gs://[bucketname]

gsutil mb -c STANDARD -l ASIA $bucket
gsutil defacl set public-read $bucket
gsutil web set -m index.html -e error.html $bucket
gsutil -m rsync -r [DestinationPath] $bucket

