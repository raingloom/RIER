---Evaluates a list of properties used by the effect drawing functions
--any table value is expected to be a property
--@param propList an array of arbitrary properties
--@param progress the progress to pass to interpolateBetween when interpolating properties
--@return a table of properties
function evalProps ( propList, progress )
	local ret={}
	local sa,sb,sc=0,0,0
	local ta,tb,tc=0,0,0
	local a,b,c
	local i=1
	local prop
	for j=1,propList.n or #propList do
		prop=propList[j]
		if type(prop)=="table" then
			sa,sb,sc=prop[1],prop[2],prop[3]
			ta,tb,tc=prop[4],prop[5],prop[6]
			a,b,c = interpolateBetween( sa or 0, sb or 0, sc or 0, ta or 0, tb or 0, tc or 0, progress, easingFunctions[prop[7]], unpack(prop,8,prop.n))
			if sa~=nil then
				ret[i]=a
				i=i+1
			end
			if sb~=nil then
				ret[i]=b
				i=i+1
			end
			if sc~=nil then
				ret[i]=c
				i=i+1
			end
		else
			ret[i]=prop
			i=i+1
		end
	end
	ret.n=i-1
	return ret
end

--cold test
if not createElement then
	easingFunctions={}
	--only linear is supported for cold tests
	function interpolateBetween (x1,y1,z1,x2,y2,z2,progress)
		rx,ry,rz=x2-x1,y2-y1,z2-z1
		--progress=progress+1
		return rx*progress,ry*progress,rz*progress
	end
	require"rprint"
	---[[
	sx,sy=1024,768
	effect = {
		15e3,
		0,
		"Wow, some effect!",
		{sx/2,0,nil,sx/2+10,sy/2,nil,14,n=7},
		nil,nil,nil,
		{1,5,nil,20,10,nil,14,n=7},
		"pricedown",
		nil,nil,nil,nil,nil,nil,nil,
		true,
		n=15
	}
	for i=0,1,0.1 do
		res=evalProps(effect,i)
		print(unpack(res,6,8))
	end
end
