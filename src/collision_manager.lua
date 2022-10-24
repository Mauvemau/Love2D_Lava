Collision = {}

local function beakLava(beak, lPosY, lHeight)
	return (beak.pos.y < (lPosY + lHeight) and beak.pos.y > lPosY or (beak.pos.y + beak.size.tall) > lPosY and (beak.pos.y + beak.size.tall) < (lPosY + lHeight))
end

function Collision:beakLava(beak)
	local offset = Game:getWallWidth()
	local width = love.graphics.getWidth() * (1 - (offset * 2))
	local lavaWidth = width / 11
	local wall = Game:getWall()
	for index, value in pairs(wall) do
		if (value) then
			local posY = (love.graphics.getHeight() * offset) + (lavaWidth * index)
			if (beakLava(beak, posY, lavaWidth)) then return true end
		end
	end
	return false
end

function Collision:beakLuckyBlock(beak)
	local luckyBlock = Game:getLuckyBlock()
	if ( luckyBlock == nil ) then return false end
	local offset = Game:getWallWidth()
	local width = love.graphics.getWidth() * (1 - (offset * 2))
	local lavaWidth = width / 11
	local posY = (love.graphics.getHeight() * offset) + (lavaWidth * luckyBlock)
	return (beakLava(beak, posY, lavaWidth))
end

function Collision:playerWallBottom(player)
	local wallWidth = Game:getWallWidth()
	return ((player.pos.y + player.size.tall) >= (love.graphics.getHeight() * (1 - wallWidth)))
end

function Collision:playerWallTop(player)
	local wallWidth = Game:getWallWidth()
	return (player.pos.y <= (love.graphics.getHeight() * wallWidth))
end

function Collision:beakWall(beak)
	local wallWidth = Game:getWallWidth()
	return (beak.pos.x <= (love.graphics.getWidth() * wallWidth) or (beak.pos.x + beak.size.wide) >= (love.graphics.getWidth() * (1 - wallWidth)))
end