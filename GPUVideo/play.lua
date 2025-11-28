local id = multishell.launch({}, "video.lua")
multishell.setTitle(id, "Video")
shell.run("audio.lua")
