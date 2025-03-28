#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo "Installing Crypto Tracker dependencies..."

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}Python3 is not installed. Please install Python3 first.${NC}"
    exit 1
fi

# Check if uv is installed
if ! command -v uv &> /dev/null; then
    echo -e "${RED}uv is not installed. Installing uv...${NC}"
    python3 -m pip install uv
fi
uv venv
source ./venv/bin/activate

# Install dependencies using uv
echo "Installing Python dependencies with uv..."
uv build

uv run streamlit run app.py 
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Installation completed successfully!${NC}"
    echo "To start the application, run: uv run streamlit run app.py"
else
    echo -e "${RED}Installation failed. Please check the error messages above.${NC}"
    exit 1
fi


