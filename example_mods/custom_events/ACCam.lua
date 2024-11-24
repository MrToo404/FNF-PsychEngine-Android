
--[[
--simp
[x, y, zoom]

--adv
[x, y, zoom, posspeed, zoomspeed,postween,zoomtween]


--beat
beatspeed
--resetPos

--flash
color,duration
--fade
color,duration or 'clear'

set param empty to ignore
set x or y to a character to pos to character

]]--



--ACCam (Advanced Control Camera) by bbpanzu


camBoomSpeed = 16
camBoomIntensity = 1

camBeatType = 0 
--0 = speed
--1 = pattern
camPattern = {}

camPos = {}

camOffset = {}

noteFollowOffset = 20
defaultCamPos = {0,0}

default = true


------------------tween.lua by cyn0x8--------------------
-------------------edited by bbpanzu--------------------

--[[ easing formulas by robert penner http://www.robertpenner.com/easing ]]
local sin, cos, pi, sqrt, abs, asin = math.sin, math.cos, math.pi, math.sqrt, math.abs, math.asin
local eases = { 
	["linear"] = function(t, b, c, d) return c * t / d + b end,
	
	["quadin"] = function(t, b, c, d) t = t / d return c * t ^ 2 + b end,
	["quadout"] = function(t, b, c, d) t = t / d return -c * t * (t - 2) + b end,
	["quadinout"] = function(t, b, c, d) t = t / d * 2 if t < 1 then return c / 2 * t ^ 2 + b else return -c / 2 * ((t - 1) * (t - 3) - 1) + b end end,
	
	["cubein"] = function(t, b, c, d) t = t / d return c * t ^ 3 + b end,
	["cubeout"] = function(t, b, c, d) t = t / d - 1 return c * (t ^ 3 + 1) + b end,
	["cubeinout"] = function(t, b, c, d) t = t / d * 2 if t < 1 then return c / 2 * t ^ 3 + b else t = t - 2 return c / 2 * (t ^ 3 + 2) + b end end,
	
	["quartin"] = function(t, b, c, d) t = t / d return c * t ^ 4 + b end,
	["quartout"] = function(t, b, c, d) t = t / d - 1 return -c * (t ^ 4 - 1) + b end,
	["quartinout"] = function(t, b, c, d) t = t / d * 2 if t < 1 then return c / 2 * t ^ 4 + b else t = t - 2 return -c / 2 * (t ^ 4 - 2) + b end end,
	
	["quintin"] = function(t, b, c, d) t = t / d return c * t ^ 5 + b end,
	["quintout"] = function(t, b, c, d) t = t / d - 1 return c * (t ^ 5 + 1) + b end,
	["quintinout"] = function(t, b, c, d) t = t / d * 2 if t < 1 then return c / 2 * t ^ 5 + b else t = t - 2 return c / 2 * (t ^ 5 + 2) + b end end,
	
	["sinein"] = function(t, b, c, d) return -c * cos(t / d * (pi / 2)) + c + b end,
	["sineout"] = function(t, b, c, d) return c * sin(t / d * (pi / 2)) + b end,
	["sineinout"] = function(t, b, c, d) return -c / 2 * (cos(pi * t / d) - 1) + b end,
	
	["expoin"] = function(t, b, c, d) if t == 0 then return b else return c * 2 ^ (10 * (t / d - 1)) + b - c * 0.001 end end,
	["expoout"] = function(t, b, c, d) if t == d then return b + c else return c * 1.001 * (-(2 ^ (-10 * t / d)) + 1) + b end end,
	["expoinout"] = function(t, b, c, d) if t == 0 then return b end if t == d then return b + c end t = t / d * 2 if t < 1 then return c / 2 * 2 ^ (10 * (t - 1)) + b - c * 0.0005 else t = t - 1 return c / 2 * 1.0005 * (-(2 ^ (-10 * t)) + 2) + b end end,
	
	["circin"] = function(t, b, c, d) t = t / d return(-c * (sqrt(1 - t ^ 2) - 1) + b) end,
	["circout"] = function(t, b, c, d) t = t / d - 1 return(c * sqrt(1 - t ^ 2) + b) end,
	["circinout"] = function(t, b, c, d) t = t / d * 2 if t < 1 then return -c / 2 * (sqrt(1 - t * t) - 1) + b else t = t - 2 return c / 2 * (sqrt(1 - t * t) + 1) + b end end,

}





local easesABB = { 
	["l"] = 'linear',
	
	["qi"] = 'quadin',
	["qo"] = 'quadout',
	["qio"]= 'quadiniut',
	
	["ci"] = 'circin',
	["co"] = 'circout',
	["cio"] = 'circinout',
	
	["qri"] = 'quartin',
	["qro"] = 'quartout',
	["qrio"] = 'quartinout',
	
	["qii"] = 'quintin',
	["qio"] = 'quintout',
	["qiio"] = 'quintinout',
	
	["si"] = 'sinein',
	["so"] = 'sineout',
	["sio"] ='sineinout',
	
	["exi"] = 'expoin',
	["exo"] = 'expoout',
	["exio"] = 'expoinout',
	
	["ci"] = 'circin',
	["co"] = 'circout',
	["cio"] = 'circinout',
	
	["eli"] = 'elasticin',
	["elo"] = 'elasticout',
	["elio"]= 'elasticinout',

	["bi"] =  'backin',
	["bo"] =  'backout',
	["bio"] = 'backinout',

	["boi"] = 'bouncein',
	["boo"] = 'bounceout',
	["boio"] ='bounceinout,'
}





local function inElastic(t, b, c, d, a, p)
  if t == 0 then return b end

  t = t / d

  if t == 1  then return b + c end

  if not p then p = d * 0.3 end

  local s

  if not a or a < abs(c) then
    a = c
    s = p / 4
  else
    s = p / (2 * pi) * asin(c/a)
  end

  t = t - 1

  return -(a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b
end

-- a: amplitud
-- p: period
local function outElastic(t, b, c, d, a, p)
  if t == 0 then return b end

  t = t / d

  if t == 1 then return b + c end

  if not p then p = d * 0.3 end

  local s

  if not a or a < abs(c) then
    a = c
    s = p / 4
  else
    s = p / (2 * pi) * asin(c/a)
  end

  return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p) + c + b
end

-- p = period
-- a = amplitud
local function inOutElastic(t, b, c, d, a, p)
  if t == 0 then return b end

  t = t / d * 2

  if t == 2 then return b + c end

  if not p then p = d * (0.3 * 1.5) end
  if not a then a = 0 end

  local s

  if not a or a < abs(c) then
    a = c
    s = p / 4
  else
    s = p / (2 * pi) * asin(c / a)
  end

  if t < 1 then
    t = t - 1
    return -0.5 * (a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b
  else
    t = t - 1
    return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p ) * 0.5 + c + b
  end
end

-- a: amplitud
-- p: period
local function outInElastic(t, b, c, d, a, p)
  if t < d / 2 then
    return outElastic(t * 2, b, c / 2, d, a, p)
  else
    return inElastic((t * 2) - d, b + c / 2, c / 2, d, a, p)
  end
end

local function inBack(t, b, c, d, s)
  if not s then s = 1.70158 end
  t = t / d
  return c * t * t * ((s + 1) * t - s) + b
end

local function outBack(t, b, c, d, s)
  if not s then s = 1.70158 end
  t = t / d - 1
  return c * (t * t * ((s + 1) * t + s) + 1) + b
end

local function inOutBack(t, b, c, d, s)
  if not s then s = 1.70158 end
  s = s * 1.525
  t = t / d * 2
  if t < 1 then
    return c / 2 * (t * t * ((s + 1) * t - s)) + b
  else
    t = t - 2
    return c / 2 * (t * t * ((s + 1) * t + s) + 2) + b
  end
end

local function outInBack(t, b, c, d, s)
  if t < d / 2 then
    return outBack(t * 2, b, c / 2, d, s)
  else
    return inBack((t * 2) - d, b + c / 2, c / 2, d, s)
  end
end

local function outBounce(t, b, c, d)
  t = t / d
  if t < 1 / 2.75 then
    return c * (7.5625 * t * t) + b
  elseif t < 2 / 2.75 then
    t = t - (1.5 / 2.75)
    return c * (7.5625 * t * t + 0.75) + b
  elseif t < 2.5 / 2.75 then
    t = t - (2.25 / 2.75)
    return c * (7.5625 * t * t + 0.9375) + b
  else
    t = t - (2.625 / 2.75)
    return c * (7.5625 * t * t + 0.984375) + b
  end
end

local function inBounce(t, b, c, d)
  return c - outBounce(d - t, 0, c, d) + b
end

local function inOutBounce(t, b, c, d)
  if t < d / 2 then
    return inBounce(t * 2, 0, c, d) * 0.5 + b
  else
    return outBounce(t * 2 - d, 0, c, d) * 0.5 + c * .5 + b
  end
end

local function outInBounce(t, b, c, d)
  if t < d / 2 then
    return outBounce(t * 2, b, c / 2, d)
  else
    return inBounce((t * 2) - d, b + c / 2, c / 2, d)
  end
end




--BASIC TWEENING TOOL
--BY BLUECOLORSIN

--How to use
--addLuaScript(TweenTool) --😱😱😱😱😱

Q = { --Quad, Quart, Quint 
    U = { --Quad
        i = 'quadIn', --QuadIn
        io = 'quadInOut', --QuadInOut
        o = 'quadOut' --QuadOut
    }, 
    A = { --Quart
        i = 'quartIn', --QuartIn
        io = 'quartInOut', --QuartInOut
        o = 'quartOut' --QuartOut
    },  
    I = { --Quint
        i = 'quintIn', --QuintIn
        io = 'quintOut', --QuintInOut 
        o = 'quintInOut' --QuintOut
}} 
C = { --Cube, Circ
    B = { --Cube
        i = 'cubeIn', --CubeIn
        io = 'cubeInOut', --CubeInOut
        o = 'cubeOut' --CubeOut
    },
    R = { --Circ
        i = 'circIn', --CircIn
        io = 'circInOut', --CircInOut
        o = 'circOut' --CircOut
}} 
S = {--Sine, SmoothStep, SmootherStep
    I = {--Sine
        i = 'sineIn', --SineIn
        io = 'sineInOut', --SineInOut
        o = 'sineOut' --SineOut
    },
    S = { --SmoothStep
        i = 'smoothStepIn', --SmoothStepIn
        io = 'smoothStepInOut', --SmoothStepInOut
        o = 'smoothStepOut' --SmoothStepOut
    },
    SM = { --SmootherStep 😩
        i = 'smootherStepIn', --SmootherStepIn
        io = 'smootherStepInOut', --SmootherStepInOut
        o = 'smootherStepOut' --SmootherStepOut
 }} 
B = {--Bounce, Back
    O = { --Bounce
        i = 'bounceIn', --BounceIn
        io = 'bounceInOut', --BounceInOut
        o = 'bounceOut' --BounceOut
    },
    A = {--Back
        i = 'backIn',
        io = 'backInOut',
        o = 'backOut'
    }
} 
E = {--Expo, Elastic
    X = {--Expo
        i = 'expoIn', --ExpoIn
        io = 'expoInOut', --ExpoInOut
        o = 'expoOut' -- ExpoOut
    },
    E = {
        i = 'elasticIn', --ElasticIn
        io = 'elasticInOut', --ElasticInOut
        o = 'elasticOut' --ElasticOut
    }
} 
L = 'linear'






local tweens = {{}, {}}

--

function tween_property(property, goal, duration, ease)
	ease = ease:lower()
	if eases[ease] then
		local start = getProperty(property)
		if start then
			tweens[1][property] = {os.clock() + duration, start, goal - start, duration, ease}
		end
	end
end

function get_tween_value(tag)
	local tween = tweens[2][tag]
	if tween then return tween[1] end
end
function tween_value(tag, start, goal, duration, ease)
	ease = ease:lower()
	if eases[ease] then
		tweens[2][tag] = {start, os.clock() + duration, start, goal - start, duration, ease}
	end
end

function update_tweens()
	for property, tween in pairs(tweens[1]) do
		if os.clock() <= tween[1] then setProperty(property, eases[tween[5]](tween[4] - (tween[1] - os.clock()), tween[2], tween[3], tween[4]))
		else tweens[1][property] = nil end
	end
	for tag, tween in pairs(tweens[2]) do
		if os.clock() <= tween[2] then tween[1] = eases[tween[6]](tween[5] - (tween[2] - os.clock()), tween[3], tween[4], tween[5])
		else tweens[2][tag] = nil end
	end
end


function checktween(tw)
if get_tween_value(tw) then
	setProperty(tw,get_tween_value(tw))
	end
end

----------------------------------------------------------------------------








function split(pString, pPattern)
   local Table = {n=0}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pPattern
   local last_end = 1
   local s, e, cap = pString:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
     table.insert(Table,cap)
      end
      last_end = e+1
      s, e, cap = pString:find(fpat, last_end)
   end
   if last_end <= #pString then
      cap = pString:sub(last_end)
      table.insert(Table, cap)
   end
   return Table
end






---------------------------
tweening = false
function onEvent(n,v,v2)
	
	if n == 'ACCam' then
	data = split(v2,',')
	
		if v == 'simp' then
			default = false
			setProperty('isCameraOnForcedPos',true)
			--get current properties















			x = getProperty('camFollow.x')
			y = getProperty('camFollow.y')
			zoom = getProperty('defaultCamZoom')

			--set x
			x = data[1]

			--set y
			y = data[2]

			--set zoom
			zoom = data[3]

			
if x == 'dad' then
	
x = getMidpointX('dad') +150

elseif x == 'bf' then

x = getMidpointX('boyfriend') -100

elseif x == 'gf' then

x = getMidpointX('gf')

end
		

if y == 'dad' then

y = getMidpointY('dad')-100

end

if y == 'bf' then

y = getMidpointY('boyfriend')-100

elseif y == 'gf' then

y = getMidpointY('gf')

end
			
			defaultCamPos = {x,y}
			triggerEvent('Camera Follow Pos',x,y)
			setProperty('defaultCamZoom',zoom)
			
		elseif v == 'adv' then
			default = false
			setProperty('isCameraOnForcedPos',true)
			--get current properties

			x = getProperty('camFollow.x')
			y = getProperty('camFollow.x')
			zoom = getProperty('camGame.scroll.x')
			posspeed = 0.01
			zoomspeed = 0.01
			postween = 'quadOut'
			zoomtween = 'quadOut'
			--set x
			x = data[1]

			--set y
			y = data[2]

			--set zoom
			zoom = data[3]

			--set zoom
			posspeed = tonumber(data[4])
			

			--set zoom
			zoomspeed = data[5]

			--set zoom
			postween = data[6]
			

			--set zoom
			zoomtween = data[7]
			
			defaultCamPos = {x,y}
			

if x == 'dad' then
	
x = getMidpointX('dad') +150

elseif x == 'bf' then

x = getMidpointX('boyfriend') -100

elseif x == 'gf' then

x = getMidpointX('gf')

end
		

if y == 'dad' then

y = getMidpointY('dad')-100

end

if y == 'bf' then

y = getMidpointY('boyfriend')-100

elseif y == 'gf' then

y = getMidpointY('gf')

end




			if posspeed == 0 then
				setProperty('camFollowPos.x',x)
				setProperty('camFollowPos.y',y)
				setProperty('camFollow.x',x)
				setProperty('camFollow.y',y)
				setProperty('camGame.scroll.x',x+640)
				setProperty('camGame.scroll.y',y+360)
			else
				doTweenX('CX','camGame.scroll', x, posspeed, easesABB[postween])
				doTweenY('CY','camGame.scroll', y, posspeed, easesABB[postween])
				doTweenX('CX2','camFollow', x, posspeed, easesABB[postween])
				doTweenY('CY2','camFollow', y, posspeed, easesABB[postween])
				doTweenX('CX3','camFollowPos', x, posspeed, easesABB[postween])
				doTweenY('CY3','camFollowPos', y, posspeed, easesABB[postween])
			end
			if zoomspeed == 0 then
				setProperty('camGame.zoom',zoom)
				setProperty('defaultCamZoom',zoom)
			else
				doTweenZoom('CZ','camGame', zoom, zoomspeed , easesABB[zoomtween])
				--tween_property('defaultCamZoom', zoom, zoomspeed , easesABB[zoomtween])
				setProperty('defaultCamZoom',zoom)
				tweening = true
				runTimer('tweenin',zoomspeed)
			end
			
		elseif v == 'reset' then
			tweening = false
			default = true
			setProperty('isCameraOnForcedPos',false)
		elseif v == 'beat' then
			camBeatType = 0
			camBoomSpeed = data[1]
			camBoomIntensity = data[2]

		elseif v == 'pattern' then
			camBeatType = 1
			camPattern = data

			if camPattern[1] == 'jersey' then
				camPattern = {1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0}
			elseif camPattern[1] == 'dnb' then
				camPattern = {2, 0, 0, 0,-1, 0, 0, 0, 0, 0, 2, 0,-1, 0, 0, 0}
			elseif camPattern[1] == 'dnb2' then
				camPattern = {2, 0, 0, 0,-1, 0, 2, 0, 0, 0, 0, 0,-1, 0, 0, 0}
			elseif camPattern[1] == 'dnb3' then
				camPattern = {2, 0, 0, 0,-1, 0, 2, 0, 0, 0, 2, 0,-1, 0, 0, 0}
			end


			

		elseif v == 'flash' then

			cameraFlash('game',data[1],data[2],true)

		elseif v == 'saster' then

			triggerEvent('ACCam','flash','0xccffffff,0.6')
			
			if not tweening then
				bamcam('Game',0.04*2)
				bamcam('HUD',0.05*2)
			end

		elseif v == 'fade' then

			if v2 == 'reset' then
				setProperty('camGame._fxFadeCompleted', true);
				setProperty('camGame._fxFadeAlpha', 0);
			else
				cameraFade('game',data[1],data[2],true)
			end
		elseif v == 'speed' then

			setProperty('cameraSpeed',v2)
		elseif v == 'zoom' then

			setProperty('defaultCamZoom',v2)
		end



	end

end




function onStepHit()

if camBeatType == 0 then
if curStep % camBoomSpeed == 0 then
if not tweening then
bamcam('Game',0.04*camBoomIntensity)
end
bamcam('HUD',0.05*camBoomIntensity)

end
end

if camBeatType == 1 then
if not tweening then
bamcam('Game',0.04*camPattern[(curStep+1) % 16])
	
end
bamcam('HUD',0.05*camPattern[(curStep+1) % 16])
end





if not getProperty('isCameraOnForcedPos') then
runHaxeCode('game.moveCameraSection()')
end





end


function bamcam(c,m)
	setProperty('cam'..c..'.zoom',getProperty('cam'..c..'.zoom')+m)

end


function onCountdownTick()

runHaxeCode([[

game.beatHit();

]])
end
function onSongStart()

runHaxeCode([[

game.beatHit();
game.stepHit();
game.sectionHit();

]])
end




function lerp(a, b, t)
	return a + (b - a) * t
end


function onUpdatePost()
	update_tweens()
setProperty('camZooming',false)
	checktween('camGame.scroll.x')
	--checktween('camGame.y')
	--checktween('camGame.zoom')

setProperty('camGame.zoom',lerp(getProperty('camGame.zoom'),getProperty('defaultCamZoom'),0.04*camBoomIntensity))
setProperty('camHUD.zoom',lerp(getProperty('camHUD.zoom'),1,0.04*camBoomIntensity) )
end





function onTimerCompleted(tt,l,ll)
if tt == 'tweenin' then
tweening = false
end

end

local function checknumber(num)
    if type(num) == "number" then
        return true
    else
        return false
    end
end


function onBeatHit()
if default then
if d == 'dad' then
--defaultCamPos = {getMidpointX('dad'),getMidpointY('dad')}
end
if d == 'boyfriend' then
--defaultCamPos = {getMidpointX('dad'),getMidpointY('dad')}
end
end
end
