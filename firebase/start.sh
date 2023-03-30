#!/bin/sh

firebase --project=hot-summer-9a82c emulators:start --only auth,firestore,functions --import=./emulator-cache --export-on-exit & 

npm run build:watch --prefix ./functions