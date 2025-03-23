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

# Check if pip is installed
if ! command -v pip &> /dev/null; then
    echo -e "${RED}pip is not installed. Please install pip first.${NC}"
    exit 1
fi

# Install requirements
echo "Installing Python dependencies..."
pip install -r requirements.txt

if [ $? -eq 0 ]; then
    echo -e "${GREEN}Installation completed successfully!${NC}"
    echo "To start the application, run: streamlit run app.py"
else
    echo -e "${RED}Installation failed. Please check the error messages above.${NC}"
    exit 1
fi