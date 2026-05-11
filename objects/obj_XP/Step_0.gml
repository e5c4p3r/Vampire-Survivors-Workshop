if (!active){
    if (point_distance(x, y, obj_Player.x, obj_Player.y) < 100){
        active = true;
    }
}
else{
    move_towards_point(obj_Player.x, obj_Player.y, 2);
}