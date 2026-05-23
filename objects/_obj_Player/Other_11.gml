var axe = instance_create_layer(x, y, "Instances", _obj_Weapon_Axe);

axe.direction = random_range(45, 135);
axe.speed = 4;
axe.gravity = 0.1;
axe.friction = 0.01;