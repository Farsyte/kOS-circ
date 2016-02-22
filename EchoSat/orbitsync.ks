// Before calling this function:
//
// SWITCH TO 0.
//
// GLOBAL LF IS "ascent.csv".
// LOG "" to LF. DELETE LF.
// LOG "MET,H,P,Q,R,S,SH,SU,DS,AO,AF,MA,TH" TO LF.
//
// GLOBAL ST IS FACING.
// GLOBAL TH IS 0.
// LOCK THROTTLE TO TH.
// LOCK STEERING TO ST.
//
// Then call ORBITSYNC(apoapsis,periapsis)
// repeatedly in the control loop.

FUNCTION ORBITSYNC {
   PARAMETER HQ, HP.

   LOCAL R0 IS BODY:RADIUS.
   LOCAL MU IS BODY:MU.

   LOCAL KT IS 1/5.                             // controller gain

   LOCAL Q IS R0+HQ.                            // radius at apoapsis
   LOCAL P IS R0+HP.                            // radius at periapsis
   LOCAL A IS (P+Q)/2.                          // semi-major axis
   LOCAL SQ IS SQRT(MU*(2/Q-1/A)).              // speed at apoapsis
   LOCAL ASR IS SQ*Q.                           // area sweep rate, m^2/sec

   LOCAL H IS ALTITUDE.
   LOCAL VO IS VELOCITY:ORBIT.
   LOCAL VU IS UP:VECTOR.

   LOCAL R IS R0 + H.                           // current radius.
   LOCAL S IS SQRT(MU*(2/R - 1/A)).             // target speed
   LOCAL SH IS ASR/R.                           // target HORIZONTAL speed
   LOCAL SU IS SQRT(MAX(0,S^2 - SH^2)).         // target VERTICAL speed
   LOCAL VH IS VXCL(VU,VO):NORMALIZED.          // horizontal velocity direction
   LOCAL V IS VH*SH + VU*SU.                    // total target velocity
   LOCAL DV IS V - VO.                          // velocity error
   LOCAL DS IS DV:MAG.                          // size of correction
   LOCAL AO IS VANG(FACING:VECTOR,DV).          // angle offset (facing vs burn)
   LOCAL AF IS 1 - AO/20.                       // thrust discount due to angle error
   LOCAL MA IS MAX(1,MAXTHRUST)/MASS.           // acceleration at max throttle

   SET ST TO LOOKDIRUP(DV,FACING:TOPVECTOR).    // steer, minimizing roll
   SET TH TO MIN(1,MAX(0,AF*KT*DS/MA)).         // desired throttle

   LOG ROUND(MET,2)
      +","+ROUND(H)
      +","+ROUND(PERIAPSIS)
      +","+ROUND(APOAPSIS)
      +","+ROUND(R)
      +","+ROUND(S)
      +","+ROUND(SH)
      +","+ROUND(SU)
      +","+ROUND(DS,2)
      +","+ROUND(AO,1)
      +","+ROUND(AF,2)
      +","+ROUND(MA)
      +","+ROUND(TH*100)
      TO LF.

   RETURN DS.
}
