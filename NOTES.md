# Notes learning about bandgap references

## [Carsten Wulf Youtube Video Notes](https://www.youtube.com/watch?v=3Z4YXoVmxx8)
Generating stable voltages is not the only problem, we also need to distribute them.
Since voltages are only defined between 2 points and not at a node we need to ensure that a similar voltage difference exists between all sets of 2 points we care about.
So when i distribute a known voltage over a wire, the wire has some resistance which will change voltage reffered to GND compared to ref voltage.
Also ground's for both local 2 points maybe different.
There's usually not resistance to GND in wires but there is capacitance and therefore a time delay.
So to distribute reference voltages in a circuit, you could distribute them in the current domain.
So for eg. for current flowing in a closed loop if you ensure part A and part B has same resistance then they have same voltage.
But since you can't make resistors that accurate you can't use currents cz there will be tolerance differences.

So what you could do is propagate the voltage using current but keep the reference close to wherever needs it that way we can ignore resistances by wires.

Traditional way to make good voltage reference is a bandgap voltage reference.

BGR consists of:-

Make a current mirror with the following circuits:-
1. CTAT (Complementary To Absolute Temperature)
2. PTAT (Proportional To Absolute Temperature)


## Random notes as i read resources and try things

BGRs are based on circuits created by [Widlar](research-papers/widlar-bandgap-reference-paper.pdf) in 1971, and improved by [Brokaw](research-papers/widlar-bandgap-reference-paper.pdf) in 1974.
Ideally, a bi-polar or BiCMOS process is more well suited for this since they have first class BJTs (bipolar devices)
However, most CPU BGRs are usually made of **parasitic BJTs**, these are devices that the process was not created to make but are hidden in the geometry of MOSFETS and can cause issues if they act like bi-polar structures causing issues like **latch-up**
However, these parasitic BJTs can be exploited for use cases like Bandgap References.
