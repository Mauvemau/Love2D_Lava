require("src/hud")
require("src/objects/player")
require("src/objects/spike")

Game = {}

-- Private
local wallWidth = .05
local started

local player

function love.mousepressed(x, y, button, isTouch)
	if (button == 1 or button == 2) then
		if (not started) then started = true end
		player:fly()
	end
end

function love.keypressed(key)
	if (key == "space") then
		if (not started) then started = true end
		player:fly()
	end
end

function love.touchpressed()
	if (not started) then started = true end
	player:fly()
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
	if(started) then
		player:update(dt)
	end
	
	-- Hud
	Hud:update()
end

function Game:init()
	print("Initializing Game...")
	love.graphics.setDefaultFilter("nearest")
	love.graphics.setBackgroundColor( 255, 255, 255, 1)
	
	started = false
	
	player = Player:create()
	
	Hud:init()
end