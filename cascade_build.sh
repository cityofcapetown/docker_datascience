#!/usr/bin/env bash

BUILD_TRIGGER="https://cloud.docker.com/api/build/v1/source/68095815-b057-4bb2-ac26-e2509ba1b9f7/trigger/$BUILD_SECRET/call/"
curl -X POST "$BUILD_TRIGGER"

# This code is for when we have a way of telling Docker hub to build a certain tag
#CHILD_IMAGES=$(ls -d */ | sed 's#/##')

#for child in $CHILD_IMAGES; do
#  echo "Triggering build for '$child'"
#  curl -v -H "Content-Type: application/json" --data "{'docker_tag': '$child'}" -X POST "$BUILD_TRIGGER"
#done