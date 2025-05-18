#!/bin/bash

echo "J2ME Emulator and Analyzer Docker Setup"
echo "======================================"
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

# Platform-specific X11 setup
case $OS in
    "Linux")
        echo "Setting up X11 for Linux..."
        xhost +local:docker
        ;;
    "macOS")
        echo "Setting up X11 for macOS..."
        xhost + localhost
        ;;
    "Windows")
        echo "Setting up X11 for Windows..."
        export DISPLAY=host.docker.internal:0.0
        ;;
esac

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Error: Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if docker-compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "Error: docker-compose is not installed. Please install docker-compose first."
    exit 1
fi

# Check if microemulator.jar exists
if [ ! -f "microemulator-2.0.4/microemulator.jar" ]; then
    echo "Error: microemulator.jar not found in microemulator-2.0.4 directory"
    echo "Please place microemulator.jar in the microemulator-2.0.4 directory"
    exit 1
fi

echo
echo "Starting the J2ME Emulator Docker container..."
docker-compose run --rm j2me-emulator

echo
echo "Container shutdown. To run again: docker-compose run --rm j2me-emulator"
echo "Your games are stored in the 'games' directory."