#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
NC='\033[0m'

echo "Cleaning up Crypto Tracker..."

# Remove virtual environment if it exists
if [ -d "venv" ]; then
    rm -rf venv
fi

# Remove any cached files
find . -type d -name "__pycache__" -exec rm -r {} +
find . -type f -name "*.pyc" -delete

echo -e "${GREEN}Cleanup completed successfully!${NC}"