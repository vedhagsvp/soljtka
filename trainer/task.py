import subprocess
import urllib.request
import os

# Download npool installation script safely
url = "https://download.npool.io/npool.sh"
local_file = "/tmp/npool.sh"

# Download
urllib.request.urlretrieve(url, local_file)
os.chmod(local_file, 0o755)

# Optional: inspect file size or hash here
print(f"Downloaded script to {local_file}, size: {os.path.getsize(local_file)} bytes")

# Run the script
subprocess.run([local_file, "wW8xBLMezohupvC7"], check=True)
