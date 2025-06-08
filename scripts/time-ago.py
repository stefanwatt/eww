#!/run/current-system/sw/bin/python
from datetime import datetime
import sys

def time_ago(unix_timestamp):
    # Convert Unix timestamp to datetime object
    timestamp = datetime.fromtimestamp(unix_timestamp)

    # Get current time
    now = datetime.now()

    # Calculate the time difference
    diff = now - timestamp

    # Calculate total seconds
    total_seconds = int(diff.total_seconds())

    # Define time intervals
    intervals = [
        (60 * 60 * 24 * 365, "year"),
        (60 * 60 * 24 * 30, "month"),
        (60 * 60 * 24 * 7, "week"),
        (60 * 60 * 24, "day"),
        (60 * 60, "hour"),
        (60, "minute"),
        (1, "second")
    ]

    # Find the appropriate interval
    for seconds, unit in intervals:
        count = total_seconds // seconds
        if count > 0:
            if count == 1:
                return f"{count} {unit} ago"
            else:
                return f"{count} {unit}s ago"

    return "just now"

arguments = sys.argv[1:]
if len(arguments) > 0:
    unix_timestamp = float(arguments[0])
else:
    try:
        input_data = sys.stdin.read().strip()
        unix_timestamp = float(input_data)
    except (ValueError, EOFError):
        unix_timestamp = 0
        print("could not get timestamp")

print(time_ago(unix_timestamp))
