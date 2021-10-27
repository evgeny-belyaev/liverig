local path = ({reaper.get_action_context()})[2]:match('^.+[\\//]')
local lr = dofile(path .. 'liverigFunctions.lua')


local song = lr.getSongByFirstTrackTitle()
song:setExt()


-- lr.setSong({
--     clean = "clean amp Mesa",
--     drive = "basic drive amp",
--     solo = "solo overdrive",
--     ext = "ext amp"
-- })

-- lr.disableTrackFxById("solo", 0x1000000 + 0, true)




-- local retval, name = reaper.TrackFX_GetFXName(track, 1, "")

-- lr.setCurrentProjectBpm(139)


-- local fxId = lr.getTrackFxIdByFxName(track, "mesa drive amp")
-- lr.enableTrackFxById("clean amp Fender", fxId, true)
-- lr.setTrackFxParamValue(track, "mesa drive amp", 0, 100)
-- local n = lr.getCurrentProjectFileName()
-- reaper.ShowConsoleMsg(n)
