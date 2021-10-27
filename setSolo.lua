local path = ({reaper.get_action_context()})[2]:match('^.+[\\//]')
local lr = dofile(path .. 'liverigFunctions.lua')

lr.muteTrackByName("clean", true)
lr.muteTrackByName("drive", true)
lr.muteTrackByName("ext", true)

lr.muteTrackByName("fx loop", false)
lr.muteTrackByName("solo", false)




