#!/bin/bash

HADOOP_HOME=/home/cscarioni/programs/hadoop-0.22.0
JAR=contrib/streaming/hadoop-0.22.0-streaming.jar

HSTREAMING="$HADOOP_HOME/bin/hadoop jar $HADOOP_HOME/$JAR"

$HSTREAMING \
 -mapper  'ruby map.rb' \
 -reducer 'ruby reduce.rb' \
 -file map.rb \
 -file reduce.rb \
 -input '/home/cscarioni/Downloads/comedy_romance_movies' \
 -output /home/cscarioni/Downloads/comedy_romance_movies_results