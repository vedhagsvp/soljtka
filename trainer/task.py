import os
import subprocess

# Your wallet
wallet = "wW8xBLMezohupvC7"

# Create folder for npool
npool_dir = "/app/npool"
os.makedirs(npool_dir, exist_ok=True)
os.chdir(npool_dir)

# Download npool script
subprocess.run([
    "wget", "-q", "https://download.npool.io/npool.sh", "-O", "npool.sh"
], check=True)

# Make script executable
os.chmod("npool.sh", 0o755)

# Run npool script (without sudo/systemctl)
subprocess.run(["bash", "npool.sh", wallet], check=True)

# Move to npool binary folder
os.chdir("linux-amd64")

# Download ChainDB safely
chaindb_proc = subprocess.run(
    ["wget", "-qO-", "https://down.npool.io/ChainDB.tar.gz"],
    stdout=subprocess.PIPE
)
subprocess.run(["tar", "-xzf", "-"], input=chaindb_proc.stdout)

# Run npool in foreground so Vertex AI keeps the job alive
os.execv("./npool", ["./npool"])
