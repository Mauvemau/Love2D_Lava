require("src/hud")
require("src/objects/player")
require("src/objects/lava")
require("src/utils")

Game = {}

-- Private
local wallWidth = .05

local started
local ended
local currentLevel

local player

local maxLava = 10
local wall = {}
local luckyBlock

local function manageInput()
	if (not started) then started = true end
	if (started and not ended) then player:fly() end
	if (ended) then Game:restart() end
end

function love.mousepressed(x, y, button, isTouch)
	if (button == 1 or button == 2) then
		manageInput()
	end
end

function love.keypressed(key)
	if (key == "space") then
		manageInput()
	end
end

function love.touchpressed()
	manageInput()
end

local function resetWall()
	for i = 0, maxLava, 1 do
		wall[i] = false
	end
	luckyBlock = nil
end

local function createWall(amountLava)
	resetWall()
	if(amountLava > maxLava) then return end
	local lava = {}
	lava = Utils:generateUniqueRandomIntergers(0, maxLava, amountLava - 1)
	print("---")
	for index, value in pairs(lava) do
		print(value)
		wall[value] = true
	end
	luckyBlock = Utils:getUniqueInterger(0, maxLava, lava)
end

-- Public

function Game:addPoints(amount)
	currentLevel = currentLevel + amount
end

function Game:restart()
	self:init()
end

function Game:endGame()
	ended = true;
end

function Game:getHasEnded()
	return ended
end

function Game:getHasStarted()
	return started
end

function Game:getCurrentLevel()
	return currentLevel
end

function Game:getLuckyBlock()
	return luckyBlock
end

function Game:getWall()
	return wall
end

function Game:getPlayer()
	return player
end

function Game:updateWall()
	if (currentLevel <= 5) then
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

function Game:getWallWidth()
	return wallWidth
end

function Game:draw()
	-- Walls
	love.graphics.setColor(0, 0, 0, 1)
	love.graphics.rectangle("fill", (love.graphics.getWidth() * wallWidth), (love.graphics.getHeight() * wallWidth), (love.graphics.getWidth() * (1 - (wallWidth * 2))), (love.graphics.getHeight() * (1 - (wallWidth * 2))), 0)
	
	-- Hud
	Hud:draw()
	
	-- Lava
	Lava:draw(wall)
	
	-- Player
	player:draw()
end

function Game:update(dt)
	if (not started or ended) then return end
	-- Player
		player:update(dt)
end

function Game:init()
	print("Initializing Game...")
	
	love.graphics.setDefaultFilter("nearest")
	love.graphics.setBackgroundColor( 255, 255, 255, 1)
	
	started = false
	ended = false
	currentLevel = 0
	
	player = Player:create()
	resetWall()
	
	Hud:init()
end