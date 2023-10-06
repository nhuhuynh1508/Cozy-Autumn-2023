local Chapter = require 'src.chapter'
local Object = require 'src.object'
local Collider = require 'src.collider'
local Clickable = require 'src.clickable'
local Inspectable = require 'src.inspectable'
local Item = require 'src.item'

local Chapter1 = Class('Chapter1', Chapter)

function Chapter1:enter(from)
  local backgrounds = {
    [0] = Sprites.chapter1.backgrounds.A,
    [1] = Sprites.chapter1.backgrounds.B,
  }

  local objects = {
    Object(0, 492, Sprites.chapter1.ui.inv, 1),

    Clickable(135, 285, Sprites.MoonFairy, 0, 50, 50,
        {Collider(0, 0, 30, 42)},
        function()
          Gamestate.current():addDialogue('Moon Fairy', 'I have been waiting for you, the chosen one.')
          Gamestate.current():addDialogue('Moon Fairy', 'I am Moon Fairy, the guardian of the moon.')
          Gamestate.current():addDialogue('Moon Fairy', 'The Mid-Autumn Festival is in danger, as the Moon Stone has been stolen by the evil forces, and without it, the moon can not shine to its fullest.')
          Gamestate.current():addDialogue('Moon Fairy', 'I will be your guardian on this journey, but first you have to do for me a favor. Fix my wings, and I will guide you to the Moon Stone.')
        end
    ),

    Clickable(200, 400, Sprites.Mei, 0, 100, 100,
        {Collider(0, 0, 50, 50)},
        function()
          Gamestate.current():addDialogue('Mei', 'Without the full moon, the Mid-Autumn Festival will be ruined. I must do something.')
          Gamestate.current():addDialogue('Mei', 'I must save the Moon Fairy, and then take the Moon Stone back.')
        end
    ),

    -- Inspectable(0, 300, Sprites.leah, 0,
    --     {Collider(0, 0, 256, 256)},
    --     {Object(200, 150, Sprites.alex, -4)},
    --     {Clickable(350, 150, Sprites.shane, -1,
    --         {Collider(0, 0, 256, 256)},
    --         function() Gamestate.current():addItem(Item('C2H5OH', Sprites.harvey)) end
    --     )}
    -- ),

    Clickable(670, 180, Sprites.door, 0, 100, 100,
        {Collider(0, 0, 100, 170)},
        function()
          Gamestate.current():switchScene(1)
        end
    ),

    Clickable(self:getSceneX(1) + 132, 120, nil, 0, 0, 0,
        {Collider(0, 0, 100, 170)},
        function()
          Gamestate.current():switchScene(2)
        end
    ),
  }

  local items = {}

  Chapter.enter(self, backgrounds, objects, items)

  print(self.camera.x)
end

return Chapter1