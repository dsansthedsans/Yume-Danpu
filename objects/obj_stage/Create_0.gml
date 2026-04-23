
fn_obj_img( , , , , 0);
fn_obj_depth( , -9000);

// Music
music_lengthMax = 3;
for (var m = 0; m < music_lengthMax; m++)
{
	music[m] =
	{
		asset : undefined,
		emitter : undefined,
		pitch : 0,
		id : undefined,
	}
}

// Background
bg_lengthMax = 5;
for (var b = 0; b < bg_lengthMax; b++)
	bg[b] = -1;
