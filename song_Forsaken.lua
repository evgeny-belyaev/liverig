local path = ({reaper.get_action_context()})[2]:match('^.+[\\//]')
local lr = dofile(path .. 'liverigFunctions.lua')

local m = {}

m.Song = {}

function m.Song:new()
    local obj = {}

    local amp = lr.getTrackByName(lr.MesaTrippleRectifier)
    local ampFxId = 0
    local fxEqReduceHighFxId = 1

    local paramChannel = 0
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
        setAmpParam(paramChannel, lr.MESA_TRIPPLE_RECTIFIER_CH1)  -- Channel
        setAmpParam(paramCompressor, lr.FX_PARAM_BYPASS_ON)       -- Compressor bypass
        setAmpParam(paramDelayMix, 0.0)                          -- Delay mix
        setAmpParam(paramRoomRMix, 0.2)                        -- Room reverb mix
        setAmpParam(paramHallRMix, 0)                          -- Hall reverb mix
        setAmpParam(paramOutputBoost, 0)                       -- Output boost

        -- lr.enableTrackFxById(amp, fxEqReduceHighFxId, true)    -- Eq: Reduce high freq
        lr.setTrackVolume(amp, 1)                              -- Amp track Master Volume
    end

    function obj:setDrive()
        setAmpParam(paramChannel, lr.MESA_TRIPPLE_RECTIFIER_CH2)  -- Channel
        setAmpParam(paramCompressor, lr.FX_PARAM_BYPASS_ON)       -- Compressor bypass
        setAmpParam(paramDelayMix, 0)                          -- Delay mix
        setAmpParam(paramRoomRMix, 0.1)                        -- Room reverb mix
        setAmpParam(paramHallRMix, 0)                          -- Hall reverb mix
        setAmpParam(paramOutputBoost, 0)                       -- Output boost

        -- lr.enableTrackFxById(amp, fxEqReduceHighFxId, false)   -- Eq: Reduce high freq
        lr.setTrackVolume(amp, 1)                              -- Amp track Master Volume
    end

    function obj:setSolo()
        setAmpParam(paramChannel, lr.MESA_TRIPPLE_RECTIFIER_CH3)  -- Channel
        setAmpParam(paramCompressor, lr.FX_PARAM_BYPASS_OFF)      -- Compressor bypass
        setAmpParam(paramDelayMix, 0.05)                          -- Delay mix
        setAmpParam(paramRoomRMix, 0)                          -- Room reverb mix
        setAmpParam(paramHallRMix, 0.2)                        -- Hall reverb mix
        setAmpParam(paramOutputBoost, 0.1)                       -- Output boost

        -- lr.enableTrackFxById(amp, fxEqReduceHighFxId, false)   -- Eq: Reduce high freq
        lr.setTrackVolume(amp, 1)                              -- Amp track Master Volume
    end

    function obj:setExt()
        self:setClean()
    end

    setmetatable(obj, self)
    self.__index = self; return obj
end

return m