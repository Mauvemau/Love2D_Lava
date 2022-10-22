Collision = {}

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