# Bandgap Reference Circuit Design for tapeout on TinyTapeout's experimental analog shuttle on Global Foundries 180nm (gf180mcuD) PDK.

Bandgap references (BGRs) are designed to be **stable voltage sources with well-defined temperature characteristics**.
Ideally we want something that doesn't fluctuate too much (stays within our tolerance) for our defined temperature range.
For this project the range we are using is `-40C <-> +125C` since that covers most industrial applications.


Bandgap references have the concept of **trimming**. If you design a BGR to output 1.2V, after process variations your design may output ~1.96V, etc.
Trimming refers to adding control bits in the design that vary your resistor ratios or bias current to bring your output voltage to the desired voltage.
This BGR will **not** have trimming since that requires extra components and the timeline for this project is 1 week.
