function fn_actor_walk_endX_get(_object, _x, _facing_index, _walk_distance)
{
	if (fn_obj_exists(_object) == true)
		return (_x + ((_walk_distance * _object.facing[_facing_index].sign) * (_object.facing[_facing_index].axis == _object.FACING_AXIS_HORIZ)));
	else
		return 0;
}
function fn_actor_walk_endY_get(_object, _y, _facing_index, _walk_distance)
{
	if (fn_obj_exists(_object) == true)
		return (_y + ((_walk_distance * _object.facing[_facing_index].sign) * (_object.facing[_facing_index].axis == _object.FACING_AXIS_VERT)));
	else
		return 0;
}