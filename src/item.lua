local Item = Class('Item')

function Item:initialize(name, sprite)
  self.name = names
  self.sprite = sprite
end

function Item:draw(x, y)
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(self.sprite, x, y, 0, 4, 4)
end

return Item