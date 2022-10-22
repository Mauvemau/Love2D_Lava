Collision = {}

local wallWidth = .05

function Collision:playerWall(player)
	return (player.pos.y <= (love.graphics.getHeight() * wallWidth) or (player.pos.y + player.size.tall) >= (love.graphics.getHeight() * (1 - (wallWidth * 2))))
end

function Collision:beakWall(beak)
	return (beak.pos.x <= (love.graphics.getWidth() * wallWidth) or (beak.pos.x + beak.size.wide) >= (love.graphics.getWidth() * (1 - (wallWidth))))
end