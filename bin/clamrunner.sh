#!/bin/bash
DIR=$HOME/Downloads
SCAN_LOG=$HOME/.clamscan.log
QUARANTINE_FOLDER=$HOME/.quarantined

if [ -r "$HOME/.dbus/Xdbus" ]; then
  . "$HOME/.dbus/Xdbus"
fi

# Get rid of old log file
rm $SCAN_LOG 2> /dev/null

function handle-file() {
# Have to check file length is nonzero otherwise commands may be repeated
    clamdscan --fdpass $1
    if [ $? -eq 1 ];
    then
        /usr/bin/notify-send -i important "$1 is dodgy AF. Quarantining this shit"
        if [[ ! -d "$HOME/.quarantined" ]]
        then
            mkdir $QUARANTINE_FOLDER
        fi
        mv $1 $QUARANTINE_FOLDER/
    fi
}

inotifywait -q -m -e close_write,moved_to --format '%w%f' $DIR | while read FILE
do
    if [ -s $FILE ]; then
        handle-file $FILE
    fi
done
