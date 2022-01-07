#!/bin/bash
# TODO: to be backuped up at sahilrajput03/learning-bash.md file.
# Demo: Add this example as combined usage of test and exec command.
# Src: https://www.linuxjournal.com/content/bash-co-processes
# Parse command line options.
# Execute the following if --log is seen.
if test -t 1; then
    # To execute this case, you can run `myScript.sh`
    # Stdout is a terminal i.e., not a pipe.
    echo All ouput will be saved to file log.
    echo You are NOT piping script ouput.
    exec >log 2>&1 # Redirect stdout and stderr to file log. Order is important.
else
    # To execute this case, you can run `./myScript.sh | cat` or `./myScript.sh | grep myText`.
    # Stdout is a pipe i.e., not a terminal.
    echo You are piping script output.
fi

echo Goodbye1
echo Goodbye2
echo Goodbye3
echo This is error message. >&2 # ~sahil: This is how we send some text to stderr.
echo Good bye final.