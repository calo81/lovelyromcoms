#!/bin/bash

HADOOP_HOME=/Users/cscarioni/Programs/hadoop-0.22.0
JAR=contrib/streaming/hadoop-0.22.0-streaming.jar

HSTREAMING="$HADOOP_HOME/bin/hadoop jar $HADOOP_HOME/$JAR"

$HSTREAMING \
 -mapper  'ruby movie_extractor_mapper.rb' \
 -reducer 'ruby movie_extractor_reducer.rb' \
 -file movie_extractor_mapper.rb \
 -file movie_extractor_reducer.rb \
 -input input.txt \
 -output recommendation_file