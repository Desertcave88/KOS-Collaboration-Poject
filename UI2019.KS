set B to 0.
set logline to 30.
set backlogqueue to queue().
set twidth to 60.
set theight to 40.
set terminal:width to twidth.
set terminal:height to theight.
clearScreen.
run Log.ks.

function Backlog
	{
		local parameter szinput.
		if logline = 38
			{
				backlogqueue:push(szinput).
				from {local y to 30.} until y = 38 step {set y to y + 1.}
					do
						{
							print "                                                       " at (1,y).
						}
				backlogqueue:pop().
				local tempqueue to queue().
				set tempqueue to backlogqueue:copy().
				from {local counter to 30.} until counter = 38 step {set counter to counter + 1.}
					do
						{
							print tempqueue:pop() at (1,counter).
						}
			}
		else
			{
				print SZINPUT at (1,logline).
				backlogqueue:push(szinput).
				set logline to logline + 1.
			}	
		return.
	}

function clearlog
	{
		from {local y to 30.} until y = 37 step {set y to y + 1.}
			do
				{
					print "                                                       " at (1,y).
				}
		set logline to 30.
		backlogqueue.clear().
	}


from {local y to 2.} until y = 38 step {set y to y +1.}
	do
		{
			print "|                                                          |" at (0 ,y).
		}
print "/////////////////////////// A.L.A \\\\\\\\\\\\\\\\\\\\\\\\\\" at (0,0).
print "============================================================" at (0,1).
print "Altitude:" at (1,2).
print "Apoapsis:" at (1,3).
print "Periapsis:" at (1,4).
print "Velocity:" at (1,5).
print "Pitch:" at (1,6).
print "A.O.A:" at (1,7).
print "Drag:" at (1,8).
print "Mass:" at (1,9).
print "Stage dV:" at (1,10).
print "==========================================================" at (1,29).
print "============================================================" at (0,38).


when b <> 1 then
	{
		print round(ship:altitude,2) at (15,2).
		print round(ship:apoapsis,2) at (15,3).
		print round(ship:periapsis,2) at (15,4).
		print round(ship:velocity:orbit:mag,2) at (15,5).
		print round(pitch_for(ship),2) at (15,6).
		print round(aoa(),2) at (15,7).
		print round(ship:q,2) at (15,8).
		print round(ship:mass,2) at (15,9).
		print round(deltaV(),2) at (15,10).
		wait .5.
		preserve.
	}

