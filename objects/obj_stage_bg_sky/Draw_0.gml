
var _loop = sky.loop;
var _move = sky.loop.move;

// Movement
if (_move.xTime > 0 && _move.yTime > 0)
{
	sky.offsetX += ((_loop.xDist * _move.xSign) / _move.xTime); 
	if (abs(sky.x + sky.offsetX) >= _loop.xDist)
		sky.offsetX -= (_loop.xDist * _move.xSign);
	sky.offsetY += ((_loop.yDist * _move.ySign) / _move.yTime);
	if (abs(sky.y + sky.offsetY) >= _loop.yDist)
		sky.offsetY -= (_loop.yDist * _move.ySign);
}
// Drawings
for (var w = 0; w < _loop.xLength; w++)
{
	for (var h = 0; h < _loop.yLength; h++)
	{
		var _loop_xAdd = (_loop.xDist * (w - _loop.xLength_outsideRoom));
		var _loop_yAdd = (_loop.yDist * (h - _loop.yLength_outsideRoom));
		fn_draw_spr_stretch(sky.sprite, sky.image, (sky.x + (sky.offsetX * (global.config.access.reduceMotion.active == false)) + _loop_xAdd), (sky.y + (sky.offsetY * (global.config.access.reduceMotion.active == false)) + _loop_yAdd), sky.width, sky.height, sky.color, sky.alpha);
	}
}

