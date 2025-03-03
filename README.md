# Pac-Man-on-an-FPGA
An FPGA-based Pac-Man implementation using a MicroBlaze soft processor, GPIO peripherals for keyboard input, and BRAM for graphical storage. The game features a maze constructed from 8x8 tiles, custom FontROM graphics, and real-time movement logic.

Features
Keyboard Input via USB (MAX3241E): Controls Pac-Man’s movement.
Ghost AI: Three ghosts with unique movement patterns that chase Pac-Man.
Power Pellets: Temporarily enable Pac-Man to eat ghosts.
Score & Collision System: Tracks pellet consumption, ghost interactions, and win/loss conditions.
Custom VGA Display: Rendered using a BRAM-based background and sprite animations.
Built as a final project for ECE 385 at UIUC, integrating hardware-accelerated game logic with efficient memory management.

Below is a live demo of the game.
