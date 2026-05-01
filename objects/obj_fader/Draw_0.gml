
// Transition of type Fade
if (type.fade.active == true)
{
	// Draws iris
	if (type.fade.iris.active == true && stage < 1)
	{
		var _iris = type.fade.iris;
		if (surface_exists(_iris.surface) == false)
			_iris.surface = surface_create(640, 480);
		surface_set_target(_iris.surface);
		draw_clear_alpha(_iris.color, _iris.alpha);
		gpu_set_blendmode(bm_subtract);
		fn_draw_circle((_iris.x + _iris.xOffset), (_iris.y + _iris.yOffset), round(_iris.radius), _iris.precision);
		gpu_set_blendmode(bm_normal);
		surface_reset_target();
		draw_surface_ext(_iris.surface, 0, 0, 1, 1, 0, c_white, 1);
		surface_free(_iris.surface);
	}
}
