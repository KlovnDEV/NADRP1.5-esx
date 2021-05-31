local cinema = false
RegisterCommand("hudbars", function()
	cinema = not cinema
	if cinema then
		SendNUIMessage({
			action = "cinema"
		})
	else 
		SendNUIMessage({
			action = "close"
		})
	end
end)