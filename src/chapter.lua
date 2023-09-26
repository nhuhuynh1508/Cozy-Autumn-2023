local Manager = require 'src.manager'

local Chapter = Class('Chapter')

function Chapter:enter(objects, items)
  self.objects = Manager(objects)
  self.inspectedObject = nil

  self.items = Manager(items)

  self.dialogues = {}
  self.currentDialogue = nil

  self.suit = Suit.new()
end

function Chapter:inspect(inspectable)
  self.inspectedObject = inspectable
end

function Chapter:addDialogue(name, line)
  table.insert(self.dialogues, {name = name, line = line})
  if self.currentDialogue == nil then
    self:nextDialogue()
  end
end

function Chapter:nextDialogue()
  if #self.dialogues > 0 then
    self.currentDialogue = self.dialogues[1]
    table.remove(self.dialogues, 1)
  else
    self.currentDialogue = nil
  end
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

  if self.currentDialogue then
    love.graphics.setColor(0.4, 0.4, 0.4, 0.8)
    love.graphics.rectangle('fill', 40, 400, love.graphics.getWidth() - 80, 160)

    love.graphics.setColor(1, 1, 1)
    love.graphics.print(self.currentDialogue.name, 60, 420)
    love.graphics.print(self.currentDialogue.line, 60, 440)
  end

  self.suit:draw()
end

function Chapter:mousepressed(mx, my, button)
  if self.currentDialogue ~= nil then
    self:nextDialogue()

  else
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
end

return Chapter