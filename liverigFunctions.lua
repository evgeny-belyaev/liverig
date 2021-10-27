local m = {}

local sCabinetTrackName = "Cabinet"
local sPreCabinetTrackName = "Pre Cab"
local sCleanChannelTrackName = "clean"
local sGuitarInputTrackName = "Gt Input"

local MESA_TRIPPLE_RECTIFIER_CH1 = 1
local MESA_TRIPPLE_RECTIFIER_CH2 = 0.3
local MESA_TRIPPLE_RECTIFIER_CH3 = 0.0

local FX_PARAM_BYPASS_ON = 100
local FX_PARAM_BYPASS_OFF = 0

-- Project

function m.getCurrentProjectFileName()
    local _, fileName = reaper.EnumProjects(-1, '')
    return fileName    
end

function m.setCurrentProjectBpm(nBpm)
    local _, project = reaper.EnumProjects(-1, '')
    reaper.SetCurrentBPM(project, nBpm, true)
end

function m.isLiveRigProject()
    local name = m.getCurrentProjectFileName()

    return string.find(name, "_live.rpp")
end

-- if (not m.isLiveRigProject()) then
    -- error("Wrong project!")
-- end

-- Tracks

function m.muteTrack(oTrack, bMute)
    reaper.SetMediaTrackInfo_Value(oTrack, 'B_MUTE', bMute and 1 or 0 )
end

function m.muteAllTracks(bMute)
    for trackIndex = 0, reaper.CountTracks(0) - 1 do
        local track = reaper.GetTrack(0, trackIndex)

        m.muteTrack(track, bMute)
    end
end

function m.muteTrackByName(sTrackName, bMute)
    local oTrack = m.getTrackByName(sTrackName)
    m.muteTrack(oTrack, bMute)
end

function m.getTrackName(nTrackIdx)
    local track = reaper.GetTrack(0, nTrackIdx)
    local ok, trackName = reaper.GetSetMediaTrackInfo_String(track, 'P_NAME', '', false)

    return trackName
end

function m.getTrackByName(sTrackName)
    for trackIndex = 0, reaper.CountTracks(0) - 1 do
        local track = reaper.GetTrack(0, trackIndex)
        local ok, trackName = reaper.GetSetMediaTrackInfo_String(track, 'P_NAME', '', false)

        if ok and trackName == sTrackName then
            return track
        end
    end
end

-- Fx

function m.getTrackFxIdByFxName(oTrack, sFxName)
    return reaper.TrackFX_GetByName(oTrack, sFxName, false)
end

function m.enableTrackFxById(oTrack, nFxId, bEnable)
    reaper.TrackFX_SetEnabled(oTrack, nFxId, bEnable)
end

-- Fx Params

function m.setTrackFxParamValue(oTrack, nFxId, nParamId, nValue)
    reaper.TrackFX_SetParam(oTrack, nFxId, nParamId, nValue)
end

return m