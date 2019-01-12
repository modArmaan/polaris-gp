--[[
			----------------------------------------------------------------------------------------------
			  ____   ___  _        _    ____  ___ ____      ____  _____ ______     _____ ____ _____ ____  
			 |  _ \ / _ \| |      / \  |  _ \|_ _/ ___|    / ___|| ____|  _ \ \   / /_ _/ ___| ____/ ___| 
			 | |_) | | | | |     / _ \ | |_) || |\___ \    \___ \|  _| | |_) \ \ / / | | |   |  _| \___ \ 
			 |  __/| |_| | |___ / ___ \|  _ < | | ___) |    ___) | |___|  _ < \ V /  | | |___| |___ ___) |
			 |_|    \___/|_____/_/   \_\_| \_\___|____/    |____/|_____|_| \_\ \_/  |___\____|_____|____/ 
                                                                                              			
			----------------------------------------------------------------------------------------------                                                                                    
	
	//                                    MANDATORY COPYRIGHT NOTICE									   //
	|-------------------------------------------------------------------------------------------------------|
	|	THIS SCRIPT IS PROPERTY OF POLARIS SERVICES.						|
	|	THE UNAUTHORISED MODIFICATION, ACCESS OR ATTEMPTED ABUSE OF THIS CONTENT IS STRICTLY PROHIBITED,	|
	|	AND ANY SUCH ACTION IS A VIOLATION OF THE TERMS OF SERVICE.											|
	|																										|
	|	ANY ATTEMPT TO COPY, STEAL OR DUPLICATE IS A VIOLATION OF COPYRIGHT LAW.							|
	|																										|
	|	POLARIS SERVICES IS AN ORGANISATION OWNED BY NEZTORE. CONTACT EMAIL: polaris@muir.xyz				|
	|																										|
	|	COPYRIGHT 2018 POLARIS SERVICES.																	|
	|-------------------------------------------------------------------------------------------------------|
	//																									   //
--]]


--[[
	Performs basic client setup, which is mainly loading ReplicatedPseudoInstance.
--]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Resources = require(ReplicatedStorage:WaitForChild("Resources"))

Resources:LoadLibrary("ReplicatedPseudoInstance")

local players = game:GetService("Players")
-- Hide built in GUIs
pcall(function()
	game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
	game:GetService("StarterGui"):SetCore("ResetButtonCallback", false)

end)
	wait(.2)
	
pcall(function()
	game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
	game:GetService("StarterGui"):SetCore("ResetButtonCallback", false)

end)
	local camera = workspace.CurrentCamera
	camera.CameraType = Enum.CameraType.Scriptable
	
	local target = players.LocalPlayer.Character:WaitForChild("Head")
	local angle = 0
	wait(1)
	target.Anchored = true
	while target ~= nil do
	wait()
    camera.CoordinateFrame = CFrame.new(target.Position)  --Start at the position of the part
                           * CFrame.Angles(0, angle, 0) --Rotate by the angle
                           * CFrame.new(0, 0, 8)       --Move the camera backwards 5 units
    angle = angle + math.rad(0.5)
end

local target
