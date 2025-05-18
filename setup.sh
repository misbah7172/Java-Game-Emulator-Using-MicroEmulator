#!/bin/bash

echo "J2ME Emulator Setup Script"
echo "========================="
echo

# Detect OS
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="Linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macOS"
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    OS="Windows"
else
    echo "Unsupported operating system"
    exit 1
fi

echo "Detected OS: $OS"
echo

# Create necessary directories
mkdir -p games
mkdir -p microemulator-2.0.4

# Platform-specific setup
case $OS in
    "Linux")
        echo "Setting up for Linux..."
        # Check if Docker is installed
        if ! command -v docker &> /dev/null; then
            echo "Installing Docker..."
            sudo apt-get update
            sudo apt-get install -y docker.io docker-compose
            sudo usermod -aG docker $USER
            echo "Please log out and log back in for Docker group changes to take effect"
        fi
        
        # Allow X11 connections
        xhost +local:docker
        ;;
        
    "macOS")
        echo "Setting up for macOS..."
        # Check if XQuartz is installed
        if ! [ -d "/Applications/XQuartz.app" ]; then
            echo "Please install XQuartz from https://www.xquartz.org/"
            exit 1
        fi
        
        # Allow X11 connections
        xhost + localhost
        ;;
        
    "Windows")
        echo "Setting up for Windows..."
        # Check if VcXsrv is installed
        if ! [ -d "/c/Program Files/VcXsrv" ]; then
            echo "Please install VcXsrv from https://sourceforge.net/projects/vcxsrv/"
            exit 1
        fi
        
        # Set DISPLAY environment variable
        export DISPLAY=host.docker.internal:0.0
        ;;
esac

# Check if microemulator.jar exists
if [ ! -f "microemulator-2.0.4/microemulator.jar" ]; then
    echo "Error: microemulator.jar not found in microemulator-2.0.4 directory"
    echo "Please place microemulator.jar in the microemulator-2.0.4 directory"
    exit 1
fi

# Build Docker image
echo "Building Docker image..."
docker-compose build

echo
echo "Setup complete!"
echo "To run the emulator, use: ./run_j2me_emulator.sh"
echo 