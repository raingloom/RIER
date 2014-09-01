local texture
local ticks=0
addEventHandler ("onClientPreRender", getRootElement (),
    function (deltaTime)
        texture = dxCreateTexture (64, 64)
        local pixels = dxGetTexturePixels (texture)
        ticks=(ticks+deltaTime)%13554634
        math.randomseed(ticks)
        for i=0,63 do
            for j=0,63 do
                dxSetPixelColor (pixels, j, i, math.random (255), math.random (255), math.random (255), 255)
            end;
        end;
        dxSetTexturePixels (texture, pixels)
        dxDrawImage (300, 300, 64, 64, texture)
    end)