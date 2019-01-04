#!/usr/bin/env bash

images=$(ls -d */ | cut -f1 -d'/')
echo $images

if [ -z "$TRIGGER" ] && [ -z "$BUILD_SECRET" ]; then
    echo "TRIGGER or BUILD_SECRET not set"
else
    for image in $images; do
        if [ "$image" != "hooks" ]; then
            echo "Triggering "$image""
            curl -v \
                 -H "Content-Type: application/json" --data "{\"docker_tag\": \"$image\"}" \
                 -X POST https://cloud.docker.com/api/build/v1/source/"$TRIGGER"/trigger/"$BUILD_SECRET"/call/
        fi
    done
fi