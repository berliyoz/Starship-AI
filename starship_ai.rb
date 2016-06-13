BEGIN {puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n                     ---{ STARSHIP AI }---\n"}

=begin

Version 0.9

===== TODO =====
ADD
1. Jokes - player can ask for jokes
2. Make "event" as a unit than can be oprated or upgraded
3. Make START more modolar - and add command to it
4. SCANER SCREEN -> scanner apper on STATUS.
5. STATIONS (event - 8) for random goodies.
7. POINTS?
8. MONEY \ ENERGY?
9. FUEL?
10. out manover the next event. Maybe kill a ROBOT in the process.
11. Maybe build ROBOTS insted of fixing them. new ROBOT cost more.
12. Visual BARS. 
13. ">>" next 2 HOURS .......

FIX 
1. orgonize code better.
=end

# ----------------------------- HASHES & ARRAYS --------------------
$arr_event = []
$arr_event_counter = 0

$status = {
	:air => 40,
	:shield => 15,
	:robots => 3,
	:scanner_sight => 1,
	:hours => 0,
	:rescue => 10
}

$maintenance = {
	:beacon => 0,
	:oxy => 0,
	:shield_keep => 0,
	:scan => 0
	
}

$fix = {
	:robot_a => 0,
	:robot_b => 0,
	:gps => 0,
	:scanner => 0,
	:scanner_enhance => 0
}

# Maybe delete this one
$event = {
	:air_loss => 0,
	:asteroid => 0,
	:rescue_late => 0	
}

# ----------------------------- BASE -----------------------------
def help
	puts """
	
	================================================================
	
	         ---{ INFO SHEET }---           --{ ver. 0.91 ]--
	
	>>> MAIN COMMANDS 
	
	q    - quit the game
	next - pass one hour, and suffer the effects.
	scan - show future events number code (requires working SCANNER).
	
	
	>>> IN \ OUT robot from or to a unit.
	
	beacon \ beacon out
	oxy
	shield
	robot a (r a)
	robot b (r b)
	gps
	scanner
	enhance scanner (es) 

	
	=================================================================
	"""
end

def events_code
	puts """
			--- SCANNER LOG CODES ---
				
		0  - Clear Sky
		1  - Robot A will breakdown.
		2  - Robot B will breakdown.
		3  - GPS will stop working.
		4  - Air Loss will happen.
		5  - Asteroid will hit.
		6  - Rescue team will take more time to arrive.
		7  - SCANNER UNIT will breakdown.
		8  - SCANNER UNIT sight reduce.
		9  - ....
		10 - ....
		11 - ....
		12 - ....
		13 - ....
		14 - ....
		
		"""
		
end

def main
	event_order
	event_gen_quiet_hour
	#T print $arr_event - CHECK
	#start
	
	while true
		air_check
		shield_check
		input = prompt
		puts input
	
		case input
		# ---- MAIN ----
		when "quit", "q"
			quit
		when "help", "?"
			help
		when "next", ">", "n"
			next_turn
		when "scan", "s"
			event_print
		when "code", "c", "scanner codes"
			events_code
		when "change course", "cc"
			change_course
				
		# ---- IN\OUT ----
		when "beacon", "b"
			in_beacon
		when "beacon out", "b out"
			out_beacon
		when "oxy"
			in_oxy
		when "oxy out"
			out_oxy
		when "shield", "sh"
			in_shield
		when "shield out", "sh out"
			out_shield
		when "robot a", "ra"
			in_robot_a
		when "robot a out", "ra out"
			out_ robot_a
		when "robot b", "rb"
			in_robot_b
		when "robot b out", "rb out"
			out_robot_b
		when "gps"
			in_gps
		when "gps out"
			out_gps
		when "scanner", "sc"
			in_scanner
		when "scanner out"
			out_scanner
		when "enhance scan", "es"
			in_scanner_enhance
		when "enhance scan out", "es out"
			out_scanner_enhance
		
		# ---- MISC ----
		when "test"
			story_line
		when "events"
			print $arr_event
		else
			type_error
		end
	end
end

def prompt
	status
	puts " "
	puts "What next?"
	print "> "
	input = $stdin.gets.chomp.downcase
	puts """
	
	==================================================================
	
	"""
	return input
	#"""
	#print ">>>>"
	#return input
end

def type_error
	puts ""
	puts "		>>> Please enter command again."
	puts " "
end

def status
	puts """
	--------- STATUS -------------
	Air: ______________________#{$stt[:air]}
	Shield: ___________________#{$stt[:shield]}
	Free Robots: ______________#{$stt[:robots]}
	Scanner Sight: ____________#{$stt[:scanner_sight]}
	
	Hours since last reboot: __#{$stt[:hours]}
	Hours to Rescue:___________#{$stt[:rescue]}
	------------------------------
	
	    ROBOTS in 
	-- MAINTENANCE --
	Beacon:_____#{$main[:beacon]}
	OXY:________#{$main[:oxy]}
	Shield:_____#{$main[:shield_keep]}
	------------------
	"""
	
	#status_robot_a
	status_fix
	
	puts """
	For INFO SHEET write \"?\" or \"help\" and press ENTER
	"""
	
	
	
	
	
end

def start
	puts """
		
	
	>> please write in \"fix\" and press ENTER
	"""
	
	print"> "
	input = gets.chomp
	
	puts """
		...un...
	
	
	>> please write in \"fix\" and press ENTER
	"""
	
	print "> "
	input = gets.chomp
	
	puts """
		 ...fun...
	
	
	>> please write in \"fix a bit more\" and press ENTER
	"""
	
	print "> "
	input = gets.chomp
	
	puts """
	Close enough!
	Very Good!
		
	
	>> press ENTER to REBOOT the ship computer.
	"""
	
	input = gets.chomp
	
	puts """
	==============================================================
	
	                                             28/12/2015
	
	Good moRning!
	
		The AG-60001 model of ship, was unfortunately went 
		through a most serious mal..fun..ction. To our great luck
		the 47X-AI unit is functioning. Please help it it keep
		all of the hibernate crew members alive.
		thank it.
		And have it nice day :)
		
	* Info sheet: Type \"?\" or \"help\"
		
	==============================================================
	"""
end


#--------------------------------- STATUS FIX ----------------------
def status_fix
	puts "	---- NEED FIX ----"
	status_robot_a
	status_robot_b
	status_gps
	status_scanner
	status_scanner_enhance
	puts "	------------------"
end

def status_robot_a
	if $fix[:robot_a] <= 1
		puts "	Robot A:_______#{$fix[:robot_a]}"
	end
end

def status_robot_b
	if $fix[:robot_b] <= 1
		puts "	Robot B:_______#{$fix[:robot_b]}"
	end
end

def status_gps
	if $fix[:gps] <= 1
		puts "	GPS:___________#{$fix[:gps]}"
	end
end

def status_scanner
	if $fix[:scanner] <= 1
		puts "	Scanner:_______#{$fix[:scanner]}"
	end
end

def status_scanner_enhance
	if $fix[:scanner] == 10 && $stt[:scanner_sight] != 6
		puts "	Enhance Scan:__#{$fix[:scanner_enhance]}"
	end
end

#============================== NEXT TURN ==========================
def next_turn
	#air_loss
	#asteroid
	#rescue_late
	air_leak
	
	hours_count
	air_count
	shield_count
	rescue_count
	
	robot_a_fix
	robot_b_fix
	gps_fix
	scanner_fix
	scanner_enhance_fix
	
	#robot_a_broke
	#robot_b_broke
	#gps_broke
	
	event_gen
	
	rescue_check
end

# ---------------------------- NEXT TURN: stt & main ---------------
def air_leak
	$stt[:air] -= 10
end

def air_count
	if $main[:oxy] == 1
		$stt[:air] += 20
	end
end

def shield_count
	if $main[:shield_keep] == 1
		$stt[:shield] += 7
	end
end

def hours_count
	$stt[:hours] += 1
end

def rescue_count
	if $main[:beacon] == 1
		$stt[:rescue] -= 1
	end
end

# ---------------------------- NEXT TURN: fix -----------------------

def robot_a_fix
	if $fix[:robot_a] == 1
		$fix[:robot_a] = 10
		$stt[:robots] += 2
		puts "		>>> Robot A is now working."
		puts " "
	end
end

def robot_b_fix
	if $fix[:robot_b] == 1
		$fix[:robot_b] = 10
		$stt[:robots] += 2
		puts "		>>> Robot B is now working."
		puts " "
	end
end

def gps_fix
	if $fix[:gps] == 1
		$fix[:gps] = 10
		$stt[:robots] += 1
		puts " "
		puts "		>>> GPS unit is now working."
		puts " "
	end
end

def scanner_fix
	if $fix[:scanner] == 1
		$fix[:scanner] = 10
		$stt[:robots] += 1
		puts "		>>> SCANNER unit is operational."
		puts " "
	end
end

def scanner_enhance_fix
	if $stt[:scanner_sight] <= 6 && $fix[:scanner] == 10 && $fix[:scanner_enhance] == 1
		$stt[:scanner_sight] += 1
		$stt[:robots] += 1
		$fix[:scanner_enhance] = 0
		puts "		>>> SCANNER ability enhanced."
		puts " "
	end
end

# ------------------------------ END CONDITIONS ----------------
def quit
	puts """
	                           --++ QUIT ++--
	"""
	exit
end

def death_shield
	puts """
	The ship took to many hits.
	It is time to DIE... \a
	"""
	exit(0)
end

def death_air
	puts """
	All the people died of SUFFOCATION.
	No reason to wait for rescue any more... \a
	"""
	exit(0)
end

def rescued
	puts """
	=======================================================================================
	
	
	Great! Super Great!
	
	It wasn't easy, not at all!
	But you have made it!
	Just now, we are being towed to the main base for some fixing.
	A few more hours and every thing will be behind us.
	\a
	
	Thank you!
	
	>> See you next time on: \"The Amazing Adventures of 49X-AI at the Edge of Space!!\"
	
	
	========================================================================================
	"""
	exit(0)
end


# ----------------------------- CHECKS -----------------------
def air_check
	if $stt[:air] <= 0 then death_air end
	if $stt[:air] >= 100 then $stt[:air] = 100 end
		
end

def shield_check
	if $stt[:shield] <= 0 then death_shield end
	if $stt[:shield] >= 100 then $stt[:sheild] = 100 end
end

def rescue_check
	if $stt[:rescue] == 0 then rescued end
end

def turn_check
	
	
end


# ---------------------------- IN and OUT ---------------------------

def robot_in(system ,unit)
	if $stt[:robots] == 0
		puts """
		Please free a ROBOT and then send it to the #{system[unit[0]]} unit.
		"""
	elsif system[unit[0]] == 0
		system[unit[0]] = 1
		$stt[:robots] -= 1
		puts """
		A ROBOT was moved to the #{unit[0].upcase} unit.
		"""
	else
		puts """
		There is already a ROBOT in the #{unit[0].upcase} unit.
		"""
	end
end

def robot_out(system, unit)
	if system[unit[0]] == 1
		$stt[:robots] += 1
		system[unit[0]] = 0
		puts """
		A ROBOT was removed from the #{unit[0].upcase} unit.
		"""
	else
		puts """
		No ROBOT is working in the #{unit[0].upcase} unit.
		"""
	end
end


# ---------------------------- MAINTENANCE IN\OUT -------------------
def in_beacon
	if $fix[:gps] == 10
		robot_in($main,$main.assoc(:beacon))
	else
		puts "	Cannot operate the BEACON because the GPS unit is out of order."
	end
end

def out_beacon
	robot_out($main,$main.assoc(:beacon))
end

def in_oxy
	robot_in($main,$main.assoc(:oxy))
end

def out_oxy
	robot_out($main,$main.assoc(:oxy))
end

def in_shield
	robot_in($main,$main.assoc(:shield_keep))
end

def out_shield
	robot_out($main,$main.assoc(:shield_keep))
end
# --------------------------- FIX IN\OUT -------------------------
def in_robot_a
	robot_in($fix,$fix.assoc(:robot_a))
	
end

def out_robot_a
	robot_out($fix,$fix.assoc(:robot_a))
end

def in_robot_b
	robot_in($fix,$fix.assoc(:robot_b))
end

def out_robot_b
	robot_out($fix,$fix.assoc(:robot_b))
end

def in_gps
	robot_in($fix,$fix.assoc(:gps))
end

def out_gps
	robot_out($fix,$fix.assoc(:gps))
end

def in_scanner
	robot_in($fix,$fix.assoc(:scanner))
end

def out_scanner
	robot_out($fix,$fix.assoc(:scanner))
end

def in_scanner_enhance
	robot_in($fix,$fix.assoc(:scanner_enhance))
end

def out_scanner_enhance
	robot_out($fix,$fix.assoc(:scanner_enhance))
end

# ------------------------------- EVENT -------------------------------
def event_order
	until $arr_event_counter == 20
	$arr_event.push(random)
	$arr_event_counter += 1
	end
end

def event_print
	if $fix[:scanner] == 10
		puts " "
		puts "              --{ EVENT ORDER }-- "
		puts " "
		print $arr_event.drop($arr_event.length - $stt[:scanner_sight])
		puts " "
	else
		puts "		>>> SCANNER UNIT is out of order."
	end
end

def event_gen
	$event_num = $arr_event.pop.to_s
	
	case $event_num
	when "1"
		robot_a_broke
		
	when "2"
		robot_b_broke
		
	when "3"
		gps_broke
		
	when "4"
		air_loss
	
	when "5"
		asteroid
	
	when "6"
		rescue_late
	
	when "7"
		scanner_broke
	
	when "8"
		scanner_reduce_sight
	
	else
		event_nothing
	end
end

def event_gen_quiet_hour
	5.times do |i|
	$arr_event.push(0)
	end
end

def robot_a_broke
	$fix[:robot_a] = 0
	robot_broke
	puts " "
	puts "		>>> There had being a ROBOT malfunctioning!!!"
	puts " "
end

def robot_b_broke
	$fix[:robot_b] = 0
	robot_broke
	puts " "
	puts "		>>> There had being a ROBOT malfunctioning!!!"
	puts " "
end

def robot_broke
	out_beacon
	out_oxy
	out_shield
	

	$stt[:robots] -= 1
end

def gps_broke
	unless $fix[:gps] == 0
		out_beacon
		$fix[:gps] = 0
		puts "		>>> GPS working failed!!!"
		puts " "
	else
		event_nothing
	end
end

def scanner_broke
	$fix[:scanner] = 0
	puts "		>>> SCANNER UNIT broke down!!!"
	puts " "
end

def air_loss
	#if $stt[:hours] >= 7 && $stt[:hours] == fix_gen && $event[:air_loss] <= 2
		$stt[:air] -= 30
		$event[:air_loss] += 1
		puts " "
		puts "		>>> An AIR loss had had had happened!!!"
		puts " "
	#end
end

def asteroid
	$stt[:shield] -= 20
	$event[:asteroid] += 1
	puts "		>>> An Asteroid broke through the ships's shield."
end

def rescue_late
	$stt[:rescue] += 2
	$event[:rescue_late] += 1
	puts " "
	puts "		>>> The RESCUE team will take more time to arrive."
	puts " "
end

def scanner_reduce_sight
	unless $stt[:scanner_sight] == 0
		$stt[:scanner_sight] -= 1
		puts "		>>> SCANNER SIGHT reduced!!!"
	else
		event_nothing
	end
end

def event_nothing
	puts "		>>> ANOTHER QUIET HOUR."
	puts " "
end

# ---------------------- STARSHIP MOVMENT ------------------------

def change_course
	story_line
	puts """
		??? While CHANGEing COURSE you will lose:
		??? 85 - Air
		??? 65 - Shield
		???
		??? If you would like to CHANGE COURSE enter \"Y\".
		??? Anything else will cancel the CHANGE COURSE.
	"""
	story_line
	
	print "> "
	input = gets.chomp.downcase
	
	case input
	when "y"
		$stt[:air] -= 85
		$stt[:shield] -= 65
		
		$arr_event = []
		$arr_event_counter = 0
		event_order
		
		puts "		>>> COURSE CHANGED."
	else
		puts "		>>> CHANGE COURSE aborted."
	end
end

# ----------------------- GENRATOR -------------------------------

#def fix_gen
#	rand($stt[:hours]...($stt[:hours] + $stt[:rescue]) + 1) if $stt[:hours] >= 3
#end

def random
	num = rand(0..15)
	num.to_i
end

# --------------------- GRAPHIX ---------------------------------

def story_line
	puts """
	\\  /\\  /\\  /\\  /\\  /\\  /\\  /\\  /\\  /\\  /\\  /\\  /\\  /\\  /\\  /\\  /\\
	 \\/  \\/  \\/  \\/  \\/  \\/  \\/  \\/  \\/  \\/  \\/  \\/  \\/  \\/  \\/  \\/  \\
	 
	"""
end

# ----------------------- ALIAS ---------------------------------

alias $stt $status
alias $main $maintenance

main

END {puts "\n--- { GAME OVER }---\n"}