return function (plr, settings)
	-- Returns table of ranks to give
	local mainId = settings.mainGroupId
	if not mainId then
		warn("Group id is invalid!")
		return false;
	end
	local promoRanks = {}
	print(promoRanks)
	for groupId, groupOpt in pairs(settings.subgroups) do
		if plr:IsInGroup(groupId) then
			for subRank, mainRanks in pairs(groupOpt) do
  				if plr:GetRankInGroup(groupId) == subRank then
					for i, mr in ipairs(mainRanks) do
						table.insert(promoRanks, mr)
					end
				end
			  			
			end
    	end
	end
	if settings.baseRank and  settings.baseRank > 0 then
		local r = plr:GetRankInGroup(mainId)
		if r < settings.baseRank then
			table.insert(promoRanks, settings.baseRank)
		end
	end
	return promoRanks
end
	
