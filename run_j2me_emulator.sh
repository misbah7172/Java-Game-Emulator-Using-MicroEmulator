#!/bin/bash

echo "J2ME Emulator and Analyzer Docker Setup"
echo "======================================"
echo

# Create games directory if it doesn't exist
mkdir -p games
echo "Created 'games' directory for your J2ME JAR files"

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

# Allow X11 connections from Docker
if command -v xhost &> /dev/null; then
    echo "Setting up X11 for GUI emulator..."
    xhost +local:docker
fi

echo
echo "Building and starting the J2ME Emulator Docker container..."
docker-compose up --build

echo
echo "Container shutdown. To run again without rebuilding: docker-compose up"
echo "Your games are stored in the 'games' directory."