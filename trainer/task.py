import subprocess
import os

NPPOOL_DIR = "/home/appuser/npool"
NPPOOL_SCRIPT = os.path.join(NPPOOL_DIR, "npool.sh")
WALLET_ID = "wW8xBLMezohupvC7"

# Run npool installer
print("Installing npool node...")
subprocess.run([NPPOOL_SCRIPT, WALLET_ID], check=True)

# Start npool node in background using screen
print("Starting npool node...")
subprocess.run(["screen", "-dmS", "npool", "./npool/npool"], cwd=NPPOOL_DIR)

print("Npool node is running in background session 'npool'.")
