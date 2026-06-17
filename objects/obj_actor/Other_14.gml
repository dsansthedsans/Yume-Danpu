/// @descr Draw End Event
switch (object_index)
{
	// Vehicles
	case obj_actor_user_func_kart:
	{
		if (passengers[0].id != undefined)
		{
			var _passenger_sprite = passengers[0].id.facing[facing_curr].sprite;
			var _myself_x = (myself.x + myself.offsetX + myself.shake.offsetX);
			var _myself_y = (myself.y + myself.offsetY + myself.shake.offsetY);
			fn_draw_spr_part(_passenger_sprite, 0, _myself_x, (_myself_y - fn_sprite_height(_passenger_sprite)), 0, 0, fn_sprite_width(_passenger_sprite), (round(fn_sprite_height(_passenger_sprite) / 1.5) + 1));
			fn_draw_spr(spr_actor_user_func_kart_1, facing_curr, _myself_x, _myself_y, myself.color, myself.alpha, myself.scaleX, myself.scaleY, myself.angle);
		}
		break;
	}
}