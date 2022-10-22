require("src/hud")
require("src/objects/player")
require("src/objects/spike")

Game = {}

-- Private
local wallWidth = .05
local started

local player

local function manageInput()
	
end

-- Public

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
	-- Input
	manageInput()
	
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