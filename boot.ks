@LAZYGLOBAL off.

LOCK THROTTLE TO 0.
LOCK STEERING TO FACING.
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.

CLEARSCREEN.

GLOBAL telem_at IS -1.
GLOBAL telem_fn IS "telemetry.csv".
GLOBAL telem_hz IS 10.

COPY sequence FROM 0.
RUN sequence.

SET telem_at TO -1.

LOCK THROTTLE TO 0.
LOCK STEERING TO HEADING(0,0).
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.

print "core shutdown in ten seconds.".
WAIT 10.
SHUTDOWN.
