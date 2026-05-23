xp += 1;
if (xp >= next_xp){
	xp = 0;
	level += 1;
	next_xp += 1+level;
	
	hp = max_hp;
	alarmtime[0] *= 0.9;
	alarmtime[1] *= 0.9;
}

instance_destroy(other.id)