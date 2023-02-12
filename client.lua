ESX              = nil
local PlayerData = {}
local HasAlreadyGotMessage = false
local HasAlreadyGotMessage2 = false

ESX = exports["es_extended"]:getSharedObject()

Citizen.CreateThread(function()
    -- location is the cargoship
    local markerPos = vector3(1076.083496, -2880.870361, 20.653159)	
	-- location in the far back corner of the shop
	local markerPos2 = vector3(1066.562622, -2880.936279, 20.653159)
	

   while true do
	Citizen.Wait(1)
	local ped = GetPlayerPed(-1)
	local playerCoords = GetEntityCoords(ped)
	local distance = #(playerCoords - markerPos)
	local distance2 = #(playerCoords - markerPos2)
	
	local isInMarker = false	
	local isInMarker2 = false

	-- change ped to work uniform
		if distance < 5.0 then
		DrawMarker(27, markerPos.x, markerPos.y, markerPos.z , 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, .75, .75, .75, 255, 0, 0, 150, false, false, 2, nil, nil, false)
	    	if distance < 1.0 then
				isInMarker = true
			else
				HasAlreadyGotMessage = false
			end
			
			if isInMarker and not HasAlreadyGotMessage then
				HasAlreadyGotMessage = true
				-- Robber outfit
				SetPedComponentVariation(ped, 0, 5, 0, 0)  -- hat for robber
				-- get a random mask
				mask = math.random (1,4)
				if mask == 1 then
					mask = 35
				elseif mask == 2 then
					mask = 37
				elseif mask == 3 then
					mask = 52
				elseif mask == 4 then
					mask = 57
				end	
				SetPedComponentVariation(ped, 1, mask, 0, 0)  -- mask for robber
				SetPedComponentVariation(ped, 3, 31, 0, 0)   -- torso for robber
				-- get a random bag
				bag = math.random (1,2)
				if bag == 1 then
					bag = 81
				elseif bag == 2 then
					bag = 44
				end	
				SetPedComponentVariation(ped, 5, bag, 0, 0) -- bag
				-- get a random shoes
				shoes = math.random (1,3)
				if shoes == 1 then
					shoes = 24
				elseif shoes == 2 then
					shoes = 25
				elseif shoes == 3 then
					shoes = 27
				end
				SetPedComponentVariation(ped, 6, shoes, 0, 0)   -- shoes for robber
				SetPedComponentVariation(ped, 7, 0, 0, 0)   -- accessories for robber
				SetPedComponentVariation(ped, 8, 15, 0, 0)   -- Undershirt for robber
				SetPedComponentVariation(ped, 11, 89, 0, 0)  -- top for robber
					
				Citizen.Wait(500)
			end
		end
		
		
		-- change ped back 
		
		if distance2 < 5.0 then
		DrawMarker(27, markerPos2.x, markerPos2.y, markerPos2.z , 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, .75, .75, .75, 255, 255, 0, 150, false, false, 2, nil, nil, false)
	    	if distance2 < 1.0 then
			isInMarker2 = true
			else
			HasAlreadyGotMessage2 = false
			end
			
			if isInMarker2 and not HasAlreadyGotMessage2 then
				HasAlreadyGotMessage2 = true
						
				if PlayerData.sex == "m" then
					local isMale = true
				else
					local isMale = false
				end	
						
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				local isMale = skin.sex == 0
				TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
				TriggerEvent('esx:restoreLoadout')
				end)
				end)
				end)
			end
		end	
	end
end)