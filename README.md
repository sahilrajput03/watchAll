# README

This all is inspired from Stackoveflow's answer [here](https://superuser.com/a/181543/776589).

## Goal:

- To make a service similar to nodemon so nobody needs to install node just for the file watching service.
- Since with the use of `inotifywait` there's very much control of how I want this to behave.
-

## Run it like:

```bash
./watchDevelopment.sh 1.sh
./watchDevelopment.sh 2.sh
./watchDevelopment.sh node app.js # To be implemented later.
```
