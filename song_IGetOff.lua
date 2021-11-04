local path = ({reaper.get_action_context()})[2]:match('^.+[\\//]')
local lr = dofile(path .. 'liverigFunctions.lua')

local m = {}

m.Song = {}

function m.Song:new()
    local obj = {}

    local amp = lr.getTrackByName(lr.MarshallAFD100)
    local ampFxId = 0
    local fxEqReduceHighFxId = 1

    local paramGain = 0
    local paramCompressor = 1
    local paramDelayMix = 2
    local paramRoomRMix = 3
    local paramHallRMix = 4
    local paramOutputBoost = 5

    local autoWah = lr.getTrackByName("Auto Wah")
    lr.muteTrack(autoWah, true) -- mute autowah

    -- Unmute all but our amp
    lr.muteAllAmpsBut(amp)

    function setAmpParam(fxId, value)
        lr.setTrackFxParamValue(amp, ampFxId, fxId, value)
    end

    function obj:setTempo()
        lr.setCurrentProjectBpm(165)
    end

    function obj:setClean()
        setAmpParam(paramGain, 0.3)                            -- Gain
        setAmpParam(paramCompressor, lr.FX_PARAM_BYPASS_ON)       -- Compressor bypass
        setAmpParam(paramDelayMix, 0.0)                        -- Delay mix
        setAmpParam(paramRoomRMix, 0.2)                        -- Room reverb mix
        setAmpParam(paramHallRMix, 0)                          -- Hall reverb mix
        setAmpParam(paramOutputBoost, 0.1)                       -- Output boost

        lr.enableTrackFxById(amp, fxEqReduceHighFxId, true)    -- Eq: Reduce high freq
        lr.setTrackVolume(amp, 1)                              -- Amp track Master Volume
    end

    function obj:setDrive()
        setAmpParam(paramGain, 0.8)                            -- Gain
        setAmpParam(paramCompressor, lr.FX_PARAM_BYPASS_ON)       -- Compressor bypass
        setAmpParam(paramDelayMix, 0)                          -- Delay mix
        setAmpParam(paramRoomRMix, 0.1)                        -- Room reverb mix
        setAmpParam(paramHallRMix, 0)                          -- Hall reverb mix
        setAmpParam(paramOutputBoost, 0)                       -- Output boost

        lr.enableTrackFxById(amp, fxEqReduceHighFxId, false)   -- Eq: Reduce high freq
        lr.setTrackVolume(amp, 1)                              -- Amp track Master Volume
    end

    function obj:setSolo()
        setAmpParam(paramGain, 0.4)                            -- Gain
        setAmpParam(paramCompressor, lr.FX_PARAM_BYPASS_OFF)      -- Compressor bypass
        setAmpParam(paramDelayMix, 0)                          -- Delay mix
        setAmpParam(paramRoomRMix, 0.1)                          -- Room reverb mix
        setAmpParam(paramHallRMix, 0)                        -- Hall reverb mix
        setAmpParam(paramOutputBoost, 0.1)                       -- Output boost

        lr.enableTrackFxById(amp, fxEqReduceHighFxId, false)   -- Eq: Reduce high freq
        lr.setTrackVolume(amp, 1.1)                              -- Amp track Master Volume
    end

    function obj:setExt()
        self:setClean()
    end

    setmetatable(obj, self)
    self.__index = self; return obj
end

return m