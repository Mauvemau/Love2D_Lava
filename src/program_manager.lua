require("src/game")

-- De momento el juego va a tener solo 1 pantalla, pero en caso de que mas tarde quiera agregar mas, esta este codigo.

Program = {}

Program.Status = {
	INGAME = {id = 1, name = "Game"}
}

Program.currentStatus = {}

-- Private

local function drawRespectiveStatus(status)
	if(status.id == Program.Status.INGAME.id) then
		Game:draw()
	end
end

local function updateRespectiveStatus(status, dt)
	if(status.id == Program.Status.INGAME.id) then
		Game:update(dt)
	end
end

local function initRespectiveStatus(status)
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
	updateRespectiveStatus(self.currentStatus, dt)
end

function Program:init()
	print("Initializing Program...")
	self:setStatus(self.Status.INGAME)
end


