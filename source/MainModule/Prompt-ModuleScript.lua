-- Require statements
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Resources = require(ReplicatedStorage:WaitForChild("Resources"))

local Color = Resources:LoadLibrary("Color")
local PseudoInstance = Resources:LoadLibrary("PseudoInstance")
local GroupService = game:GetService("GroupService")
local Misc = require(script.Parent.Misc)
Resources:LoadLibrary("ReplicatedPseudoInstance")

function getRank(ranks, rankId)
	for _, rank in ipairs(ranks) do
		if rank.Rank == rankId then
			return rank.Name
		end
	end	
end
function getRankFromName(ranks, rankName)
	for _, rank in ipairs(ranks) do
		if rank.Name == rankName then
			return rank.Rank
		end
	end	
end

return function (Player, groupId, ranks, callb)
	local GroupInfo = GroupService:GetGroupInfoAsync(groupId)
	local options = {}
	for i, v in ipairs(ranks) do
		local rankName = getRank(GroupInfo.Roles, v)
		if rankName then
			options[#options+1] = rankName
		else
			print("Failed to get name for rank "..v)
		end		
	end

local PrimaryColor3 = Color.Teal[500]
if #options == 0 then
	Misc:displayError(Player, "There are no ranks to give you. Check your subgroup ranks!", true) 
	return false
end

local Dialog = PseudoInstance.new("ChoiceDialog")
Dialog.HeaderText = "Select a rank"
Dialog.Options = options
Dialog.DismissText = "CANCEL"
Dialog.ConfirmText = "RANK"
Dialog.PrimaryColor3 = PrimaryColor3

Dialog.OnConfirmed:Connect(function(Player, Choice)

    if Choice then
        -- Choice is a string of the option they chose
		local rank = getRankFromName(GroupInfo.Roles, Choice)
		if not rank then 
			Misc:displayError(Player, "Invalid rank selection!", true) 
			print(Choice)
			Player:Kick("Invalid rank selection")
			
		else
			-- its valid
			return callb(rank, Choice)
			end
    else
		Misc:displayMessage(Player, "Cancelled ranking.", true) 
        Player:Kick("Rank selection cancel.")
		
    end
end)

Dialog.Parent = Player.PlayerGui
	end
	
	

