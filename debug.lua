--debug facilities
local refreshFreq=true--refresh every n miliseconds or always (if set to true)
local mainWindow=guiCreateWindow( 0.7, 0.3, 0.3, 0.7, "Rain's Interpolated Effects Renderer: debugger", true )
local memo=guiCreateMemo( 0, 0.1, 1, 1, "", true, mainWindow)
local last=0
local frames=0
guiMemoSetReadOnly( memo, true )
---[[
addEventHandler( "onClientPreRender", root,
	function ( delta )
		last=last+delta
		frames=frames+1
		if refreshFreq==true or last>= refreshFreq then
			guiSetText( memo, "avgDelta="..(delta/frames).."\npoolDump:"..rprint(effectsInProgress,"  "))
			last,frames=0,0
		end
	end
)
--]]
guiSetText( memo, rprint(evalProps(effectsInProgress.text2d[1],0.5),"  "))