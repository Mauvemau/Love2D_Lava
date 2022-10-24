
Lava = {}

-- Private

-- Public

function Lava:draw(spikes)
	if (not Game:getHasStarted()) then return end
	love.graphics.setColor(255, 0, 0, .75)
	local offset = Game:getWallWidth()
	local width = love.graphics.getWidth() * (1 - (offset * 2))
	local spikeWidth = width / 11
	
	love.graphics.rectangle("fill", (love.graphics.getWidth() * offset), 0, width, (love.graphics.getHeight() * offset))
	love.graphics.rectangle("fill", (love.graphics.getWidth() * offset), (love.graphics.getHeight() * offset) + width, width, (love.graphics.getHeight() * offset))
	
	for index, value in pairs(spikes) do
		if (value) then
			if(Utils:isEven(Game:getCurrentLevel())) then
				love.graphics.rectangle("fill", (love.graphics.getWidth() * offset) + width, (love.graphics.getHeight() * offset) + (spikeWidth * index), (love.graphics.getWidth() * offset), spikeWidth)
			else
				love.graphics.rectangle("fill", 0, (love.graphics.getHeight() * offset) + (spikeWidth * index), (love.graphics.getWidth() * offset), spikeWidth)
			end
		end
	end
end
