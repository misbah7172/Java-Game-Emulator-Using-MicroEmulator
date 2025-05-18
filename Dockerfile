FROM openjdk:17-slim

# Install necessary tools
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    python3 \
    python3-pip \
    libxext6 \
    libxrender1 \
    libxtst6 \
    libxi6 \
    libxrandr2 \
    libfreetype6 \
    libfontconfig1 \
    libgtk2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy MicroEmulator JAR
RUN mkdir -p /app/emulator
COPY microemulator-2.0.4/microemulator.jar /app/emulator/microemulator.jar

# Copy custom device profile
COPY Custom320x240.xml /app/Custom320x240.xml

# Create emulator launcher script
RUN echo '#!/bin/sh\njava -jar /app/emulator/microemulator.jar "$@"' > /app/run_emulator.sh && \
    chmod +x /app/run_emulator.sh

# Create sample JAR games directory
RUN mkdir -p /app/games

# Create entry point script
RUN echo '#!/bin/sh\necho "J2ME Emulator and Analyzer"\necho "====================="\necho ""\necho "1. Run the emulator to play a game"\necho ""\nread -p "Choose an option (1): " option\n\ncase $option in\n  1)\n    /app/run_emulator.sh\n    ;;\n  *)\n    echo "Invalid option"\n    ;;\nesac' > /app/entrypoint.sh && \
    chmod +x /app/entrypoint.sh

# Make sure we have our mount points for adding JAR games
VOLUME ["/app/games"]

# Set display environment variable for GUI applications
ENV DISPLAY=:0

ENTRYPOINT ["/app/entrypoint.sh"]