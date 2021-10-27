local path = ({reaper.get_action_context()})[2]:match('^.+[\\//]')
local lr = dofile(path .. 'liverigFunctions.lua')

lr.setSong({
    clean = "clean amp Fender",
    drive = "basic drive amp",
    solo = "solo overdrive",
    ext = "ext amp 2"
})