
Hud = {}

-- Private

-- Public

function Hud:draw()
	love.graphics.setColor(255, 255, 255, 1)
	if (not Game:getHasStarted()) then
		love.graphics.print("Avoid touching the lava on the walls.", love.graphics.getWidth() * .2, love.graphics.getHeight() * .25, 0, 1.5, 1.5)
		love.graphics.print("Touch the green blocks for triple points!", love.graphics.getWidth() * .23, love.graphics.getHeight() * .3, 0, 1.25, 1.25)
		love.graphics.print("(Tap the screen to start)", love.graphics.getWidth() * .24, love.graphics.getHeight() * .65, 0, 2, 2)
	elseif (Game:getHasEnded()) then
		love.graphics.print("Game Over", love.graphics.getWidth() * .31, love.graphics.getHeight() * .25, 0, 3, 3)
		love.graphics.print("Your score is ".. Game:getCurrentLevel() .."!", love.graphics.getWidth() * .38, love.graphics.getHeight() * .35, 0, 1.5, 1.5)
		love.graphics.print("(Tap the screen to restart)", love.graphics.getWidth() * .2, love.graphics.getHeight() * .65, 0, 2, 2)
	else
		love.graphics.print(Game:getCurrentLevel(), love.graphics.getWidth() * .475, love.graphics.getHeight() * .25, 0, 3, 3)
	end
end

function Hud:init()
	local font = love.graphics.newFont(18)
	font:setFilter("linear", "nearest")
	
	love.graphics.setFont(font)
end
