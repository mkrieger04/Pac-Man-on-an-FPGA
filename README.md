# Pac-Man-on-an-FPGA
Pac-Man on FPGA
An FPGA-based implementation of Pac-Man using a MicroBlaze soft processor, GPIO peripherals for keyboard input, and BRAM for handling intensive graphical features.

Features
Keyboard Input via USB: Utilizes the MAX3241E chip to enable keyboard controls for Pac-Man’s movement.
Game Mechanics:
Pac-Man navigates a maze, aiming to eat all pellets while avoiding ghosts.
Starts with three lives—losing all results in a game over.
Ghosts chase Pac-Man, attempting to deplete his lives.
Power pellets grant Pac-Man a temporary ability to eat ghosts, sending them back to their starting point.
Scoring System:
Each pellet: 2 points
Maximum score: 480 points (winning condition if all pellets are consumed before losing all lives).
This project demonstrates real-time game logic execution on an FPGA, integrating USB-based keyboard control and efficient memory management with BRAM.
