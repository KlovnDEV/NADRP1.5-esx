-- Credits to rootcause
local safeZone = (1.0 - GetSafeZoneSize()) * 0.5
local timerBar = {
    baseX = 0.918,
    baseY = 0.984,
    baseWidth = 0.165,
    baseHeight = 0.035,
    baseGap = 0.038,
    titleX = 0.012,
    titleY = -0.009,
    textX = 0.0785,
    textY = -0.0165,
    progressX = 0.047,
    progressY = 0.0015,
    progressWidth = 0.0616,
    progressHeight = 0.0105,
    txtDict = "timerbars",
    txtName = "all_black_bg",
}

function DrawTimerProgressBar(idx, title, progress, titleColor, fgColor, bgColor, usePlayerStyle)
    local title = title or ""
    local titleColor = titleColor or { 255, 255, 255, 255 }
    local progress = progress or false
    local fgColor = fgColor or { 255, 255, 255, 255 }
    local bgColor = bgColor or { 255, 255, 255, 255 }
    local titleScale = usePlayerStyle and 0.465 or 0.3
    local titleFont = usePlayerStyle and 4 or 0
    local titleFontOffset = usePlayerStyle and 0.00625 or 0.0

    local yOffset = (timerBar.baseY - safeZone) - ((idx[1] or 0) * timerBar.baseGap)

    if not HasStreamedTextureDictLoaded(timerBar.txtDict) then
        RequestStreamedTextureDict(timerBar.txtDict, true)

        local t = GetGameTimer() + 5000
        
        repeat
            Citizen.Wait(0)
        until HasStreamedTextureDictLoaded(timerBar.txtDict) or (GetGameTimer() > t)
    end

    DrawSprite(timerBar.txtDict, timerBar.txtName, timerBar.baseX - safeZone, yOffset, timerBar.baseWidth, timerBar.baseHeight, 0.0, 255, 255, 255, 160)

    BeginTextCommandDisplayText("CELL_EMAIL_BCON")
    SetTextFont(titleFont)
    SetTextScale(titleScale, titleScale)
    SetTextColour(titleColor[1], titleColor[2], titleColor[3], titleColor[4])
    SetTextRightJustify(true)
    SetTextWrap(0.0, (timerBar.baseX - safeZone) + timerBar.titleX)
    AddTextComponentSubstringPlayerName(title)
    EndTextCommandDisplayText((timerBar.baseX - safeZone) + timerBar.titleX, yOffset + timerBar.titleY - titleFontOffset)

    local progress = (progress < 0.0) and 0.0 or ((progress > 1.0) and 1.0 or progress)
    local progressX = (timerBar.baseX - safeZone) + timerBar.progressX
    local progressY = yOffset + timerBar.progressY
    local progressWidth = timerBar.progressWidth * progress

    DrawRect(progressX, progressY, timerBar.progressWidth, timerBar.progressHeight, bgColor[1], bgColor[2], bgColor[3], bgColor[4])
    DrawRect((progressX - timerBar.progressWidth / 2) + progressWidth / 2, progressY, progressWidth, timerBar.progressHeight, fgColor[1], fgColor[2], fgColor[3], fgColor[4])

    if idx ~= nil then
        if idx[1] then
            idx[1] = idx[1] + 1
        end
    end
end

function DrawTimerBar(idx, title, text, titleColor, textColor, usePlayerStyle)
    local title = title or ""
    local text = text or ""
    local titleColor = titleColor or { 255, 255, 255, 255 }
    local textColor = textColor or { 255, 255, 255, 255 }
    local titleScale = usePlayerStyle and 0.465 or 0.3
    local titleFont = usePlayerStyle and 4 or 0
    local titleFontOffset = usePlayerStyle and 0.00625 or 0.0

    local yOffset = (timerBar.baseY - safeZone) - ((idx[1] or 0) * timerBar.baseGap)

    if not HasStreamedTextureDictLoaded(timerBar.txtDict) then
        RequestStreamedTextureDict(timerBar.txtDict, true)

        local t = GetGameTimer() + 5000
        
        repeat
            Citizen.Wait(0)
        until HasStreamedTextureDictLoaded(timerBar.txtDict) or (GetGameTimer() > t)
    end

    DrawSprite(timerBar.txtDict, timerBar.txtName, timerBar.baseX - safeZone, yOffset, timerBar.baseWidth, timerBar.baseHeight, 0.0, 255, 255, 255, 160)

    BeginTextCommandDisplayText("CELL_EMAIL_BCON")
    SetTextFont(titleFont)
    SetTextScale(titleScale, titleScale)
    SetTextColour(titleColor[1], titleColor[2], titleColor[3], titleColor[4])
    SetTextRightJustify(true)
    SetTextWrap(0.0, (timerBar.baseX - safeZone) + timerBar.titleX)
    AddTextComponentSubstringPlayerName(title)
    EndTextCommandDisplayText((timerBar.baseX - safeZone) + timerBar.titleX, yOffset + timerBar.titleY - titleFontOffset)

    BeginTextCommandDisplayText("CELL_EMAIL_BCON")
    SetTextFont(0)
    SetTextScale(0.425, 0.425)
    SetTextColour(textColor[1], textColor[2], textColor[3], textColor[4])
    SetTextRightJustify(true)
    SetTextWrap(0.0, (timerBar.baseX - safeZone) + timerBar.textX)
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText((timerBar.baseX - safeZone) + timerBar.textX, yOffset + timerBar.textY)

    if idx ~= nil then
        if idx[1] then
            idx[1] = idx[1] + 1
        end
    end
end

Citizen.CreateThread(function()
	exports["shrp-polyzone"]:AddBoxZone("blackJack", vector3(1148.46, 269.95, -51.84), 2.8, 4.2, {
        heading=51,
        --debugPoly=true,
        minZ= -52.84,
        maxZ= -50.44,
		data = {
		  id = "1",
		},
	})
	exports["shrp-polyzone"]:AddBoxZone("blackJack", vector3(1151.99, 266.4, -51.84), 2.6, 3.6, {
        heading=44,
        --debugPoly=true,
        minZ= -52.84,
        maxZ= -50.64,
		data = {
		  id = "2",
		},
	})
	exports["shrp-polyzone"]:AddBoxZone("blackJack", vector3(1146.58, 260.92, -51.84), 4.0, 2.6, { 
        heading=312,
        --debugPoly=true,
        minZ= -52.84,
        maxZ= -50.64,
		data = {
		  id = "3",
		},
	})
	exports["shrp-polyzone"]:AddBoxZone("blackJack", vector3(1143.11, 264.44, -51.84), 3.6, 2.8, {
		heading=315,
		--debugPoly=true,
		minZ= -53.04,
		maxZ= -49.84,
		data = {
		  id = "4",
		},
	})
    exports["shrp-polyzone"]:AddBoxZone("blackJack", vector3(1129.62, 262.56, -51.04), 2.6, 4.2,  {
        heading=310,
        --debugPoly=true,
        minZ= -52.84,
        maxZ= -49.64,
		data = {
		  id = "5",
		},
	})
    exports["shrp-polyzone"]:AddBoxZone("blackJack", vector3(1133.44, 266.61, -51.04), 4.2, 2.6, {
        heading=45,
        --debugPoly=true,
        minZ= -52.84,
        maxZ= -49.64,
		data = {
		  id = "6",
		},
	})
    exports["shrp-polyzone"]:AddBoxZone("blackJack", vector3(1148.66, 251.76, -51.04), 4.0, 2.6, {
        heading=35,
        --debugPoly=true,
        minZ= -52.84,
        maxZ= -49.64,
		data = {
		  id = "7",
		},
	})
    exports["shrp-polyzone"]:AddBoxZone("blackJack", vector3(1144.67, 247.74, -51.04), 4.2, 2.8, {
        heading=45,
        --debugPoly=true,
        minZ= -52.84,
        maxZ= -49.64,
		data = {
		  id = "8",
		},
	})
end)