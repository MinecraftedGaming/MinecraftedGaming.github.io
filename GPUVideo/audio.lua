local dfpwm = require("cc.audio.dfpwm")
local speaker = peripheral.find("speaker")

-- Create a DFPMW decoder
local decoder = dfpwm.make_decoder()

-- Read the audio file in chunks
for chunk in io.lines("audio.dfpwm", 16 * 1024) do
    local buffer = decoder(chunk)

    -- Play the buffer directly, without mixing with delayed samples
    while not speaker.playAudio(buffer) do
        os.pullEvent("speaker_audio_empty")
    end

    -- Sleep briefly to avoid timeouts when preparing the next batch
    sleep(0.05)
end
