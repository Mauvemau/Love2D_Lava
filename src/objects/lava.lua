
Lava = {}

-- Private

-- Public

function Lava:draw(wall)
	if (not Game:getHasStarted()) then return end
	love.graphics.setColor(255, 0, 0, .75)
	local offset = Game:getWallWidth()
	local width = love.graphics.getWidth() * (1 - (offset * 2))
	local lavaWidth = width / 11
	
	love.graphics.rectangle("fill", (love.graphics.getWidth() * offset), 0, width, (love.graphics.getHeight() * offset))
	love.graphics.rectangle("fill", (love.graphics.getWidth() * offset), (love.graphics.getHeight() * offset) + width, width, (love.graphics.getHeight() * offset))
	
	for index, value in pairs(wall) do
		if (value) then
			if(Utils:isEven(Game:getCurrentLevel())) then
				love.graphics.rectangle("fill", (love.graphics.getWidth() * offset) + width, (love.graphics.getHeight() * offset) + (lavaWidth * index), (love.graphics.getWidth() * offset), lavaWidth)
			else
				love.graphics.rectangle("fill", 0, (love.graphics.getHeight() * offset) + (lavaWidth * index), (love.graphics.getWidth() * offset), lavaWidth)
			end
		end
	end
	
	love.graphics.setColor(255, 255, 255, 1)
	if ( Game:getLuckyBlock() == nil ) then return end
	love.graphics.setColor(0, 255, 0, .75)
	
	if(Utils:isEven(Game:getCurrentLevel())) then
		love.graphics.rectangle("fill", (love.graphics.getWidth() * offset) + width, (love.graphics.getHeight() * offset) + (lavaWidth * Game:getLuckyBlock()), (love.graphics.getWidth() * offset), lavaWidth)
	else
		love.graphics.rectangle("fill", 0, (love.graphics.getHeight() * offset) + (lavaWidth * Game:getLuckyBlock()), (love.graphics.getWidth() * offset), lavaWidth)
	end
	
	love.graphics.setColor(255, 255, 255, 1)
end
