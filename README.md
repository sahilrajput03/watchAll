# README

This all is inspired from Stackoveflow's answer [here](https://superuser.com/a/181543/776589).

## Goal:

- To make a service similar to [`nodemon`](https://github.com/remy/nodemon) so nobody needs to install node just for the file watching service.
- Since the only dependency is`inotifywait` so we are customise this utility as I want specifically.

## Run it like:

```bash
./watchDevelopment.sh 1.sh
./watchDevelopment.sh 2.sh
./watchDevelopment.sh node app.js # To be implemented later.
```

## Todo

- Add `./watchall node app.js` facility by checking if the argument includes the extension .sh to identify if its bash script.
- Add a `-f` flag to watch only for that file only, i.e., currently I am using `-r` in `inotifywait` to watch over current directory and subdirectories recursively.
- Add exception to ignore watching for the `node_modules` by default.
