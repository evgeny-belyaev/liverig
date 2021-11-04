local path = ({reaper.get_action_context()})[2]:match('^.+[\\//]')
local lr = dofile(path .. 'liverigFunctions.lua')

local m = {}

m.Song = {}

function m.Song:new()
    local obj = {}

    local amp = lr.getTrackByName(lr.Fender65TwinReverb)
    local ampFxId = 0
    local fxEqReduceHighFxId = 1

    local paramDrive = 0
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
        lr.setCurrentProjectBpm(113)
    end

    function obj:setClean()
        setAmpParam(paramDrive, 0.1)                                 -- Drive
        setAmpParam(paramCompressor, lr.FX_PARAM_BYPASS_ON)       -- Compressor bypass
        setAmpParam(paramDelayMix, 0.0)                          -- Delay mix
        setAmpParam(paramRoomRMix, 0.2)                        -- Room reverb mix
        setAmpParam(paramHallRMix, 0)                          -- Hall reverb mix
        setAmpParam(paramOutputBoost, 0)                       -- Output boost

        -- lr.enableTrackFxById(amp, fxEqReduceHighFxId, true)    -- Eq: Reduce high freq
        lr.setTrackVolume(amp, 1)                              -- Amp track Master Volume
    end

    function obj:setDrive()
        setAmpParam(paramDrive, 0.5)  -- Drive
        setAmpParam(paramCompressor, lr.FX_PARAM_BYPASS_ON)       -- Compressor bypass
        setAmpParam(paramDelayMix, 0)                          -- Delay mix
        setAmpParam(paramRoomRMix, 0.1)                        -- Room reverb mix
        setAmpParam(paramHallRMix, 0)                          -- Hall reverb mix
        setAmpParam(paramOutputBoost, 0)                       -- Output boost

        -- lr.enableTrackFxById(amp, fxEqReduceHighFxId, false)   -- Eq: Reduce high freq
        lr.setTrackVolume(amp, 1)                              -- Amp track Master Volume
    end

    function obj:setSolo()
        self:setDrive()
        setAmpParam(paramOutputBoost, 0.1)                       -- Output boost
    end

    function obj:setExt()
        self:setClean()
    end

    setmetatable(obj, self)
    self.__index = self; return obj
end

return m