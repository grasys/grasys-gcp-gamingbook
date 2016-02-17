#!/bin/env bash

LOG_BUCKET=gs://[bucketname]

gsutil lifecycle set lifecycle.json $LOG_BUCKET
gsutil lifecycle get $LOG_BUCKET

