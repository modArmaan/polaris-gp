-- Require statements
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Resources = require(ReplicatedStorage:WaitForChild("Resources"))
local module = {}

-- Libraries
local Color = Resources:LoadLibrary("Color")
local Enumeration = Resources:LoadLibrary("Enumeration")
local Tween = Resources:LoadLibrary("Tween")
local Snackbar = Resources:LoadLibrary("Snackbar")

-- Constants
local PrimaryColor3 = Color.Teal[500]
local SourceSansSemibold = Enum.Font.SourceSansSemibold.Value
local Code = Enum.Font.Code
local Align = Enum.TextXAlignment.Center

local ENTER_TIME = 150 / 1000 * 2
local InBack = Enumeration.EasingFunction.InBack.Value
local OutBack = Enumeration.EasingFunction.OutBack.Value

function module.make(loc)
		
	local LoadingScreen = Instance.new("ScreenGui")
		LoadingScreen.Name = "loadingScreen"
	
	local Frame = Instance.new("Frame")
		Frame.BackgroundTransparency = 1
		Frame.Size = UDim2.new(1, 0, 1, 0)
		Frame.Name = "Loading"
		Frame.Parent = LoadingScreen
	
	local UIScale = Instance.new("UIScale")
		UIScale.Scale = 0
		UIScale.Name = "UIScale"
		UIScale.Parent = Frame
	
	local Background = Instance.new("ImageLabel")
		Background.BackgroundTransparency = 1
		Background.ScaleType = Enum.ScaleType.Slice
		Background.SliceCenter = Rect.new(4, 4, 256 - 4, 256 - 4)
		Background.Image = "rbxassetid://1934624205"
		Background.Size = UDim2.new(0, 280, 0, 117)
		Background.Position = UDim2.new(0.5, 0, 0.5, 0)
		Background.AnchorPoint = Vector2.new(0.5, 0.5)
		Background.Name = "Background"
		Background.ZIndex = 2
		Background.Parent = Frame
	
	
	local Header = Instance.new("TextLabel")
		Header.Font = SourceSansSemibold
		Header.TextSize = 26
		Header.Size = UDim2.new(1, -48, 0, 64)
		Header.Position = UDim2.new(0, 24, 0.5, -64)
		Header.BackgroundTransparency = 1
		Header.TextXAlignment = Align
		Header.TextTransparency = 0.13
		Header.TextColor3 = Color.Black
		Header.Name = "Header"
		Header.ZIndex = 3
		Header.Text = "Loading"
		Header.Parent = Background
		LoadingScreen.Parent = loc
		
		local Sub = Instance.new("TextLabel")
		Sub.Font = Code
		Sub.TextSize = 13
		Sub.Size = UDim2.new(1, -24, 0, 16)
		Sub.Position = UDim2.new(0, 12, 0.5, -12)
		Sub.BackgroundTransparency = 1
		Sub.TextXAlignment = Align
		Sub.TextTransparency = 0.13
		Sub.TextColor3 = Color.Black
		Sub.Name = "Subtext"
		Sub.ZIndex = 3
		Sub.Text = "Loading"
		Sub.Parent = Background
		
		script.TextChanger:Clone().Parent = Sub
		LoadingScreen.Parent = loc
	
	module.ui = LoadingScreen
end

function module.show(loc)
	if (module.ui) then
		print("Already made ")
	else
		module.make(loc)
	end
	Tween(module.ui.Loading.UIScale, "Scale", 1, OutBack, ENTER_TIME, true)
	Snackbar.new("Polaris promotion centres: Alpha", module.ui)
	
end

function module.hide()
	if (module.ui) then
		Tween(module.ui.Loading.UIScale, "Scale", 0, OutBack, ENTER_TIME, true)
		module.ui:Destroy()
		module.ui = nil
	end
end
return module