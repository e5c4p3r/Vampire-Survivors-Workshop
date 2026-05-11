with(obj_Enemy_Parent){
	direction = point_direction(x, y, obj_Player.x, obj_Player.y);
	speed = walkspeed;
    
	if (x > obj_Player.x) image_xscale = 1;
	else image_xscale = -1;
	
	depth = -y;
}
obj_Player.depth = -obj_Player.y;
alarm[0] = alarmTime;