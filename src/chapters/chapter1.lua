local Chapter = require 'src.chapter'
local Object = require 'src.object'
local Collider = require 'src.collider'
local Clickable = require 'src.clickable'
local Inspectable = require 'src.inspectable'

local Chapter1 = Class('Chapter1', Chapter)

function Chapter1:enter(from)
  local objects = {
    Object(0, 0, Sprites.haley, 5),
    Object(100, 0, Sprites.emily, 1),
    Object(200, 0, Sprites.elliott, -1),

    Clickable(500, 0, Sprites.sebastian, 0,
        {Collider(0, 0, 256, 256), Collider(0, 256, 128, 128)},
        function()
          Gamestate.current():addDialogue('Sebastian', 'Quang tao cai bong..')
          Gamestate.current():addDialogue('Sebastian', 'Quang tao cai bong....')
          Gamestate.current():addDialogue('Sebastian', 'Quang tao cai bong......')
          Gamestate.current():addDialogue('Sebastian', 'Ta cung choi vong tron')
        end
    ),

    Inspectable(0, 300, Sprites.leah, 0,
        {Collider(0, 0, 256, 256)},
        {Object(200, 150, Sprites.alex, -4)},
        {Clickable(350, 150, Sprites.shane, -1,
            {Collider(0, 0, 256, 256)},
            function() Gamestate.current():addDialogue('Shane', 'C2H5OH please') end
        )}
    ),

    Clickable(500, 300, Sprites.abigail, 0,
        {Collider(0, 0, 256, 256)},
        function()
          Gamestate.current():switchScene(1)
        end
    ),

    Clickable(self:getSceneX(1) + 350, 200, Sprites.maru, 0,
        {Collider(0, 0, 256, 256)},
        function()
          print('hello baby girl')
          Gamestate.current():switchScene(0)
        end
    ),
  }

  local items = {}

  Chapter.enter(self, objects, items)
end

return Chapter1