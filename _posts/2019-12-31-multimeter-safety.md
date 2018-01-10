---
title: How to use a multimeter safely
tags: safety small-electricity
copyright: CC0
last_modified_at: 2019-12-31 08:24:01 +0000
---

Several times I have set out to guide someone in safe and effective use of a [multimeter](https://en.wikipedia.org/wiki/Multimeter), so it's time to write an article.

There are already many articles and tutorials out there about [how to use a multimeter](https://geoffthegreygeek.com/using-a-multimeter/).  [This one at Sparkfun](https://learn.sparkfun.com/tutorials/how-to-use-a-multimeter/all) is straightforward and covers the essentials.  After that all you need to do is practise, ask questions, keep learning and...  stay alive.

So what would I add?


## Keeping safe

Until you have the education and experience to understand the relevant risks, stick with "small electricity".  My very simplistic definition is 12 volts or less, with a current supply of not more than three amps.

Why?  There won't be enough voltage to kill you, unless you're deliberately stupid with it.  There won't be enough power to explode anything or make high temperatures, unless you're trying to do that.

Based on what?  This is my view based on my experience.  It is greatly influenced by the collected wisdom of many who have experimented or had accidents, and kept records.

Is it that simple?  No!  Sometimes a lower voltage or current may cause electrocution.  Minute amounts of power can start a fire.  I'm aiming for some sensible guidlines.

Is the definition of "small electricity" an onerous burden on the experimenter?  No, there is plenty to make and learn within this garden.


### "It's volts that jolts, but it's mills that kills"

mills here meaning milliamps.

It's an old saying and a good place to start your risk assessment.  It is also a great over-simplification, because of [Ohm's law](https://en.wikipedia.org/wiki/Ohm%27s_law) and [capacitance](https://en.wikipedia.org/wiki/Human-body_model).

Keeping the voltage well below the [safety extra-low voltage limit](https://en.wikipedia.org/wiki/SELV) will, in most conditions, prevent dangerous current flowing in the experimenter's body.


### Stick to AA alkaline batteries and well-behaved power supplies

The modern rechargeable batteries (lithium ion, lithium polymer, NiMH) and older lead acid cells can provide very large currents.  The main danger here is rapid generation of heat by a short circuit.  Wires or components can rapidly become hot enough to burn things.

AA sized batteries have higher [internal resistance](https://en.wikipedia.org/wiki/Internal_resistance), so they can provide less power.  The zinc chloride type is cheaper and weaker than the alkaline manganese type.  For efficiency and the environment this isn't great, but for safety when you don't have a fuse in the circuit I think it's worth the cost.

Power supplies with built in [overload protection](https://en.wikipedia.org/wiki/Power_supply#Overload_protection), including those containing (tamed) rechargeable batteries, make good "small electricity" supplies.


### Stick to small electricity connectors

When you plan to work with low voltages, use only low voltage connectors.


### Don't eat it

An [important warning](https://www.poison.org/articles/button-batteries) about button or coin cell batteries.  They are more dangerous than they look, so younger children should not have access to them.


### Pointy bits

While I'm attempting to state the obvious: the probes on multimeters often have fairly sharp points.  Not as sharp as a (circle drawing) compass, but sharp enough to make a hole if you're careless.

This is so they can make good electrical contact with things.


### Direct current (DC) vs Alternating Current (AC)

Some articles will assume that AC refers to the domestic power line (mains) at 240, 230 or 110 volts; and that DC refers to lower voltages.  Sparkfun again,

> AC voltage (like what comes out of the wall) can be dangerous, so we rarely need to use the AC voltage setting (the V with a wavy line next to it). If you're messing with AC, we recommend you get a non-contact tester rather than use a digital multimeter.

I think this can be misleading, but perhaps it follows a misconception that many less technical people have, that "AC electricity is what comes out of the wall in my house".

Audio signals are a simple example of a low voltage alternating current.  You can use [software for a mobile phone](https://f-droid.org/packages/org.billthefarmer.siggen/) or other computer as a [signal generator](https://en.wikipedia.org/wiki/Function_generator) to make low voltage repeatable waveforms, and it is safe to connect this to your project - it won't hurt you, just be careful not to damage the source.

The inside of most [phone chargers and computer power supplies](https://en.wikipedia.org/wiki/Switched-mode_power_supply) contain high voltage DC and can be very dangerous.  Even after they have been unplugged for some time.  That is why they are difficult to open - don't do it!

I believe that to advertise AC as more dangerous than DC has [a grim familiarity](https://en.wikipedia.org/wiki/War_of_the_currents), but I don't expect to change the way 100 million people refer to their domestic power!

Some reasons to use DC power for beginner experiments are

* batteries produce DC
* DC is easier to understand than AC
* many devices, especially semiconductors, expect DC power

so the AC component is likely to be a signal you're doing something with.


## Understanding what is happening

The Sparkfun [introductin to Voltage, Current, Resistance, and Ohm's Law](https://learn.sparkfun.com/tutorials/voltage-current-resistance-and-ohms-law) may be helpful, and it uses the same water flow analogy.

### Voltage is "shove", measured in volts

I like a simple analogy: voltage is like a tank of water up in the air, with a hose leading from the bottom of the tank to the ground; but no water is flowing yet because the pipe is blocked at the bottom.

The higher you lift that tank, the more the water will push to get out of the bottom of the hose.  In water this is pressure, or force per area.  In electricity is is [voltage](https://en.wikipedia.org/wiki/Voltage), or Watts per Amp, or Joules per Coulomb.

As soon as it starts flowing, things become more complex.  Pipes use up some pressure in flowing water.  Conductors use up some voltage in flowing electricty.

You can't see a voltage without a volt meter, until there is enough for it to jump around the place.

There isn't (as far as I know..?) any "absolute zero volts" or "absolute voltage", it is always relative to something else.  We call the voltage between two points a potential difference.  Just like a distance or height.

We often measure voltage between an interesting point and a local "ground", which we consider to be zero volts.  This works just fine when there is only one ground and it doesn't have current flowing in it enough to generate a voltage.  After that it can get confusing.


### Current is "flow", measured in amperes

When the pipe from that tank is unblocked, water flows out of the tank.  You can see it coming out and you get wet feet.  This is a current of water.

In a garden hose it might be several litres per minute.  In a river it might be thousands of litres per second.

You can't see a current in a wire, until there is enough to make the wire hot.  Then the insulation on the wire may smoke or melt, or the wire may glow red hot.


### Electricity only flows in circuits

With water, you can let it flow out of the pipe onto the ground.

With electricity, if the current can't get back to where it started then it won't flow.  It always goes "out of the battery, round the circuit and **back to the battery**".

This is the simple way, with low frequencies and voltages.  It can get more complex, but the rules don't change - you have to apply them in more places.


### Kirchhoff's current and voltage laws

I think [Kirchhoff's circuit laws](https://en.wikipedia.org/wiki/Kirchhoff%27s_circuit_laws) are helpful in de-mystifying what happens in a circuit.

1. At any point where there are conductors meeting, all current coming in will go out.  Current doesn't just get lost somewhere.  "The algebraic sum of currents in a network of conductors meeting at a point is zero."
2. If you follow any loop around a circuit and add the potential differences as you go (remembering they may be negative), they will cancel to nothing.  "The directed sum of the potential differences (voltages) around any closed loop is zero."

For alternating current, this becomes an over-simplification.  DC is easier to understand.


### Your meter is not perfect

A perfect meter would measure voltage without taking any current from the circuit, and measure current without dropping any voltage.  The perfect meter cannot exist, and when you forget this it can be confusing.

Modern digital multimeters take very little current when measuring voltage (they have a [high impedance](https://en.wikipedia.org/wiki/High_impedance)), but if you switch to a moving coil (analog) meter you will notice that it draws enough current to affect the circuit you are probing.

A meter measuring milliamps is likely to have a noticeable potential difference across it, and this is subtracted from your circuit.


## Not damaging the equipment

In my priority list, looking after the equipment comes after not hurting yourself and learning something.  Sometimes a device has to loose its [magic smoke](https://en.wikipedia.org/wiki/Magic_smoke) so you can learn.

But do think about whether it's the £2 microcontroller or the £200 laptop which is going to lose its smoke.


### The multimeter

Multimeters are fairly robust against "small electricity".

You may blow the milliamp range fuse, it's quite easy to do with a careless short while probing.  Or by discharging a capacitor into it.  Keep some spare fuses and learn from the mistakes.

That 10 amp range will handle anything you have that is "small", with room to spare.  Be aware that many cheap meters have no fuse on the 10 amp port, so too much current will melt something.

What is worth considering is the current range.  When the probes are ready to measure current, they will offer a short circuit to whatever they connect across.  This is why [the Sparkfun tutorial](https://learn.sparkfun.com/tutorials/how-to-use-a-multimeter/all) recommends the meter should not be left in a current mode.


### Over-current conditions

When a too-large current flow, something is going to get too hot.  

If your power supply has a [fuse](https://en.wikipedia.org/wiki/Fuse_(electrical) or [current limiter](https://en.wikipedia.org/wiki/Foldback_(power_supply_design)), then it will be as safe as the limit on the current and speed of shutdown allow.

However if you are using a computer's USB port or a Microbit's 3 volt ring to power something else, it will be possible to draw more current than it can safely supply - for example with a [short circuit](https://en.wikipedia.org/wiki/Short_circuit).  The result is likely to be overheating and device failure.


### Over-voltage and reverse-voltage conditions

Most devices have a range of voltages they can tolerate, but some are more tolerant of over-voltage than others.

Small (toy size) motors in my experience will often tolerate more than twice their rated voltage for a short time.  They will get hot, and the sparks will shorten their working life, but they don't generally fail instantly.

On the other hand, most semiconductors (including that Microbit) are quite sensitive to even very short over-voltage conditions.  Transistors used to be known as "[the fastest fuse on three legs](https://duckduckgo.com/?q="fastest+fuse+on+three+legs")" and for the small ones this saying remains appropriate.  Often one careless connection is enough to destroy a device, because the size of the thing which is damaged by overheating can be really tiny.

Also for semiconductors, applying a negative voltage in the wrong place will often cause strong conduction in a diode (protective or [otherwise](https://en.wikipedia.org/wiki/Parasitic_structure)) inside the package.  As little as -0.3 volts may be enough to zap it.

One unfortunate combination here is the microcontroller or computer with both 5V and 3.3V supplies, such as the [Raspberry Pi](https://electronics.stackexchange.com/questions/397388/practical-limits-on-raspberry-pi-gpio-pin-voltages).  Connecting the 5V supply to a 3.3V-level pin is likely to damage it.


## Which meter?

For basic use I liked [the UT33D](https://www.rapidonline.com/uni-t-ut33d-digital-multimeter-palm-size-85-4080) before it was discontinued, but I would pay more for something to connect to the Big Electricity.
