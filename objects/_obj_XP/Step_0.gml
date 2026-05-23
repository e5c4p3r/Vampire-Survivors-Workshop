if (!active){
    if (point_distance(x, y, _obj_Player.x, _obj_Player.y) < 100){
        active = true;
    }
}
else{
    move_towards_point(_obj_Player.x, _obj_Player.y, 2);
}