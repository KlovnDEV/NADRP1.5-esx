local density = 0.4

Citizen.CreateThread(function()
  while true do
    SetParkedVehicleDensityMultiplierThisFrame(density)
    SetVehicleDensityMultiplierThisFrame(density)
    SetRandomVehicleDensityMultiplierThisFrame(density)
    SetPedDensityMultiplierThisFrame(density)
    SetScenarioPedDensityMultiplierThisFrame(density, density)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('ffrp-density:SetPedDensity')
AddEventHandler('ffrp-density:SetPedDensity', function(newDensity)
  density = newDensity
end)