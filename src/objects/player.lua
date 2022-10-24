require("src/collision_manager")

Player = {}

Player.pos = { x = 0, y = 0 }
Player.size = { wide = 0, tall = 0 }
Player.speed = { horizontal = 0.0, vertical = 0.0 }
Player.weight = 0
Player.impulse = 0

-- Private

local spriteBirdNormal = nil
local spriteBirdFlapping = nil

local function getBeak(player)
	local beak = {}
	beak.pos = {}
	beak.size = { wide = (player.size.wide * .2), tall = (player.size.tall * .5) }
	if (player.speed.horizontal > 0) then
		beak.pos.x = (player.pos.x + player.size.wide)
	else
		beak.pos.x = (player.pos.x - beak.size.wide)
	end
	beak.pos.y = (player.pos.y + (beak.size.tall * .5))
	
	return beak
end

local function centerPlayer(player)
	player.pos.x = player.pos.x - (player.size.wide * .5)
	player.pos.y = player.pos.y - (player.size.tall * .5) 
end

-- Public

function Player:fly()
	self.speed.vertical = -self.impulse
end

function Player:draw()
	local beak = getBeak(self)
	
	local posX = 0
	local sizeX = 0
	
	if (player.speed.horizontal > 0) then
		sizeX = -(self.size.wide * .07)
		posX = (self.pos.x + self.size.wide + beak.size.wide)
	else
		sizeX = self.size.wide * .07
		posX = (self.pos.x - beak.size.wide)
	end
	
	-- Sprite
	love.graphics.setColor(255, 255, 255, 1)
	if (spriteBirdNormal == nil) then return end
	if (self.speed.vertical < 0) then
		love.graphics.draw(spriteBirdFlapping, posX, self.pos.y, 0, sizeX, (self.size.tall * .07))
	else
		love.graphics.draw(spriteBirdNormal, posX, self.pos.y, 0, sizeX, (self.size.tall * .07))
	end

	--[[
	-- Collision
	-- Body
	love.graphics.setColor(255, 0, 0, .5)
	love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.wide, self.size.tall, 0)
	
	-- Beak
	love.graphics.setColor(255, 128, 0, .5)
	love.graphics.rectangle("fill", beak.pos.x, beak.pos.y, beak.size.wide, beak.size.tall, 0)
	]]
end

function Player:update(dt)
	if (Collision:beakWall(getBeak(self))) then
		self.speed.horizontal = -self.speed.horizontal
		Game:updateWall()
	end
	self.pos.x = self.pos.x + (self.speed.horizontal * dt)
	self.pos.y = self.pos.y + (self.speed.vertical * dt)
	
	if(not Collision:playerWallBottom(self)) then
		if(self.speed.vertical < self.weight) then
			self.speed.vertical = self.speed.vertical + (self.weight * dt)
		end
	else
		Game:endGame()
		local wallWidth = Game:getWallWidth()
		self.pos.y = ((love.graphics.getHeight() * (1 - wallWidth)) - self.size.tall)
		self.speed.vertical = 0.0
	end
	
	if(Collision:playerWallTop(self)) then
		Game:endGame()
		local wallWidth = Game:getWallWidth()
		self.pos.y = wallWidth + self.size.tall
		self.speed.vertical = 0.0
	end
end

function Player:create()
	print("Creating player...")
	player = Player
	player.pos.x = (love.graphics.getWidth() * .5)
	player.pos.y = (love.graphics.getHeight() * .5)
	player.size.wide = (love.graphics.getHeight() * .05)
	player.size.tall = (love.graphics.getHeight() * .05)
	player.speed.horizontal = 350.0
	player.speed.vertical = 0.0
	player.weight = 800.0
	player.impulse = 500.0
	centerPlayer(player)
	
	spriteBirdNormal = love.graphics.newImage("resources/bird_normal.png")
	spriteBirdFlapping = love.graphics.newImage("resources/bird_flapping.png")
	
	return player
end


