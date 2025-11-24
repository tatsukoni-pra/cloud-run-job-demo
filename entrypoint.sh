#!/bin/bash

SCRIPT_DIR=$(dirname "$0")
ITERATIONS=100
TOTAL_TIME=0

echo "Starting benchmark: $ITERATIONS iterations"
echo "======================================"

for i in $(seq 1 $ITERATIONS); do
    output=$(python3 "$SCRIPT_DIR/gdrive_api_connect.py")

    # Extract elapsed time from output
    elapsed=$(echo "$output" | grep "Elapsed time" | awk '{print $3}')

    echo "[$i/$ITERATIONS] $output"

    # Add to total
    TOTAL_TIME=$(echo "$TOTAL_TIME + $elapsed" | bc)

    # Wait 3 seconds (except for the last iteration)
    if [ $i -lt $ITERATIONS ]; then
        sleep 3
    fi
done

echo "======================================"
AVERAGE=$(echo "scale=3; $TOTAL_TIME / $ITERATIONS" | bc)
echo "Average elapsed time: $AVERAGE seconds"
