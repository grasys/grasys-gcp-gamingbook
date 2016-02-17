#!/bin/env bash

gcloud compute instances create client \
--can-ip-forward \
--boot-disk-auto-delete \
--image centos-6 \
--machine-type f1-micro \
--tags redis \
--zone asia-east1-a \
--metadata-from-file startup-script=/tmp/client_startup.sh

gcloud compute instances get-serial-port-output client \
--zone asia-east1-a

gcloud compute instances create redis01 \
--can-ip-forward \
--boot-disk-auto-delete \
--image centos-6 \
--machine-type f1-micro \
--tags redis \
--zone asia-east1-b \
--metadata-from-file startup-script=/tmp/redis_startup.sh

gcloud compute instances get-serial-port-output redis01 \
--zone asia-east1-b

gcloud compute instances create redis02 \
--can-ip-forward \
--boot-disk-auto-delete \
--image centos-6 \
--machine-type f1-micro \
--tags redis \
--zone asia-east1-c \
--metadata-from-file startup-script=/tmp/redis_startup.sh

