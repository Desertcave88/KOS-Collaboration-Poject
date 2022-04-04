switch to 0.
run LIB.KS.
clearscreen.

set shiplog to "Shiplogs of " + ship:shipname.

if exists("0:/" + shiplog) <> true
	{	
		createDir("0:/" +shipLOG).
	}

cd ("0:/" + shiplog).

function findlognumber
	{
		local lnumber to 1.
		list files in loglist.
		for files in loglist
			{
				set lnumber to lnumber + 1.
			}.
		return lnumber.
	}

set shiplog to "Launch log number " + findlognumber().


set onesecondslater to time:seconds + 1.
list engines in allengines.
set tthrust to 0.

log time:calendar + " Altitude " + "Apoapsis " + " Periapsis" + " Velocity" + " Pitch" + " AOA" + " Dynamic Drag" + " Mass" + " Thrust" + " DeltaV" to shiplog.
when time:seconds >= oneSecondsLater then 
	{	
		set tthrust to 0.
		for eng in allengines
			{
				set tthrust TO tthrust + eng:thrust.
			}.

		set onesecondslater to time:seconds + 1.
		log TIME:CLOCK + " " + round(ship:altitude,2) + " " + round(ship:apoapsis,2) + " " + round(ship:periapsis,2) + " " + round(ship:velocity:orbit:mag,2) + " " + round(pitch_for(ship),2) + " " + round(aoa(),2) + " " + round(ship:Q,2) + " " + round(ship:mass,2) + " " + round(tthrust,2) + " " + round(deltaV(),2) TO shiplog.
		preserve.
	}
	
wait until ship:isdead = true.
