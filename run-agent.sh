#!/bin/bash

./gradlew build -p scavenger-agent-java -x test
./gradlew build -p scavenger-demo -x test

java -Dscavenger.configuration=./scavenger-demo/scavenger.conf  \
     -javaagent:$(find scavenger-agent-java/build/libs/scavenger-agent-java-*.jar | tail -1) \
     -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005 \
     -jar $(find scavenger-demo/build/libs/scavenger-demo-*.jar | tail -1)
