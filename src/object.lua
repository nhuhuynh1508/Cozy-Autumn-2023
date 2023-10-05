local Object = Class('Object')

function Object:initialize(x, y, sprite, layer, w, h)
  self.x, self.y = x or 0, y or 100

  self.sprite = sprite
  self.layer = layer or 0

  self.w, self.h = w or 50, h or 50

  self.manager = nil
end

function Object:setLayer(layer)
  if self.manager then
    print('change layers please cpu god')
  end
end

function Object:getLayer()
  return self.layer
end

function Object:update(dt)

end

function Object:draw()
  if self.sprite ~= nil then
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.sprite, self.x, self.y, 0, 2, 2)
  end
end

function Object:mousepressed(mx, my, button)

end

function Object:mousemoved(mx, my)

end

function Object:mousereleased(mx, my, button)

end

return Object