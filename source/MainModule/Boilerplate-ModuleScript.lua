-- NOT FOR USE. JUST TO MAKE DEV EASIER.

local Class = {}
Class.__index = Class

function Class.new()
	local newClass = {}
    setmetatable(newClass, Class)
	
	-- Set properties from args

    return newClass
end

function Class:method()
	
end