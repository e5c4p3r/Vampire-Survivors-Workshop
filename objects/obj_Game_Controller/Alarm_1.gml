var dir = random(360);

var xx = obj_Player.x + lengthdir_x(spawn_radius, dir);
var yy = obj_Player.y + lengthdir_y(spawn_radius, dir);

instance_create_layer(xx, yy, "Instances", obj_Enemy_1);
instance_create_layer(xx, yy, "Instances", obj_Enemy_2);

alarm[1] = alarmTime[1];