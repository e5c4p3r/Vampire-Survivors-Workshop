var dir = random(360);

var xx = _obj_Player.x + lengthdir_x(spawn_radius, dir);
var yy = _obj_Player.y + lengthdir_y(spawn_radius, dir);

if (irandom_range(1, 2) == 1) instance_create_layer(xx, yy, "Instances", _obj_Enemy_1);
else instance_create_layer(xx, yy, "Instances", _obj_Enemy_2);

alarm[1] = alarmTime[1];