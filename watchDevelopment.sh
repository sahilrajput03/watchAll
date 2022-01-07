#!/bin/bash
# nodemon -e java,xml,gradle -x ''
[ $# -eq 0 ] && { echo "Error: Please provide a file as argument to run.."; exit 1; }

args=$@ # This is important coz $@ is not accessible in bash functino IDK WHY!
# My function `actions`:
actions () {
  clear               # This is OPTIONAL ~sahil. # TODO: Add a flag to enable/disable it.
  # echo dollarattherate: $args       # Debug only.
    # ./2.sh $@ &                     # Note the ending & is added newly ~ Sahil.
  # ^^OLD..
  ./$args &                 # Note the ending & is added newly ~ Sahil.
  # $@ &        # works good for ```node myapp.js``` # Note the ending & is added newly ~ Sahil.
  echo @INFO: $! is the id of the 1.sh process.
  # Checing if older process is still running or not and only kill it if it does.
  trap 'if [ $! ] ; then kill $!; echo; echo @KILL_INFO: Killed current process with id $!; fi' exit             # Wow this works so cool... ~ Sahil.
}

actions
inotifywait -q -m -e close_write -r . |
while read -r filename event; do
  old_pid=`[ $! ] && ps -aux | grep -v grep | grep -o $!`
  # FYI:   ^^^^^^^^^ Here I say to only run ps -aux.... command if $! is not empty.
  echo @INFO:old_pid: $old_pid
  if [ $old_pid ] ; then kill $!; echo @KILL_INFO: Killed old process with id $!; fi
  # works smooth :> #if [ $! ] ; then kill $!; echo KILL_INFO: Killed old process with id $!; fi
  actions
done
# TODO: Test the case of input struck with bash input thing that sucked with nodemon earlier.. yo!
# ?PASSED: add functinonality to run the program on the script execution as well somehow.
# ?PASSED: Check if previous script is running and kill if it is. Yikes!
# ?PASSED: Test nodemon app with this and do verify if multiple processes are not getting accumulated.