# Experiments in Precision Circularization

The goal of this is project is to compare several methods for
circularization of orbits in Kerbal Space Program, using scripts
written for the "kOS" (Kerbal Operating System) mod.

## Test Configuration

### Installing Kerbal Space Program

- Kerbal Space Program, version 1.0.5
- kOS version 0.18.2
- ModuleManager (installed via dependency)
- RemoteTech
- Smart Parts

I currently lack a mechanism to have my vehicles stream telemetry to
the ground, so these tests will run with KOS integrating of RT
disabled so the scripts can log data directly to the archive.

### Preparation

I was inspired to do this by the "Kerbal Space Programming" series of
videos on YouTube by CheersKevin (Cheers, Kevin!) so I am going to
establish my game saves state to where it was when I started to think
about this: during the launch of EchoSat 1.

So pause this for a bit while I rewind to the beginning and bring my
new installation up to the desired save point -- with a few little
twists to make it a better jump-off point.

### Test Code Layout

To start, BOOT.KS copies SEQUENCE.KS from the archive and runs it.

Before and after that, it nulls out controls -- before, cutting the
throttle and holding the current attitude; after, cutting the throttle
and setting the vehicle into a polar attitude.

Additionally, default values for simple telemetry capture are set up
before running SEQUENCE.KS and the trigger threshold is cleared after
it runs -- it is up to SEQUENCE.KS to load and run TELEMETRY.KS, or
not, as appropriate.

### Launching EchoSat

I wanted to have a test article, in a save game, on a trajectory that
lends itself to evaluation of circularization mechanisms: ascending
along an orbit with an apoapsis well outside the atmosphere, and a
periapsis within it -- this condition is where you would find a
vehicle after it has jettisoned an ascent stage, to burn it up rather
than leave it orbiting.

This actually required me to extend my script, to allow explicit
selection of the target periapse and apoapse. I've tucked the actual
scripts into the EchoSat subdirectory -- while this uses an advanced
form of my circularization method, it's not the focus of this project.

