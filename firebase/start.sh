#!/bin/sh

# Copy node_modules into volume-mounted directory so we can see them in dev environment
cp -r /home/node/functions-cache/. /home/node/app/functions/. && 

firebase --project=hot-summer-9a82c emulators:start --only auth,firestore,functions --import=./emulator-cache --export-on-exit & 

npm run build:watch --prefix ./functions