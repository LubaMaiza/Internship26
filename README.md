ASIC for Microcontroller Memory Testing


Hardware-Based Hamming (7,4) Error Correction Auditor
This repository contains the design and implementation of an ASIC Auditor designed to monitor the data integrity of microcontrollers and memory systems in real-time. The project follows a complete industry-standard ASIC design flow using 180nm CMOS technology.

📋 Project Overview
Microcontrollers in high-reliability environments (automotive, aerospace, medical) are susceptible to bit-flip errors caused by electrical noise or radiation. This project implements a dedicated hardware auditor that:

Generates protected (7,4) Hamming codes from 4-bit data.
Audits received data from a Microcontroller (MC).
Identifies the exact bit-position of any single-bit error using syndrome decoding.
🛠️ Technical Specifications
Technology Node: SCL 180nm CMOS
Algorithm: Hamming (7,4) Error Correction Code (ECC)
Clock Frequency: 100 MHz (10ns Period)
Total Die Area: 33,531 μm²
Power Consumption: 2.497 mW
Total Cell Count: 60
Timing Slack: +2.015 ns (MET)
🏗️ Design Architecture
The design is partitioned into three main Verilog modules:

1. Parity Generator (p_gen.v)
Input: 4-bit raw data.
Output: 7-bit Hamming code.
Feature: Raises a ready flag once the code is calculated and stable.
2. Parity Checker (p_check.v)
Input: 7-bit Hamming code (received from MCU).
Output: 3-bit Error Syndrome.
Feature: Identifies the bit index (1-7) where a fault occurred.
3. Top-Level / Pad Wrapper (parity_main.v)
An optimized 1-bit State Machine manages the operational flow, integrated with physical I/O pads:

GEN (0): Active encoding of data.
CHECK (1): Active auditing of MCU response.


🚀 ASIC Design Flow
The project was executed using the Cadence Digital Design Suite:

Functional Simulation: Verified logic correctness using Xcelium.
Logic Synthesis: Converted RTL to a gate-level netlist using Genus Synthesis Solution.
Floorplanning: Defined a die area with a 49-pad I/O ring (25 I/O, 20 Power, 4 Corner).
Power Planning: Implemented VDD/VSS rings and stripes for stable power distribution.
Placement: Optimized cell locations to minimize wire length.
Clock Tree Synthesis (CTS): Synchronized internal flip-flops with minimal skew.
Routing: Completed global and detailed routing of all signal nets.
Signoff: Verified timing, area, and power reports.

📊 Physical Design Details

A unique feature of this ASIC is its Pad-Limited nature. To maintain a near-square aspect ratio, a custom pad distribution was calculated:

3 Sides: 11 pads each (60μm spacing).
1 Side: 12 pads (50μm spacing).
Total Perimeter: Integrated 49 physical pads to allow real-world interfacing with external hardware.


👥 Team Members (Team 9)
Aardra S V
G Mary Priya
Luba Maiza
