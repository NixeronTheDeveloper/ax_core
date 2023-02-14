ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(100)
    end
end)

function itemCount(item, metadata)
	if (Config.OxInventory) then
		return exports.ox_inventory:Search(2, item, metadata)
	else
		ESX.TriggerServerCallback('ax_core:itemCount', function(itemCount)
			while (itemCount == nil) do Citizen.Wait(100) end
			return itemCount
		end, item)
	end
end
