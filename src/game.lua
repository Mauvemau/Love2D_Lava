require("src/hud")
require("src/objects/player")
require("src/objects/spike")

Game = {}

-- Private
local wallWidth = .05
local started

local player

function love.mousepressed(x, y, button, isTouch)
	if(button == 1 or button == 2) then
		player:fly()
	end
end

-- Public

function Game:getPlayer()
	return player
end

function Game:getWallWidth()
	return wallWidth
end

function Game:draw()
	-- Walls
	love.graphics.setColor(0, 0, 0, 1)
	love.graphics.rectangle("fill", (love.graphics.getWidth() * wallWidth), (love.graphics.getHeight() * wallWidth), (love.graphics.getWidth() * (1 - (wallWidth * 2))), (love.graphics.getHeight() * (1 - (wallWidth * 2))), 0)
	
	-- Player
	player:draw()
	
	-- Hud
	Hud:draw()
end

function Game:update(dt)
	-- Player
	player:update(dt)
	
	-- Hud
	Hud:update()
end

function Game:init()
	print("Initializing Game...")
	love.graphics.setBackgroundColor( 255, 255, 255, 1)
	
	started = false
	
	player = Player:create()
	
	Hud:init()
end