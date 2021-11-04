function loadLibrary(name)
    local path = ({reaper.get_action_context()})[2]:match('^.+[\\//]')
    return dofile(path .. name)
end

local lr = loadLibrary('liverigFunctions.lua')

local m = {}

m.SONG_MAKE_ME_WANNA_DIE = "Make Me Wanna Die"
m.SONG_YOU_KNOW_MY_NAME = "You know my name"
m.SONG_PLUGIN_BABY = "Plugin baby"
m.SONG_I_GET_OFF = "I get off"
m.SONG_FORSAKEN = "Forsaken"
m.SONG_GOODNIGHT_MOON = "Goodnight moon"

-- Songs

function loadSong(sScript)
    return loadLibrary(sScript).Song:new()
end

function m.getSongByFirstTrackTitle()
    local title = lr.getTrackName(0)

    if title == m.SONG_MAKE_ME_WANNA_DIE then
        return loadSong('song_MakeMeWannaDie.lua')
    end

    if title == m.SONG_YOU_KNOW_MY_NAME then
        return loadSong('song_YouKnowMyName.lua')
    end

    if title == m.SONG_PLUGIN_BABY then
        return loadSong("song_PlugInBaby.lua")
    end

    if title == m.SONG_I_GET_OFF then
        return loadSong("song_IGetOff.lua")
    end

    if title == m.SONG_FORSAKEN then
        return loadSong("song_Forsaken.lua")
    end

    if title == m.SONG_GOODNIGHT_MOON then
        return loadSong("song_GoodnightMoon.lua")
    end

    return nil
end

function m.setSong(sSong)
    lr.setTrackName(0, sSong)

    local song = m.getSongByFirstTrackTitle()

    song:setClean() -- Set clean sound
    song:setTempo() -- Set tempo

    lr.setClean()   -- Enable clean channel
end

return m