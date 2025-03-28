#!/bin/bash
# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Project name (can be modified if needed)
PROJECT_NAME="crypto-tracker"

echo "Setting up Crypto Tracker environment..."

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

# Check if venv module is available
if ! python3 -m venv --help &> /dev/null; then
    echo -e "${RED}Python venv module is not available. Please install python3-venv package.${NC}"
    exit 1
fi

# Create virtual environment
echo "Creating virtual environment..."
python3 -m venv "${PROJECT_NAME}_env"

# Activate virtual environment
echo "Activating virtual environment..."
source "${PROJECT_NAME}_env/bin/activate"

# Upgrade pip to the latest version
pip install --upgrade pip

# Install requirements
echo "Installing Python dependencies..."
pip install -r requirements.txt

# Check installation status
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Installation completed successfully!${NC}"
    echo "Virtual environment is active."
    echo "To start the application, run: streamlit run app.py"
    echo ""
    echo "To deactivate the virtual environment later, simply type: deactivate"
else
    echo -e "${RED}Installation failed. Please check the error messages above.${NC}"
    # Deactivate the virtual environment if installation fails
    deactivate
    exit 1
fi
