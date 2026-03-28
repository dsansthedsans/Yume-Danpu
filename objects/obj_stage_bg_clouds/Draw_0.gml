
var _loop = clouds.loop;
var _move = clouds.loop.move;

// Movement
if (_move.xDur > 0 && _move.yDur > 0 && global.config.access.rdcdMot.act == false)
{
	clouds.xOfs += ((_loop.xDist * _move.xSign) / _move.xDur);
	if (abs(clouds.x + clouds.xOfs) >= _loop.xDist)
		clouds.xOfs -= (_loop.xDist * _move.xSign);
	
	clouds.yOfs += ((_loop.yDist * _move.ySign) / _move.yDur);
	if (abs(clouds.y + clouds.yOfs) >= _loop.yDist)
		clouds.yOfs -= (_loop.yDist * _move.ySign);
}

// Draws the cloud background
for (var w = 0; w < _loop.xLen; w++)
{
	for (var h = 0; h < _loop.yLen; h++)
	{
		var _loop_xAdd = (_loop.xDist * (w - _loop.xLenOUT));
		var _loop_yAdd = (_loop.yDist * (h - _loop.yLenOUT));
		fn_draw_spr(clouds.spr, clouds.img, (clouds.x + clouds.xOfs + _loop_xAdd), (clouds.y + clouds.yOfs + _loop_yAdd), clouds.col, clouds.alp, clouds.xSc, clouds.ySc, clouds.ang, false);
	}
}
