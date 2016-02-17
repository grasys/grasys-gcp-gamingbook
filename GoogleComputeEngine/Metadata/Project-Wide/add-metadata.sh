#!/bin/env bash

gcloud compute project-info add-metadata ¥
  --metadata-from-file redis=redis.json

