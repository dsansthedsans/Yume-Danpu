
var _loop = sky.loop;
var _move = sky.loop.move;

// Movement
if (_move.xTime > 0 && _move.yTime > 0)
{
	sky.xOffset += ((_loop.xDist * _move.xSign) / _move.xTime); 
	if (abs(sky.x + sky.xOffset) >= _loop.xDist)
		sky.xOffset -= (_loop.xDist * _move.xSign);
	sky.yOffset += ((_loop.yDist * _move.ySign) / _move.yTime);
	if (abs(sky.y + sky.yOffset) >= _loop.yDist)
		sky.yOffset -= (_loop.yDist * _move.ySign);
}
// Drawings
for (var w = 0; w < _loop.xLength; w++)
{
	for (var h = 0; h < _loop.yLength; h++)
	{
		var _loop_xAdd = (_loop.xDist * (w - _loop.xLength_outsideRoom));
		var _loop_yAdd = (_loop.yDist * (h - _loop.yLength_outsideRoom));
		fn_draw_spr_stretch(sky.sprite, sky.image, (sky.x + (sky.xOffset * (global.config.access.rdcdMot.act == false)) + _loop_xAdd), (sky.y + (sky.yOffset * (global.config.access.rdcdMot.act == false)) + _loop_yAdd), sky.width, sky.height, sky.color, sky.alpha);
	}
}

