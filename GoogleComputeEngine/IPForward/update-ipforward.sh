#!/bin/env bash

PRIORITY=65534

gcloud compute routes create redis-ipforward-$PRIORITY \
  --next-hop-instance redis02 \
  --next-hop-instance-zone asia-east1-c \
  --destination-range 10.1.1.1/32 \
  --priority $PRIORITY

