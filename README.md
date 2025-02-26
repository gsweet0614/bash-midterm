Gage Sweet - IT3038C Bash Midterm Project

- Log Analyzer

- Overview
`log_analyzer.sh` is a Bash script that helps analyze system log files. It finds errors, critical, and warnings in the log file specified by the user or from the default log file, counts the amount if the user wants that, and continues 

## Features
- 🕹 Supports custom log files
- 🕹 Filters logs by error level (e.g., ERROR, WARNING)
- 🕹 Counts occurrences of error levels
- 🕹 Displays a help message with `-h`

## Usage
./log_analyzer.sh [-h] [-f <logfile>] [-e <error_level>] [-c]
