# J2ME Emulator and Analyzer

This project runs a J2ME emulator (MicroEmulator) inside a Docker container, allowing you to play J2ME games with a custom display size. Works on Windows, macOS, and Linux.

## Prerequisites

- Docker Desktop (or Docker Engine) and Docker Compose
- Git
- X11 server for GUI support:
  - **Windows:** [VcXsrv](https://sourceforge.net/projects/vcxsrv/)
  - **macOS:** [XQuartz](https://www.xquartz.org/)
  - **Linux:** Native X11

## Installation

1. **Clone the repository:**
   ```sh
   git clone <repository-url>
   cd JavaMobileEmulator
   ```

2. **Place the MicroEmulator JAR:**
   - Create a directory named `microemulator-2.0.4` in the project root.
   - Place `microemulator.jar` inside `microemulator-2.0.4/`.

3. **Platform-specific X11 setup:**
   - **Windows:** Start VcXsrv (XLaunch), choose "Multiple windows", "Start no client", and check "Disable access control".  
     Set the environment variable:  
     ```sh
     set DISPLAY=host.docker.internal:0.0
     ```
   - **macOS:** Start XQuartz, allow network clients in preferences, and run:  
     ```sh
     xhost + localhost
     ```
   - **Linux:**  
     ```sh
     xhost +local:docker
     ```

4. **Run the setup script:**
   ```sh
   ./setup.sh
   ```

## Usage

1. **Start the emulator:**
   ```sh
   ./run_j2me_emulator.sh
   ```

2. **In the emulator menu:**
   - Choose option `1` to run the emulator.
   - In the MicroEmulator window, go to `File > Open MIDlet File...`
   - Select your J2ME game JAR from `/app/games`.

3. **Set the display size:**
   - Go to `Options > Device > Open Device...`
   - Select `Custom320x240.xml` for a 320x240 display.

## Adding Games

- Place your J2ME game JAR files in the `games` directory. They will be available inside the container at `/app/games`.

## Troubleshooting

- **X11 Connection Issues:** Ensure your X11 server is running and accessible.
- **Missing JAR File:** Make sure `microemulator.jar` is in `microemulator-2.0.4/`.
- **Display Problems:** Check your X11 server settings and DISPLAY environment variable.
- **Game Compatibility:** Some games using manufacturer-specific APIs (like Nokia's DeviceControl) may not work.

## Custom Device Profile

A custom device profile (`Custom320x240.xml`) is included for a 320x240 display. You can modify this file for other resolutions.

## Key Mappings

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

## License

MIT License 