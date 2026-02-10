import os
import time

# Optional: make sure npool is running
print("Starting Python trainer...")

# Your Python code here
# Example: monitor npool logs
npool_log = "/app/npool/linux-amd64/log.txt"
while True:
    if os.path.exists(npool_log):
        with open(npool_log) as f:
            lines = f.readlines()
            print("Last log:", lines[-1] if lines else "No logs yet")
    else:
        print("Waiting for npool log...")
    time.sleep(10)
