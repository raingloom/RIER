effectRenderers={}
numberOfEffects=0
areEffectsPaused=false

function print (...)
	local s=""
	for i=1,arg.n do
		s=s..", "..tostring(arg[i])
	end
	outputDebugString(s:sub(3))
	return unpack(arg)
end

function effectRenderers.text2d ( effect, deltaTime )
	print(#effect)
	effect[2]=areEffectsPaused and effect[2] or effect[2]+deltaTime
	local progress=effect[2]/effect[1]
	dxDrawText( select ( 3, unpack( evalProps( effect, progress ) ) ) )
	return progress>1
end

function effectRenderers.text3d ( effect )
	return true
end

function effectRenderers.texture ( effect )
	return true
end

function renderEffectsInPools ( deltaTime )
	for rendererType, pool in pairs(effectsInProgress) do
		local i=1
		--'while' loop checks table length, 'for' loop only uses it at initialization and does not update it, thus 'while' is the winner choice here, because we don't want any extra iterations or skips, due to removed effects
		while i<=#pool do
			--renderers are expected to return a value other than 'false' and 'nil' when an effect is finished, so it can be removed from the pool
			if effectRenderers[rendererType](pool[i],deltaTime) then
				table.remove(pool,i)
				numberOfEffects=numberOfEffects-1
			end
			i=i+1
		end
	end
end


--EXPORTS

function addEffectToPool ( poolName, effect )
	local pool=assert(effectsInProgress[poolName],"Invalid pool")
	table.insert(pool,effect)
end

---Meant to be used as an exported function.
--Lets other resources know the pools current state
function getPoolsJSON ()
	return toJSON( effectsInProgress )
end

addEventHandler( "onClientPreRender", root, renderEffectsInPools )

function togPause ()
	areEffectsPaused=not areEffectsPaused
end

bindKey("n","up",togPause)