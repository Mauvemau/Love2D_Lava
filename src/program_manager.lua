require("src/game")
require("src/main_menu")

Program = {}

Program.Status = {
	MAINMENU = {id = 0, name = "Main Menu"},
	INGAME = {id = 1, name = "Game"}
}

Program.currentStatus = {}

-- Private

local function drawRespectiveStatus(status)
	if(status.id == Program.Status.MAINMENU.id) then
		MainMenu:draw()
	end
	if(status.id == Program.Status.INGAME.id) then
		Game:draw()
	end
end

local function updateRespectiveStatus(status)
	if(status.id == Program.Status.MAINMENU.id) then
		MainMenu:draw()
	end
	if(status.id == Program.Status.INGAME.id) then
		Game:draw()
	end
end

local function initRespectiveStatus(status)
	if (status.id == Program.Status.MAINMENU.id) then
		MainMenu:init()
	end
	if (status.id == Program.Status.INGAME.id) then
		Game:init()
	end
end

-- Public

function Program:setStatus(status)
	local id = status.id or nil
	if(id == nil)then print("Program status is invalid!") return end
	print("Changing program status to [".. status.id .."]".. status.name)
	initRespectiveStatus(status)
	self.currentStatus = status
end

--

function Program:draw()
	local id = self.currentStatus.id or nil
	if(id == nil)then return end
	drawRespectiveStatus(self.currentStatus)
end

function Program:update(dt)
	local id = self.currentStatus.id or nil
	if(id == nil)then return end -- Verificamos que el status del juego este seteado antes de updatear.
	updateRespectiveStatus(self.currentStatus)
end

function Program:init()
	print("Initializing Program...")
	self:setStatus(self.Status.INGAME)
end


