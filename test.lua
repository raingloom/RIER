local sx,sy=guiGetScreenSize()
addEffectToPool ( "text2d",
	{
		3e3,
		0,
		"Wow, some effect!",
		{sx/2,-10,"\0",sx/2,sy/2,"\0",14},
		nil,
		nil,
		nil,
		8
	}
)