#!/bin/env bash

LOG_BUCKET=gs://[bucketname]
BUCKET=gs://[bucketname]

gsutil mb -c NEARLINE -l ASIA $LOG_BUCKET
gsutil acl ch -g cloud-storage-analytics@google.com:W $LOG_BUCKET
gsutil defacl set project-private $LOG_BUCKET
gsutil logging set on -b $LOG_BUCKET -o access.log $BUCKET
gsutil logging get $BUCKET

