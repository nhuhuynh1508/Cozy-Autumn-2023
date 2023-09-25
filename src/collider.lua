local Collider = Class('Collider')

function Collider:initialize(x, y, w, h)
  self.object = nil

  self.x, self.y = x or 0, y or 0
  self.w, self.h = w or 50, h or 50
end

function Collider:setObject(o)
  self.object = o
end

function Collider:containsPoint(px, py)
  assert(self.object, 'collider is not attached to an object')
  return self.object.x + self.x < px and px < self.object.x + self.x + self.w and
      self.object.y + self.y < py and py < self.object.y + self.y + self.h
end

return Collider