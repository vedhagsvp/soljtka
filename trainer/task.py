import subprocess
import json
import os
import time

# Path to your Npool node
NPOOL_DIR = "/app/npool/linux-amd64"
NPOOL_EXEC = os.path.join(NPOOL_DIR, "npool")
CONFIG_FILE = os.path.join(NPOOL_DIR, "config.json")

def check_npool_running():
    """Check if Npool node is running"""
    try:
        # List processes and look for npool
        result = subprocess.run(["pgrep", "-f", NPOOL_EXEC],
                                capture_output=True, text=True)
        return bool(result.stdout.strip())
    except Exception as e:
        print("Error checking Npool process:", e)
        return False

def read_wallet():
    """Read wallet from config.json"""
    try:
        with open(CONFIG_FILE) as f:
            config = json.load(f)
        wallet = config.get("wallet", "UNKNOWN")
        print("Wallet:", wallet)
        return wallet
    except FileNotFoundError:
        print("Config file not found!")
        return None

def main():
    print("Starting trainer task...")
    
    # Wait for Npool node to start
    print("Checking if Npool node is running...")
    for i in range(10):
        if check_npool_running():
            print("Npool node is running!")
            break
        print("Waiting for Npool to start...")
        time.sleep(2)
    else:
        print("Warning: Npool node is not running!")

    # Read wallet
    wallet = read_wallet()

    # Example: run a local command against npool
    try:
        print("Getting node info...")
        result = subprocess.run([NPOOL_EXEC, "info"], capture_output=True, text=True)
        print(result.stdout)
    except FileNotFoundError:
        print("Npool executable not found!")

if __name__ == "__main__":
    main()
