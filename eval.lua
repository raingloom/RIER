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
	for j=1,#propList do
		prop=propList[j]
		if type(prop)=="table" then
			sa,sb,sc=prop[1],prop[2],prop[3]
			ta,tb,tc=prop[4],prop[5],prop[6]
			a,b,c = interpolateBetween( sa or 0, sb or 0, sc or 0, ta or 0, tb or 0, tc or 0, progress, easingFunctions[prop[7]], select(8,unpack(prop)))
			if sa~="\0" then
				ret[i]=a
				i=i+1
			end
			if sb~="\0" then
				ret[i]=b
				i=i+1
			end
			if sc~="\0" then
				ret[i]=c
				i=i+1
			end
		else
			ret[i]=prop
			i=i+1
		end
	end
	return ret
end

--cold test
if not createElement then
	easingFunctions={}
	--only linear is supported for cold tests
	function interpolateBetween (x1,y1,z1,x2,y2,z2,progress)
		rx,ry,rz=x2-x1,y2-y1,z2-z1
		return rx*progress,ry*progress,rz*progress
	end
	require"rprint"
	res=evalProps({
		1,
		2,
		3,
		{0,0,nil,1,1,1,1},
		nil,
		0
	},0.5)
	print(rprint(res))
	print(unpack(res))
end
