local m = {}

m.MakeMeWannaDie = {}

function m.MakeMeWannaDie:new()
    local obj = {}

    local mesa = m.getTrackByName("Mesa Tripple Rectifier")
    local ampFxId = 0
    local fxEqReduceHighFxId = 1

    local paramChannel = 0
    local paramCompressor = 1
    local paramDelayMix = 2
    local paramRoomRMix = 3
    local paramHallRMix = 4

    -- Unmute the amp
    m.muteTrack(mesa, false)

    function setAmpParam(fxId, value)
        m.setTrackFxParamValue(mesa, ampFxId, fxId, value)
    end

    function obj:setClean()
        setAmpParam(paramChannel, MESA_TRIPPLE_RECTIFIER_CH1)  -- Channel
        setAmpParam(paramCompressor, FX_PARAM_BYPASS_ON)       -- Compressor bypass
        setAmpParam(paramDelayMix, 0)                          -- Delay mix
        setAmpParam(paramRoomRMix, 0.1)                        -- Room reverb mix
        setAmpParam(paramHallRMix, 0)                          -- Hall reverb mix

        m.enableTrackFxById(mesa, fxEqReduceHighFxId, true)    -- Eq: Reduce high freq
    end

    function obj:setDrive()
        setAmpParam(paramChannel, MESA_TRIPPLE_RECTIFIER_CH2)  -- Channel
        setAmpParam(paramCompressor, FX_PARAM_BYPASS_ON)       -- Compressor bypass
        setAmpParam(paramDelayMix, 0)                          -- Delay mix
        setAmpParam(paramRoomRMix, 0.1)                        -- Room reverb mix
        setAmpParam(paramHallRMix, 0)                          -- Hall reverb mix

        m.enableTrackFxById(mesa, fxEqReduceHighFxId, false)   -- Eq: Reduce high freq
    end

    function obj:setSolo()
        setAmpParam(paramChannel, MESA_TRIPPLE_RECTIFIER_CH2)  -- Channel
        setAmpParam(paramCompressor, FX_PARAM_BYPASS_OFF)      -- Compressor bypass
        setAmpParam(paramDelayMix, 0.1)                        -- Delay mix
        setAmpParam(paramRoomRMix, 0)                          -- Room reverb mix
        setAmpParam(paramHallRMix, 0.1)                        -- Hall reverb mix

        m.enableTrackFxById(mesa, fxEqReduceHighFxId, false)   -- Eq: Reduce high freq
    end

    function obj:setExt()
        self:setClean()
    end

    setmetatable(obj, self)
    self.__index = self; return obj
end

function m.getSongByFirstTrackTitle()
    local title = m.getTrackName(0)

    if title == "Make Me Wanna Die" then
        return m.MakeMeWannaDie:new()
    end
end


return m