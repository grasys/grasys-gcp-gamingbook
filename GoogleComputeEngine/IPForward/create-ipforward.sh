#!/bin/env bash

PRIORITY=65535

gcloud compute routes create redis-ipforward-$PRIORITY \
  --next-hop-instance redis01 \
  --next-hop-instance-zone asia-east1-b \
  --destination-range 10.1.1.1/32 \
  --priority $PRIORITY

