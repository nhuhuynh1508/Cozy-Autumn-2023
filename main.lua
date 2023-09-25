require 'globals'
require 'assets'

Chapter1 = require 'src.chapters.chapter1'

function love.load()
  Gamestate.registerEvents()
  Gamestate.switch(Chapter1)
end

function love.update(dt)

end

function love.draw()

end