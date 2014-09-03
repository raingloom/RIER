--debug facilities
local refreshFreq=true--refresh every n miliseconds or always (if set to true)
local mainWindow=guiCreateWindow( 0.4, 0.3, 0.3, 0.4, "Rain's Interpolated Effects Renderer: eval debugger", true )
local memo=guiCreateMemo( 0, 0.1, 1, 1, "", true, mainWindow)
addEventHandler("onClientGUISize",mainWindow,
	function ()
		guiSetSize( memo, 1, 1, true )
	end
)
local last=0
local frames=0
guiMemoSetReadOnly( memo, true )
---[[
addEventHandler( "onClientPreRender", root,
	function ( delta )
		last=last+delta
		frames=frames+1
		if refreshFreq==true or last>= refreshFreq then
			guiSetText( memo, evalMemoText)
			last,frames=0,0
		end
	end
)