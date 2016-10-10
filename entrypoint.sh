#!/bin/sh

# Exit on any error
set -e

# Log the user into the container
python3 utils/login.py
sleep 2

# Update the manifest
python3 utils/update_manifest.py
sleep 2

# Run the app's long-running server
python3 server.py
