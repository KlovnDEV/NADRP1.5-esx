local inCasino = false
Citizen.CreateThread(function()
	local render_target = -1 -- render target
	local channel = 1 -- current channel
	local clean = false
	local channels = { -- channel list
		[1] = "CASINO_DIA_PL",
		[2] = "CASINO_HLW_PL",
		--[3] = "CASINO_WIN_PL"
	}

    local function CreateNamedRenderTargetForModel(name, model)
        local handle = 0
        if not IsNamedRendertargetRegistered(name) then
            RegisterNamedRendertarget(name, 0)
        end
        if not IsNamedRendertargetLinked(model) then
            LinkNamedRendertarget(model)
        end
        if IsNamedRendertargetRegistered(name) then
            handle = GetNamedRendertargetRenderId(name)
        end

        return handle
    end

	-- set tv channel
	local function ChangeChannel(int_channel)
		if int_channel > 0 then
			SetTvVolume(0.5) -- set the volume
			SetTvChannel(1) -- turn tv on
			N_0xf7b38b8305f1fe8b(1, channels[int_channel], 0) -- set station
			channel = int_channel -- retain current station
		else
			SetTvChannel(-1) -- turn tv off
		end
	end

	local function testChannel()
		local channel = math.random(2)
		ChangeChannel(channel)
		SetTimeout(math.random((1000 * 60) * 10), testChannel)
	end

	SetTimeout(math.random((1000 * 60) * 10), testChannel)

	local function cleanup()
		if not p_inside then return end -- cleanup when outside area
		ChangeChannel(0) -- turn off the tv
		render_target = CreateNamedRenderTargetForModel('CasinoScreen_01', 0)
		p_inside = false -- mark outside
		clean = true
	end

	local function init()
        if p_inside then return end -- init when inside area
        p_inside = true
		render_target = CreateNamedRenderTargetForModel('CasinoScreen_01', GetHashKey("vw_vwint01_video_overlay")) -- set tv as rendertarget
		ChangeChannel(channel) -- turn on the tv
		playBackgroundAudio()
		clean = false
	end

	function playBackgroundAudio()
		Citizen.CreateThread(function()
			local function audioBanks()
				while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_GENERAL", false, -1) do
					Citizen.Wait(0)
				end
				while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_01", false, -1) do
					Citizen.Wait(0)
				end
				while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_02", false, -1) do
					Citizen.Wait(0)
				end
				while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_03", false, -1) do
					Citizen.Wait(0)
				end
			end
			while inCasino do
				if not IsStreamPlaying() and LoadStream("casino_walla", "DLC_VW_Casino_Interior_Sounds") then
					PlayStreamFromPosition(1111, 230, -47)
				end
				if IsStreamPlaying() and not IsAudioSceneActive("DLC_VW_Casino_General") then
					StartAudioScene("DLC_VW_Casino_General")
				end
				Citizen.Wait(1000)
			end
			if IsStreamPlaying() then
				StopStream()
			end
			if IsAudioSceneActive("DLC_VW_Casino_General") then
				StopAudioScene("DLC_VW_Casino_General")
			end
		end)
	end

	while true do
        if inCasino then
            Citizen.Wait(0)
			if not p_inside then
				init()
			end
			if render_target ~= 1 then
				SetTextRenderId(render_target)
			end
			DrawTvChannel(0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
			SetTextRenderId(GetDefaultScriptRendertargetRenderId()) -- reset render context
		else
			if not clean then
				cleanup()
			end
			Citizen.Wait(1000)
		end
	end
end)

AddEventHandler("ffrp-casino:InCasino", function(toggle)
	inCasino = toggle
end)