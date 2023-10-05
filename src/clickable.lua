local Object = require 'src.object'

local Clickable = Class('Clickable', Object)

function Clickable:initialize(x, y, sprite, layer, w, h, colliders, onClick)
  -- self.w, self.h = w, h 

  if self.sprite ~= nil then
    Object.initialize(self, x, y, sprite, layer, w, h)
  else
    Object.initialize(self, x, y, nil, layer, w, h)
  end

  self.colliders = colliders or {}
  for _, collider in ipairs(self.colliders) do
    collider:setObject(self)
  end

  self.onClick = onClick or function() print('clickable clicked') end
end

function Clickable:draw()
  if self.sprite ~= nil then
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.sprite, self.x, self.y, 0, 2, 2)
  end

  if DEBUG then
    love.graphics.setColor(1, 1, 1, 0)
    for _, collider in ipairs(self.colliders) do
      love.graphics.rectangle('line', self.x + collider.x, self.y + collider.y, collider.w, collider.h)
    end
  end
end

function Clickable:mousepressed(event)
  -- Event
  -- mx, my : mouse position
  -- button : mouse button
  -- resolved : is false when first created

  if event.resolved then return end

  for _, collider in ipairs(self.colliders) do
    if collider:containsPoint(event.mx, event.my) then
      self:onClick()
      event.resolved = true
      break
    end
  end
end

return Clickable