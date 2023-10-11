#!/bin/bash

# Define a log file to keep track of container start and end times
LOGFILE="/root/log/container_log.txt"

# Initialize a counter
COUNTER=0

# Infinite loop to keep creating new containers after one exits
while true; do
    # Increment the counter by 1
    COUNTER=$((COUNTER + 1))

    # Get the start time
    START_TIME=$(date +"%Y-%m-%d %H:%M:%S")

    # Log the start time and the counter value to the log file
    echo "Container start count: $COUNTER, started at: $START_TIME" >> "$LOGFILE"

    # Run the Docker container
    # Note: If a container with name=faban_client exists, it should be removed before starting a new one
    RANDOM_NUMBER=$((RANDOM % 500))
    echo "LOAD_SCALE: $RANDOM_NUMBER" >> "$LOGFILE"
    docker run --net=host --name=faban_client cloudsuite/web-serving:faban_client 192.168.122.133 $RANDOM_NUMBER

    # Get the end time
    END_TIME=$(date +"%Y-%m-%d %H:%M:%S")

    # Log the end time to the log file
    echo "Container ended at: $END_TIME" >> "$LOGFILE"

    # Remove the stopped container to free up the name
    docker rm faban_client
done