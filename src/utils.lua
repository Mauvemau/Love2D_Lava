
Utils = {}

function Utils:isEven(num)
	return (num % 2 == 0)
end

function Utils:getUniqueInterger(min, max, existing) -- Existing debe ser una tabla
	local num = math.random(min, max)
	for index, value in pairs(existing) do
		if (existing[index] == num) then
			num = self:getUniqueInterger(min, max, existing) 
		end
	end
	return num
end

function Utils:generateUniqueRandomIntergers(min, max, amount) -- Genera una tabla de ints sin repetir, amount indicando la cantidad de ints que queremos usar.
	local nums = {}
	for i = 0, amount, 1 do
		local num = self:getUniqueInterger(min, max, nums)
		nums[i] = num
	end 
	return nums
end
