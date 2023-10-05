Class = require 'libs.middleclass'
Gamestate = require 'libs.hump.gamestate'
Timer = require 'libs.hump.timer'
Hex2Color = require 'libs.hex2color'
Camera = require 'libs.hump.camera'
Suit = require 'libs.suit'

function math.clamp(v, min, max)
  if v < min then
    return min
  elseif v > max then
    return max
  else
    return v
  end
end

DEBUG = true