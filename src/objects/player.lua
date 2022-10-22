
Player = {}

Player.pos = { x = 0, y = 0 }
Player.size = { wide = 0, tall = 0 }
Player.speed = { horizontal = 0.0, vertical = 0.0 }

-- Private

local function getBeak(player)
	local beak = { wide = (player.size.wide * .2), tall = (player.size.tall * .5)}
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
	if (player.speed.horizontal > 0) then
		love.graphics.rectangle("fill", (self.pos.x + self.size.wide), (self.pos.y + (beak.tall * .5)), beak.wide, beak.tall, 0)
	else
		love.graphics.rectangle("fill", (self.pos.x - beak.wide), (self.pos.y + (beak.tall * .5)), beak.wide, beak.tall, 0)
	end
end

function Player:update()
	
end

function Player:create()
	print("Creating player...")
	player = Player
	player.pos.x = (love.graphics.getWidth() * .5)
	player.pos.y = (love.graphics.getHeight() * .5)
	player.size.wide = (love.graphics.getHeight() * .05)
	player.size.tall = (love.graphics.getHeight() * .05)
	player.speed.horizontal = 1.0
	player.speed.vertical = 0.0
	centerPlayer(player)
	return player
end


