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



https://github.com/user-attachments/assets/fcafc8b9-3584-4358-aee9-ef325163a24a

This repo only contains code that I wrote. All Vivado / Univeristy sources inlcuding Micoblaze block are not included.
