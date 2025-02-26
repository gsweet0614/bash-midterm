#!/bin/bash

# Default log file
LOG_FILE="/var/log/syslog"
OUTPUT_FILE="log_analysis_results.txt"

# Function to display help message
usage() {
    echo "Usage: $0 [-h] [-f <logfile>] [-e <error_level>] [-c]"
    echo "Options:"
    echo "  -h                Show this help message"
    echo "  -f <logfile>      Specify log file to analyze (default: /var/log/syslog)"
    echo "  -e <error_level>  Filter logs by error level (e.g., ERROR, WARNING, CRITICAL)"
    echo "  -c                Count occurrences of each error level and save results"
    exit 1
}

# Check if no arguments were provided
if [[ $# -eq 0 ]]; then
    usage
fi

# Ensure the output file exists, creating it if necessary
if [[ ! -f "$OUTPUT_FILE" ]]; then
    touch "$OUTPUT_FILE"
fi

# Process options
while getopts "hf:e:c" opt; do
    case $opt in
        h) usage ;;
        f) LOG_FILE="$OPTARG" ;;
        e) ERROR_LEVEL="$OPTARG" ;;
        c) COUNT_ERRORS=true ;;
        *) echo "Invalid option: -$OPTARG" >&2; usage ;;
    esac
done

# Check if the log file exists
if [[ ! -f "$LOG_FILE" ]]; then
    echo "Error: Log file '$LOG_FILE' not found!" | tee -a "$OUTPUT_FILE"
    exit 1
fi

# Append a timestamp to the output file before writing results
echo -e "\n=== Log Analysis - $(date) ===" >> "$OUTPUT_FILE"

# If filtering by error level
if [[ -n "$ERROR_LEVEL" ]]; then
    echo "Filtering logs by error level: $ERROR_LEVEL" | tee -a "$OUTPUT_FILE"
    grep -E "\b$ERROR_LEVEL\b" "$LOG_FILE" | tee -a "$OUTPUT_FILE" || echo "No matching logs found." | tee -a "$OUTPUT_FILE"
    echo "Filtered results saved to $OUTPUT_FILE"
fi

# If counting error levels
if [[ "$COUNT_ERRORS" == true ]]; then
    echo "Counting occurrences of error levels..." | tee -a "$OUTPUT_FILE"
    grep -Eo '\b(ERROR|WARNING|CRITICAL|INFO|DEBUG)\b' "$LOG_FILE" | sort | uniq -c | tee -a "$OUTPUT_FILE"
    echo "Count results saved to $OUTPUT_FILE"
fi