
event_inherited();
if (myself.draw.active == false)
{
	if (global.user.func_curr != -1) // An item is equipped
	{
		switch (global.user.func_curr)
		{
			// Kart item
			case USER_FUNC.KART:			
				var _x = (myself.x + myself.xOffset);
				var _y = (myself.y + myself.yOffset);
				fn_draw_spr(spr_user_func_kart_0, dir_curr, _x, _y);
				fn_draw_spr_part(sprite_index, image_index, 0, 4, sprite_width, 17, _x, (_y - sprite_height + 5), image_blend, image_alpha, myself.xSc, myself.ySc);
				fn_draw_spr(spr_user_func_kart_1, dir_curr, _x, _y);
				break;
		}
	}
}
