--Effects pool
effectsInProgress={
	text2d={},
--[[
	2D text effect example
	{
		5e3,--effect length in miliseconds
		0,--elapsed miliseconds
		"Hello Bounciness!",--text
		{-20,-20,nil,512,384,nil,8},--2D coordinates
		nil,--right (infered)
		nil,--bottom (infered)
		0xffff0000,--color
		{0,0,nil,16,9,nil,8},--2D scale
		n=8--necessary, because Lua doesn't handle nils always as you might expect it to. Use n='length of arg list' whenever you have 'nil'-s among them. Otherwise, it can be omitted.
	}
]]
	text3d={},
	--texture={}
}
effectsByID={}