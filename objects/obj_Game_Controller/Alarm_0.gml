with(obj_Enemy_Parent){
	if (kb_speed > 0){
		direction = kb_dir;
        speed = kb_speed;
		
		kb_speed -= 0.3;
	}
	else{
		direction = point_direction(x, y, obj_Player.x, obj_Player.y);
		speed = walkspeed;
	}
    
	if (x > obj_Player.x) image_xscale = 1;
	else image_xscale = -1;
	
	depth = -y;
	
	if (place_meeting(x, y, obj_Player)){
	    obj_Player.hp -= dps / (60 / other.alarmTime[0]);
		if (obj_Player.hp <= 0){
			game_restart();
		}
	}
}
obj_Player.depth = -obj_Player.y;
alarm[0] = alarmTime[0];