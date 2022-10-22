require("src/collision_manager")

Player = {}

Player.pos = { x = 0, y = 0 }
Player.size = { wide = 0, tall = 0 }
Player.speed = { horizontal = 0.0, vertical = 0.0 }
Player.weight = 0
Player.impulse = 0

-- Private

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

function Player:draw()
	-- Body
	love.graphics.setColor(255, 0, 0, .5)
	love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.wide, self.size.tall, 0)
	
	-- Beak
	local beak = getBeak(self)
	love.graphics.setColor(255, 128, 0, .5)
	love.graphics.rectangle("fill", beak.pos.x, beak.pos.y, beak.size.wide, beak.size.tall, 0)
end

function Player:update(dt)
	if (Collision:beakWall(getBeak(self))) then
		self.speed.horizontal = -self.speed.horizontal
	end
	self.pos.x = self.pos.x + (self.speed.horizontal * dt)
	self.pos.y = self.pos.y + (self.speed.vertical * dt)
	
	if(not Collision:playerWallBottom(self)) then
		--if(self.speed.vertical > -(self.weight * 100)) then
			self.speed.vertical = self.speed.vertical + (self.weight * dt)
		--end
	else
		local wallWidth = Game:getWallWidth()
		self.pos.y = ((love.graphics.getHeight() * (1 - wallWidth)) - self.size.tall)
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
	player.speed.horizontal = 300.0
	player.speed.vertical = 0.0
	player.weight = 600.0
	player.impulse = 600.0
	centerPlayer(player)
	return player
end


