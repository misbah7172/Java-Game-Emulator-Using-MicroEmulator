# J2ME Emulator and Analyzer

This project runs a J2ME emulator (MicroEmulator) inside a Docker container, allowing you to play J2ME games with a custom display size.

## Prerequisites

- Docker and Docker Compose installed on your system.
- X11 server running (for GUI support).

## Installation

1. **Clone the repository:**
   ```sh
   git clone <repository-url>
   cd JavaMobileEmulator
   ```

2. **Place the MicroEmulator JAR:**
   - Create a directory named `microemulator-2.0.4` in the project root.
   - Place the `microemulator.jar` file inside this directory:
     ```sh
     mkdir -p microemulator-2.0.4
     mv /path/to/your/microemulator.jar microemulator-2.0.4/microemulator.jar
     ```

3. **Allow X11 connections from Docker:**
   ```sh
   xhost +local:docker
   ```

4. **Build the Docker image:**
   ```sh
   sudo docker-compose build
   ```

## Usage

1. **Run the emulator in interactive mode:**
   ```sh
   sudo docker-compose run --rm j2me-emulator
   ```

2. **In the emulator menu:**
   - Choose option `1` to run the emulator.
   - In the MicroEmulator window, go to `File > Open MIDlet File...`
   - Navigate to `/app/games` and select your J2ME game JAR (e.g., `JB-320x240.jar`).

3. **Set the display size:**
   - Go to `Options > Device > Open Device...`
   - Select `Custom320x240.xml` to set the display size to 320x240.

## Custom Device Profile

A custom device profile (`Custom320x240.xml`) is included in the project. It sets the display size to 320x240 pixels. You can modify this file to change the display size or add additional device configurations.

## Troubleshooting

- **X11 Connection Issues:** If you encounter X11 connection errors, ensure you've run `xhost +local:docker` before starting the emulator.
- **Missing JAR File:** Ensure `microemulator.jar` is placed in the `microemulator-2.0.4` directory.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Features

### JAR Analysis
- Extract and display manifest information from J2ME applications
- Parse MIDlet entries and verify their resources
- Analyze JAR structure, including class files and resources
- Identify package structures and dependencies

### Emulation
- Run actual J2ME games with MicroEmulator's graphical interface
- Use keyboard controls to navigate and play
- Support for multiple MIDlets within a single JAR

### Current Tools

1. **Basic Manifest Analyzer** (`j2me_analyzer_demo.py`)
   - Simple demonstration of manifest parsing
   - Shows basic application properties and MIDlet entries

2. **JAR File Generator** (`j2me_jar_analyzer.py`)
   - Creates sample J2ME JAR files for testing
   - Demonstrates proper J2ME manifest structure

3. **Full JAR Analyzer** (`analyze_j2me_jar.py`)
   - Command-line tool to analyze any J2ME JAR file
   - Detailed breakdown of application structure
   - Resource verification and package analysis

## Manual Usage (Without Docker)

### Analyzing a J2ME JAR file

To analyze a J2ME JAR file directly:

```
python3 analyze_j2me_jar.py path/to/your/game.jar
```

If no file is specified, a sample JAR will be created and analyzed:

```
python3 analyze_j2me_jar.py
```

## J2ME Platform Overview

### Components

1. **Configuration**: CLDC (Connected Limited Device Configuration)
   - Provides basic Java libraries and virtual machine capabilities
   - Typically CLDC 1.0 or 1.1 for most mobile phones

2. **Profile**: MIDP (Mobile Information Device Profile)
   - Built on CLDC, provides application lifecycle management
   - Handles user interface, networking, and persistent storage
   - MIDP 2.0 is most common for games, with better UI and game APIs

3. **MIDlet**: The application itself
   - Every J2ME application is a subclass of `javax.microedition.midlet.MIDlet`
   - Has lifecycle methods: `startApp()`, `pauseApp()`, `destroyApp()`

### Key Mappings for Emulation

| Key      | Function        |
|----------|-----------------|
| 2/W      | Up              |
| 8/S      | Down            |
| 4/A      | Left            |
| 6/D      | Right           |
| 5/Space  | Fire/Select     |
| 1        | Game A          |
| 3        | Game B          |
| 7        | Game C          |
| 9        | Game D          |
| *        | Soft Key 1      |
| #        | Soft Key 2      |

## Future Development

The next steps for this project include:
- Enhanced emulation accuracy
- Better UI for game selection and configuration
- Support for additional J2ME APIs and features
- Performance optimizations