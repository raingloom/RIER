function rprint (t,tabchar,l)
	l=l or 0
	local ret=""
	tabchar=tabchar or "  "
	local tab=(tabchar):rep(l)
	for k,v in pairs(t) do
		v=v=="\0" and nil or v
		if type(v)=="table" then
			ret=ret.."\n"..tab..tostring(k).."={\n"..rprint(v,tabchar,l+1).."\n"..tab.."}"
		else
			ret=ret.."\n"..tab..tostring(k).."="..tostring(v)
		end
	end
	return ret:sub(2)
end
