local Manager = require 'src.manager'

local Chapter = Class('Chapter')

local WIDTH, HEIGHT = love.graphics.getDimensions()
local itemSize = 64
local spacing = 16

function Chapter:enter(backgrounds, objects, items)
  self.backgrounds = backgrounds or {}
  self._currentScene = 0
  self.camera = Camera.new()
  self:switchScene(self._currentScene)

  self.objects = Manager(objects)
  self.inspectedObject = nil

  self.items = items or {}
  self.selectedItemIndex = nil

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

function Chapter:getCurrentScene()
  return self._currentScene
end

function Chapter:getSceneX(scene)
  local sign = 0
  return scene * (WIDTH + 200)
end

function Chapter:switchScene(scene)
  self._currentScene = scene
  self.camera:lookAt(self:getSceneX(self._currentScene) + WIDTH/2, HEIGHT / 2)
end

function Chapter:addItem(item)
  table.insert(self.items, item)
end

function Chapter:removeItem(name)
  for i, item in ipairs(self.items) do
    if name == item.name then
      table.remove(self.items, i)
      break
    end
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
  if self.backgrounds[self._currentScene] then
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.backgrounds[self._currentScene], 0, 0, 0, 4, 4)
  end

  self.camera:attach()

  self.objects:draw()

  love.graphics.setColor(1, 1, 1)

  if self.inspectedObject then
    love.graphics.setColor(0, 0, 0, 0.4)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setColor(1, 1, 1)

    self.inspectedObject:inspectDraw()
  end

  if self.currentDialogue then
    love.graphics.setColor(0.4, 0.4, 0.4, 0.8)
    love.graphics.rectangle('fill', 30, 400, love.graphics.getWidth() - 70, 85)

    font1 = love.graphics.newFont('assets/font/DejaVuSerif.ttf', 14)
    font2 = love.graphics.newFont('assets/font/DejaVuSerif-Bold.ttf', 14)

    love.graphics.setColor(0, 0, 0)
    love.graphics.print(self.currentDialogue.name, font2, 60, 415)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(self.currentDialogue.line, font1, 60, 435, love.graphics.getWidth() - 100, 'left')
  end

  self.camera:detach()

  self.suit:draw()

  love.graphics.print(tostring(self._currentScene))
  local x, y = self.camera:position()
  love.graphics.print(string.format('x = %d  y = %d', x, y), 0, 15)

  -- Drawing items
  -- love.graphics.setColor(31/255, 16/255, 42/255)
  -- love.graphics.rectangle('fill', 0, HEIGHT - 96, WIDTH, HEIGHT)
  for i = 1, #self.items do
    local x = WIDTH/2 - itemSize/2 - (#self.items-1) * (itemSize + spacing) / 2 + (i-1) * (itemSize + spacing)

    if self.selectedItemIndex == i then love.graphics.setColor(0.7, 0.7, 0.7)
    else love.graphics.setColor(1, 1, 1)
    end
    love.graphics.draw(self.items[i].sprite, x, 460, 0, 2, 2)
    -- love.graphics.rectangle('fill', x, 460, itemSize, itemSize)
  end
end

function Chapter:mousepressed(mx, my, button)
  if my > HEIGHT - 96 then
    for i = 1, #self.items do
      local x = WIDTH/2 - itemSize/2 - (#self.items-1) * (itemSize + spacing) / 2 + (i-1) * (itemSize + spacing)
      local y = 460

      if x < mx and mx < x + itemSize and
          y < my and my < y + itemSize then
        if self.selectedItemIndex == i then
          self.selectedItemIndex = nil
        else
          self.selectedItemIndex = i
        end
      end
    end

  else  
    if self.currentDialogue ~= nil then
      self:nextDialogue()

    else
      local mcx, mcy = self.camera:mousePosition()

      local event = {
        mx = mcx, my = mcy,
        button = button, resolved = false
      }
    
      if self.inspectedObject then
        self.inspectedObject:inspectMousepressed(event)
      else
        self.objects:mousepressed(event)
      end  
    end
  end
end

return Chapter