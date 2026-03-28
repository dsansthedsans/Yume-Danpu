
// Camera
if (fn_obj_exists(cam.tgt) == true)
{
	cam.x = (cam.tgt.myself.x + (cam.tgt.sprite_width / 2) - (cam.w / 2));
	cam.y = (cam.tgt.myself.y - (cam.tgt.sprite_height / 2) - (cam.h / 2));
	if (cam.lock.x != undefined)
		cam.x = cam.lock.x;
	if (cam.lock.y != undefined)
		cam.y = cam.lock.y;
	camera_set_view_pos(cam.id, cam.x, cam.y);
	camera_set_view_size(cam.id, cam.w, cam.h);
}
