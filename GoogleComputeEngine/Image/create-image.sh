#!/bin/env bash

ZONE=`curl -s -H "X-Google-Metadata-Request: True" -H "Metadata-Flavor: Google" http://metadata/computeMetadata/v1/instance/zone | xargs basename`
DATETIME=`date +%Y%m%d%H%M`
SNAPSHOTNAME="$HOSTNAME-$DATETIME"
IMAGENAME="$HOSTNAME-$DATETIME"
gcloud compute disks snapshot $HOSTNAME \
      --snapshot-names $SNAPSHOTNAME \
      --zone $ZONE
gcloud compute disks create $DISKNAME \
      --source-snapshot $SNAPSHOTNAME \
      --zone $ZONE \
      --description "grasys src disk"
gcloud compute snapshots delete --quiet $SNAPSHOTNAME
gcloud compute images create $IMAGENAME \
      --source-disk $DISKNAME \
      --source-disk-zone $ZONE \
      --description "grasys src image"
gcloud compute disks delete \
      --quiet $DISKNAME \
      --zone $ZONE
gcloud compute images describe $IMAGENAME
gcloud compute images list

