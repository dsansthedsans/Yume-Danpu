/* Self-drawing */
if (myself.active == true)
{
	if (type == TYPE_ACTOR)
		myself.sprite = facing[facing_curr].sprite;
	myself.image = (myself.image + (myself.imageSpeed * (myself.imageSpeed > 0 && global.config.access.reduceMotion.active == false)));
	myself.shake.offsetX = ((myself.shake.active == true && myself.shake.time > 0) ? (irandom(myself.shake.distance) * choose(-1, 1)) : 0);
	myself.shake.offsetY = ((myself.shake.active == true && myself.shake.time > 0) ? (irandom(myself.shake.distance) * choose(-1, 1)) : 0);
	myself.shake.time = ((myself.shake.time > 0) ? (myself.shake.time - 1) : 0);
	if (myself.type == MYSELF_TYPE_DEFAULT)
		fn_draw_spr(myself.sprite, myself.image, (myself.x + myself.offsetX + myself.shake.offsetX), (myself.y + myself.offsetY + myself.shake.offsetY), myself.color, myself.alpha, myself.scaleX, myself.scaleY, myself.angle);
	else if (myself.type == MYSELF_TYPE_CUSTOM)
	{
		
	}
}

event_user(4);