// AOA = ANGLE OF ATTACK..

FUNCTION AOA
	{
		DECLARE LOCAL FPITCH TO 90 - vang(up:vector,ship:facing:forevector).
		DECLARE LOCAL VPITCH TO 90 - vang(up:vector,ship:velocity:surface).
		RETURN FPITCH - VPITCH.
	}

//Eng thrust control.
FUNCTION THRUSTLIMMITERCONTROL
	{
		parameter TEMPTHRUSTV.
		parameter TEMPENGV.

		FOR eng IN TEMPENGV 
			{
				SET eng:THRUSTLIMIT TO TEMPTHRUSTV.
			}
	}
//SHIP HEADING...
FUNCTION EAST_FOR 
	{
		parameter ves.

		return vcrs(ves:up:vector, ves:north:vector).
	}

FUNCTION COMPASS_FOR 
	{
		parameter ves.
	
		local pointing is ves:facing:forevector.
		local east is east_for(ves).

		local trig_x is vdot(ves:north:vector, pointing).
		local trig_y is vdot(east, pointing).

		local result is arctan2(trig_y, trig_x).

		if result < 0 
			{ 
				return 360 + result.
			} 
		else 
			{
				return result.
			}
	}

FUNCTION PITCH_FOR
	{
		parameter ves.

		return 90 - vang(ves:up:vector, ves:facing:forevector).
	}

FUNCTION ROLL_FOR
	{
		parameter ves.
  
		if vang(ship:facing:vector,ship:up:vector) < 0.2 
			{
				return 0.
			} 
		else 
			{
				local raw is vang(vxcl(ship:facing:vector,ship:up:vector), ves:facing:starvector).
				
				if vang(ves:up:vector, ves:facing:topvector) > 90 
					{
						if raw > 90 
							{
								return 270 - raw.
							} 
						else 
							{
								return -90 - raw.
							}
					} 
				else 
					{
						return raw - 90.
					}
			} 
	}.



function deltaV
	{
		set shipresources to stage:resources.
		list engines in shipeng.

		for res in shipresources
			{
				if res:name = "solidfuel"
					{
						set stagedrymass to ship:mass - (res:amount * .0075).
						break.
					}
				if res:name = "liquidfuel" and ship:solidfuel = 0
					{
						set stagedrymass to ship:mass - (res:amount * .005) * (20/9).
						break.
					}
			}
		for eng in shipeng
					{
						if eng:ignition and stage:number = eng:stage
						{
							return 9.81 * (eng:isp *(ln(ship:mass / stagedrymass))).
						}
					}
	}
