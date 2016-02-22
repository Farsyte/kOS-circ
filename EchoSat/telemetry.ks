@LAZYGLOBAL off.

DELETE telemetry.

GLOBAL telem_t0 IS TIME:SECONDS.
LOCK telem_met to time:seconds - telem_t0.
GLOBAL telem_hz IS 20.
GLOBAL telem_dt IS 1/telem_hz.
SET telem_at TO 1.

switch to 0.

LOG "" TO telem_fn. DELETE telem_fn.
LOG "met,periapsis,altitude,apoapsis,verticalspeed"
      TO telem_fn.

WHEN telem_met >= telem_at THEN IF telem_at > 0 {
   LOG telem_met
      +","+periapsis
      +","+altitude
      +","+apoapsis
      +","+verticalspeed
      TO telem_fn.
   SET telem_at TO ROUND(telem_met+telem_dt,2).
   PRESERVE.
}
