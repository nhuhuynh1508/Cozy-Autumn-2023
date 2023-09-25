local Object = require 'src.object'

local Clickable = Class('Clickable', Object)

function Clickable:initialize(x, y, sprite, layer, colliders, onClick)
  Object.initialize(self, x, y, sprite, layer)

  self.colliders = colliders or {}
  for _, collider in ipairs(self.colliders) do
    collider:setObject(self)
  end

  self.onClick = onClick or function() print('clickable clicked') end
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