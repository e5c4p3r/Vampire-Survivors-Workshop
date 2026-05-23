var _list = ds_list_create();
var _num = collision_rectangle_list(bbox_left, bbox_top, bbox_right, bbox_bottom, _obj_Enemy_Parent, false, true, _list, false);
if _num > 0
{
    for (var i = 0; i < _num; ++i;)
    {
		var _target = _list[| i];
		if (!array_contains(hit_list, _target)) {
			array_push(hit_list, _target);
			
			_target.flash_timer = 5;
			
			_target.kb_dir = point_direction(_obj_Player.x, _obj_Player.y, _target.x, _target.y);
			_target.kb_speed = 1;
			
		    _target.hp -= dmg;
			if (_list[| i].hp <= 0) instance_destroy(_list[| i]);
		}
    }
}
ds_list_destroy(_list);