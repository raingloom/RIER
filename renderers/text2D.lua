function renderers.text2D ( effect, deltaTime )
	local meta=effect[0]
	local length,elapsed=meta[1],meta[2]
	if not areEffectsPaused then
		elapsed=elapsed+(deltaTime*(meta[4]or 1)*(globalEffectSpeed))
		meta[2]=elapsed
	end
	local progress=elapsed/length
	local res=evalProps(effect,progress)
	dxDrawText(unpack(res,1,res.n))
	return progress>=1
end