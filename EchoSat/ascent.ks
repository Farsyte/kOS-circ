@LAZYGLOBAL off.

// Execute Ascent Profile v1.0.0
// Kevin Gisi
// http://youtube.com/gisikw
//
// ... with a few edits by Farsyte.

FUNCTION EXECUTE_ASCENT_STEP {
   PARAMETER direction, minAlt, newAngle, newThrust.
   LOCAL thrThresh IS MAXTHRUST-1.
   UNTIL FALSE {
      IF MAXTHRUST < thrThresh {
         LOCAL currentThrottle IS THROTTLE.
         LOCK THROTTLE TO 0.
         WAIT 1. STAGE. WAIT 1.
         LOCK THROTTLE TO currentThrottle.
         SET thrThresh TO MAXTHRUST-1.
      }
      IF ALTITUDE > minAlt {
         LOCK STEERING TO HEADING(direction, newAngle).
         LOCK THROTTLE TO newThrust.
         BREAK.
      }
      WAIT 0.1.
   }
}

FUNCTION EXECUTE_ASCENT_PROFILE {
   PARAMETER direction, profile.
   FROM {
      LOCAL step IS 3.
   } UNTIL (step > profile:length) STEP {
      SET step TO step + 3.
   } DO {
      EXECUTE_ASCENT_STEP(
         direction,
         profile[step-3],
         profile[step-2],
         profile[step-1]).
   }
}
