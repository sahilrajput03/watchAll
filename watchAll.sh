#!/bin/bash
# nodemon -e java,xml,gradle -x ''
[ $# -le 1 ] && { echo "Please provide a executable and file as argument to run...

Usage:
          watchAll compiler/interpreter myFile.xyz
E.g.,
          watchAll node Program.js
          watchAll bash Program.sh
          watchAll python Program.py
          watchAll javac Program.java
"; exit 1; }

args=$@ # This is important coz $@ is not accessible in bash functino IDK WHY!
# My function `actions`:
actions () {
  # clear               # This is OPTIONAL ~sahil. # TODO: Add a flag to enable/disable it.
  old_pid=`[ $! ] && ps -aux | grep -v grep | grep -o $!` # FYI: Here I say to only run ps -aux.... command if $! is not empty.
  if [ $old_pid ] ; then echo @INFO:old_pid: $old_pid; kill $!; echo @KILL_INFO_1: Killed old process with id $!; fi
  # WORKS SMOOTH :> #if [ $! ] ; then kill $!; echo KILL_INFO: Killed old process with id $!; fi

  # echo dollarattherate: $args       # DEBUG ONLY.
    # ./2.sh $@ &                     # NOTE THE ENDING & IS ADDED NEWLY ~ SAHIL.
  # ^^OLD..
  # ./$args &                 # NOTE THE ENDING & IS ADDED NEWLY ~ SAHIL.
  $args &        # works good for ```node myapp.js``` # NOTE THE ENDING & IS ADDED NEWLY ~ SAHIL.
  echo @INFO: $! is the id of the 1.sh process.
  # Checking if the older process is still running or not and only kill it if it does.
  # trap - 1 2 3 15 #Clear earlier trap.

    trap '
      cur_pid=`[ $! ] && ps -aux | grep -v grep | grep -o $!`
      # Here I check if the subprocess already got killed or not because in case of node myApp.js it gets autokilled so there is no need to kill and throw process not found warning by kill command.
      # , whereas with ./watchAll bash 1.sh, it does not get killed so we need to kill it manually.
      if [ $cur_pid ] ; then 
          if [ $! ] ; then
          kill $!; echo;
          echo @KILL_INFO_2: Killed current process with id $!;
          fi
      fi
      ' exit             # Wow this works so cool... ~ Sahil.
}

actions
inotifywait -q -m -e close_write -r . |
while read -r filename event; do
  actions
done
# TODO: Test the case of input struck with bash input thing that sucked with nodemon earlier.. yo!
# ^^ The case is like when you use read and run & in the end of the script as we use it to run in background .., then our teminals stdin isn't connected to stdin of the our target script to run.. ? Get it??
# ?PASSED: add functinonality to run the program on the script execution as well somehow.
# ?PASSED: Check if previous script is running and kill if it is. Yikes!
# ?PASSED: Test nodemon app with this and do verify if multiple processes are not getting accumulated.