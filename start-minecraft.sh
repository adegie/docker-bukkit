#!/bin/bash
/root/copy_plugins.sh
if [[ "$TRAVIS" = true ]]; then
    echo "stop" | java -jar /minecraft/craftbukkit-1.*.jar
else
    screen -S minecraft java -jar /minecraft/craftbukkit-1.*.jar
fi
