@LAZYGLOBAL off.

// OmniSat Boot v1.0.0
// Kevin Gisi
// http://youtube.com/gisikw

COPY ascent FROM 0.
COPY orbitsync from 0.
RUN ascent.

LOCK THROTTLE TO 1. WAIT 1. STAGE.
GLOBAL T0 IS TIME:SECONDS.
LOCK MET TO TIME:SECONDS-T0.

EXECUTE_ASCENT_PROFILE(90, LIST(
   // Altitude,  Angle,  Thrust
    0,            80,     1,
    2500,         80,     0.35,
    10000,        75,     0.35,
    15000,        70,     0.35,
    20000,        65,     0.35,
    25000,        60,     0.35,
    32000,        50,     0.35,
    45000,        35,     0.1
    )).

SWITCH TO 0.

GLOBAL LF IS "ascent.csv".
LOG "" to LF. DELETE LF.
LOG "MET,H,P,Q,R,S,SH,SU,DS,AO,AF,MA,TH" TO LF.

PRINT "Initial Partial Circularization ...".

// This is quite a lot of LOCK variables,
// it chews up 476 insructions per update.

GLOBAL ST IS FACING.
GLOBAL TH IS 0.

LOCK THROTTLE TO TH.
LOCK STEERING TO ST.

RUN orbitsync.

GLOBAL MTH IS MAXTHRUST - 1.
UNTIL FALSE {
   IF MAXTHRUST < MTH {
      LOCK THROTTLE TO 0.
      WAIT 1. LOCK STEERING TO FACING.
      WAIT 1. STAGE.
      WAIT 1. LOCK STEERING TO ST.
      WAIT 1. SET MTH TO MAXTHRUST - 1.
   }

   IF ORBITSYNC(96000,32000) <= 2
      BREAK.
   LOCK THROTTLE TO TH.

   WAIT 1/10.
}

LOCK THROTTLE TO 0. WAIT 1.

PRINT "Initial Partial Circularization ... done.".

TOGGLE LIGHTS.
