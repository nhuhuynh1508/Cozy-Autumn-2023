local Manager = Class('Manager')

function Manager:initialize(objects)
  self.objects = {{}}
  self.minLayer = 1
  self.maxLayer = 1

  for _, object in ipairs(objects) do
    self:add(object)
  end
end

function Manager:objectIter()
  local i = 0
  local l = self.minLayer
  return function()
    i = i + 1
    if i <= #self.objects[l] then
      return self.objects[l][i]
    else
      while l < self.maxLayer do
        l = l + 1
        if self.objects[l] ~= nil then
          if #self.objects[l] ~= 0 then
            i = 1
            return self.objects[l][i]
          end
        end
      end
    end
  end
end

function Manager:add(object)
  local l = object:getLayer()

  if self.objects[l] == nil then 
    self.objects[l] = {}

    if self.minLayer > l then self.minLayer = l end
    if self.maxLayer < l then self.maxLayer = l end
  end

  table.insert(self.objects[l], object)
end

function Manager:remove(object)
  for l = minLayer, maxLayer do
    if self.objects[l] then
      for i, object_ in ipairs(self.objects[l]) do
        if object == object_ then
          table.remove(self.objects[l], i)
          return true
        end
      end
      return false
    end
  end
end

function Manager:update(dt)
  for object in self:objectIter() do
    object:update(dt)
  end
end

function Manager:draw()
  for object in self:objectIter() do
    object:draw()
  end
end

function Manager:mousepressed(event)
  for object in self:objectIter() do
    object:mousepressed(event)
  end
end

--[[
function Manager:mousemoved(x, y)
  for _, object in ipairs(self.objects) do
    object:mousemoved(x, y)
  end
end

function Manager:mousereleased(x, y, button)
  for _, object in ipairs(self.objects) do
    object:mousereleased(x, y, button)
  end
end

function Manager:keypressed(key, scancode, isRepeat)
  for _, object in ipairs(self.objects) do
    object:keypressed(key, scancode, isRepeat)
  end
end

function Manager:keyreleased(key, scancode, isRepeat)
  for _, object in ipairs(self.objects) do
    object:keyreleased(key, scancode, isRepeat)
  end
end
]]--

return Manager