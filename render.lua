effectRenderers={}
numberOfEffects=0
areEffectsPaused=true
evalMemoText=""

if not fileExists( "log.txt" ) then
	fileCreate( "log.txt" )
end
logfile=fileOpen( "log.txt" )

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

function pack ( ... )
	return arg
end

function log ( ... )
	fileWrite( logfile, unpack (arg,1,arg.n))
	return unpack( arg, 1, arg.n )
end

function effectRenderers.text2d ( effect, deltaTime )
	effect[2]=areEffectsPaused and effect[2] or effect[2]+deltaTime
	local progress=effect[2]/effect[1]
	local res=evalProps( effect, progress )
	dxDrawText( unpack( res, 3, res.n ) )
	return progress>=1
end


--3D text renderer options
local defdd=60
function effectRenderers.text3d ( effect, deltaTime )
	effect[2]=areEffectsPaused and effect[2] or effect[2]+deltaTime
	local progress=effect[2]/effect[1]
	local res=evalProps( effect, progress )
	evalMemoText=rprint(res)
	local wx,wy,wz=unpack(res,4,6)
	local sx,sy=getScreenFromWorldPosition(wx,wy,wz,1)
	if sx then
		scx,scy=res[10],type(res[11])=="number" and res[11]
		local dist=getDistanceBetweenPoints3D(wx,wy,wz,getCameraMatrix())
		local q=(defdd-dist)/defdd
		if q>0 then
			--Build arglist
			local args=concatenateArglist(res[3],sx,sy,{unpack(res,7,9)},scx and scx*q or q, scy and scy*q or {unpack(res,11,res.n)},scy and {unpack(res,12,res.n)})
			evalMemoText=evalMemoText.."\n"..rprint(args)
			dxDrawText(unpack(args,1,args.n))
		end
	end
	return progress>=1
end

function effectRenderers.texture ( effect )
	return true
end

function renderEffectsInPools ( deltaTime )
	if numberOfEffects > 0 then
		for rendererType, pool in pairs(effectsInProgress) do
			local i=1
			--'while' loop checks table length, 'for' loop only uses it at initialization and does not update it, thus 'while' is the winner choice here, because we don't want any extra iterations or skips, due to removed effects
			while i<=#pool or i<0 do
				--renderers are expected to return a value other than 'false' and 'nil' when an effect is finished, so it can be removed from the pool
				if effectRenderers[rendererType](pool[i],deltaTime) then
					table.remove(pool,i)
					numberOfEffects=numberOfEffects-1
					if numberOfEffects==0 then
						removeEventHandler( "onClientPreRender", root, renderEffectsInPools )
						i=-1
						break
					end
				end
				i=i+1
			end
		end
	end
end


--EXPORTS

---Adds an effect to the pool.
--@param poolName A valid effect pool.
--@param effect A valid effect.
--@return int The numerical ID of the effect. effectsByID[ID] returns the effect. Since tables are shared in memory, removing the table from the pool removes it from effectsByID as well.
function addEffectToPool ( poolName, effect )
	local pool=assert(effectsInProgress[poolName],"Invalid pool")
	table.insert(pool,effect)
	local l=#effectsByID
	table.insert(effectsByID,effect)
	numberOfEffects=numberOfEffects+1
	if numberOfEffects==1 then
		addEventHandler( "onClientPreRender", root, renderEffectsInPools )
	end
	return l
end

---Meant to be used as an exported function.
--Lets other resources know the pools current state
function getPoolsJSON ()
	return toJSON( effectsInProgress )
end

--addEventHandler( "onClientPreRender", root, renderEffectsInPools )

function togPause ()
	areEffectsPaused=not areEffectsPaused
end

bindKey("n","up",togPause)