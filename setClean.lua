local path = ({reaper.get_action_context()})[2]:match('^.+[\\//]')
local lr = dofile(path .. 'liverigFunctions.lua')
local songs = dofile(path .. 'songs.lua')

local song = songs.getSongByFirstTrackTitle()

if song ~= nil then
    song:setClean()
    song:setTempo()
end

lr.setClean()
