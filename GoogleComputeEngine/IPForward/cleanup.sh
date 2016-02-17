#!/bin/env bash

gcloud compute routes delete redis-ipforward-65535
gcloud compute routes delete redis-ipforward-65534
gcloud compute firewall-rules delete ipforward-redis
gcloud compute instances delete client --zone asia-east1-a
gcloud compute instances delete redis01 --zone asia-east1-b
gcloud compute instances delete redis02 --zone asia-east1-c
gcloud compute routes list
gcloud compute firewall-rules list
gcloud compute instances list

