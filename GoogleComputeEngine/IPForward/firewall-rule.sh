#!/bin/env bash

gcloud compute firewall-rules create ipforward-redis \
--allow tcp:6379 --source-range 10.0.0.0/8

