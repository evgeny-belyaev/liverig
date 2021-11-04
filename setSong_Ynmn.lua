local path = ({reaper.get_action_context()})[2]:match('^.+[\\//]')
local songs = dofile(path .. 'songs.lua')

songs.setSong(songs.SONG_YOU_KNOW_MY_NAME)
