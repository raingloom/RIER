--Layered effects
effects2D={}
--3D effects
effects3D={}
--Used for organizing the 3D effects by distance.
zlist={}
--Contains renderer functions
renderers={}
--Keeps track of effects. Used for putting the resource to 'sleep'.
numberOfEffects=0
--Mostly for debug. When set to true, the progress of any effect is not updated
areEffectsPaused=true
globalEffectSpeed=getGameSpeed()

function concatenateArglist( ... )
	local ret,n,b={},0
	for i=1,arg.n do
		b=arg[i]
		if type(b)=="table" then
			for j=1,b.n or #b do
				n=n+1
				ret[n]=b[j]
			end
		else
			n=n+1
			ret[n]=b
		end
	end
	ret.n=n
	return ret
end

function print (...)
	local s=""
	for i=1,arg.n do
		s=s..", "..tostring(arg[i])
	end
	outputDebugString(s:sub(3))
	return unpack(arg)
end

function addEffect2D ( ... )
	-- body
end

function addEffect3D ( ... )
	-- body
end

function render2DStack ()
	local i=1
	while i<=#effects2D or i<0 do
		local effect=effects2D[i]
		if renderers[effect[0][1]] then
			table.remove(effects2D,i)
		else
			i=i+1
		end
	end
end

function render3DStack ( ... )
	-- body
end

function compareZ(a,b)
	return a[1]<b[1]
end