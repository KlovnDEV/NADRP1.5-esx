Citizen.CreateThread(function()
	while true do
        --This is the Application ID (Replace this with you own)
		SetDiscordAppId(844450270829346827)

        --Here you will have to put the image name for the "large" icon.
		SetDiscordRichPresenceAsset('ORP')

        --(11-11-2018) New Natives:

        --Here you can add hover text for the "large" icon.
        SetDiscordRichPresenceAssetText('Only RP')

        --Here you will have to put the image name for the "small" icon.
        SetDiscordRichPresenceAssetSmall('orp')

        --Here you can add hover text for the "small" icon.
        SetDiscordRichPresenceAssetSmallText('Only Rp')

        --It updates every one minute just in case.
		Citizen.Wait(60000)
	end
end)

local firstSpawn = true
AddEventHandler('playerSpawned', function()
    if firstSpawn then
        SetDiscordRichPresenceAction(0, "Website", "Comming soon")
        SetDiscordRichPresenceAction(1, "Connect", "Comming soon")
        firstSpawn = false
    end
end)