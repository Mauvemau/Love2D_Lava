require("src/hud")
require("src/objects/player")
require("src/objects/spike")
require("src/utils")

Game = {}

-- Private
local wallWidth = .05
local started
local currentLevel

local player

local wall = {}
local maxSpikes = 10

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

local function resetWall()
	for i = 0, maxSpikes, 1 do
		wall[i] = false
	end
end

local function createWall(amountSpikes)
	resetWall()
	if(amountSpikes > maxSpikes) then return end
	local spikes = {}
	spikes = Utils:generateUniqueRandomIntergers(0, maxSpikes, amountSpikes)
	print("---")
	for index, value in pairs(spikes) do
		print(value)
		wall[value] = true
	end
end

-- Public

function Game:updateWall()
	if (currentLevel == 0) then
		resetWall()
	end
	if (currentLevel > 0 and currentLevel <= 5) then
		createWall(2)
	end
	if (currentLevel > 5 and currentLevel <= 10) then
		createWall(4)
	end
	if (currentLevel > 10 and currentLevel <= 20) then
		createWall(6)
	end
	if (currentLevel > 20) then
		createWall(8)
	end
	currentLevel = currentLevel + 1
end

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
	currentLevel = 0
	
	player = Player:create()
	
	Hud:init()
end