require("src/program_manager")

function love.draw()
	Program:draw()
end

function love.update(dt)
	Program:update(dt)
end

function love.load()
	print("Starting App...")
	Program:init()
end