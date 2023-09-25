local Manager = require 'src.manager'

local Chapter = Class('Chapter')

function Chapter:enter(objects, items)
  self.objects = Manager(objects)
  self.inspectedObject = nil

  self.items = Manager(items)

  self.dialogue = nil

  self.suit = Suit.new()
end

function Chapter:inspect(inspectable)
  self.inspectedObject = inspectable
end

function Chapter:update(dt)
  self.objects:update(dt)

  if self.inspectedObject then
    self.inspectedObject:inspectUpdate(dt)
    
    if self.suit:Button('BACK', 40, 40, 150, 60).hit then
      self.inspectedObject = nil
    end
  end
end

function Chapter:draw()
  self.objects:draw()

  love.graphics.setColor(1, 1, 1)
  love.graphics.print(tostring(self.inspectedObject))

  if self.inspectedObject then
    love.graphics.setColor(0, 0, 0, 0.4)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setColor(1, 1, 1)

    self.inspectedObject:inspectDraw()
  end

  self.suit:draw()
end

function Chapter:mousepressed(mx, my, button)
  local event = {
    mx = mx, my = my,
    button = button, resolved = false
  }

  if self.inspectedObject then
    self.inspectedObject:inspectMousepressed(event)
  else
    self.objects:mousepressed(event)
  end
end

return Chapter