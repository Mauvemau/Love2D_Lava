require("src/hud")
require("src/objects/player")
require("src/objects/spike")

Game = {}

-- Private
local started

local player

local function manageInput()
	
end

-- Public

function Game:draw()
	
	-- Player
	player:draw()
	
	-- Hud
	Hud:draw()
end

function Game:update()
	-- Input
	manageInput()
	
	-- Player
	player:update()
	
	-- Hud
	Hud:update()
end

function Game:init()
	print("Initializing Game...")
	started = false
	
	player = Player:create()
	
	Hud:init()
end