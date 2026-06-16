
// Camera
if (fn_object_exists(cam.target) == true)
{
	cam.x = ((cam.lock.x == undefined) ? (cam.target.myself.x + (cam.target.sprite_width / 2) - (cam.width / 2)) : cam.lock.x);
	cam.y = ((cam.lock.y == undefined) ? (cam.target.myself.y - (cam.target.sprite_height / 2) - (cam.height / 2)) : cam.lock.y);
	camera_set_view_pos(cam.id, cam.x, cam.y);
	camera_set_view_size(cam.id, cam.width, cam.height);
}
