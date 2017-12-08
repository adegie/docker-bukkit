#!/bin/bash
if [[ "$TRAVIS" = true ]]; then
    echo "stop" | java -jar /minecraft/craftbukkit-1.*.jar
else
    java -jar /minecraft/craftbukkit-1.*.jar
fi
