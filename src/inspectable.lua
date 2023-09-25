local Manager = require 'src.manager'

local Object = require 'src.object'

local Inspectable = Class('Inspectable', Object)

function Inspectable:initialize(x, y, sprite, layer, colliders, objects, clickables)
  Object.initialize(self, x, y, sprite, layer)

  self.colliders = colliders or {}
  for _, collider in ipairs(self.colliders) do
    collider:setObject(self)
  end

  self.objects = Manager(objects)
  self.clickables = Manager(clickables)
end

function Inspectable:mousepressed(event)
  -- Event
  -- mx, my : mouse position
  -- button : mouse button
  -- solved : is false when first created

  if event.resolved then return end

  for _, collider in ipairs(self.colliders) do
    if collider:containsPoint(event.mx, event.my) then
      Gamestate.current():inspect(self)
      event.resolved = true
      break
    end
  end
end

function Inspectable:inspectUpdate(dt)
  self.objects:update(dt)
end

function Inspectable:inspectDraw()
  self.objects:draw()
  self.clickables:draw()
end

function Inspectable:inspectMousepressed(event)
  self.clickables:mousepressed(event)
end

return Inspectable