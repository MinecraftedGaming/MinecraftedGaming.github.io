local frame = 0000
local maxframe = 0000
local framerate = 16

local url = "http://localhost:491/"

local gpu = peripheral.find("directgpu")



-- divide last 2 numbers by 2 (16→8, 9→4.5)
local display = gpu.createDisplay(4, -58, -11, "east", 8, 4.5)

local info = gpu.getDisplayInfo(display)
local width, height = info.pixelWidth, info.pixelHeight

-- timing variables
local startTime = os.epoch("utc")
local frameCount = 0

local targetFrameTime = 1000 / framerate
local nextFrameTime = startTime

while true do
    local now = os.epoch("utc")

    -- wait for correct frame time
    while now < nextFrameTime do
        local diff = nextFrameTime - now

        if diff > 50 then
            os.sleep(0.05)
        else
            os.sleep(0)
        end

        now = os.epoch("utc")
    end

    -- padded frame number
    local padded = string.format("%08d", frame)
    local fullUrl = url .. padded .. ".jpg"

    print("Loading:", fullUrl)

    -- fetch JPEG
    local handle = http.get(fullUrl, {}, true)
    if handle then
        local jpegData = handle.readAll()
        handle.close()

        -- JPEG header check
        local b1 = string.byte(jpegData, 1)
        local b2 = string.byte(jpegData, 2)

        if b1 == 0xFF and b2 == 0xD8 then
            gpu.loadJPEGRegion(display, jpegData, 0, 0, width, height)
            gpu.updateDisplay(display)
        else
            print("Invalid JPEG header:", b1, b2)
        end
    else
        print("Failed to load:", fullUrl)
    end

    -- FPS counters
    frameCount = frameCount + 1
    local elapsed = (now - startTime) / 1000
    if elapsed > 0 then
        print(string.format("Live avg FPS: %.2f", frameCount / elapsed))
    end

    -- advance frame
    frame = frame + 1
    if frame > maxframe then
        local endTime = os.epoch("utc")
        local totalTime = (endTime - startTime) / 1000
        local averageFPS = frameCount / totalTime

        print("Video finished.")
        print(string.format("Time elapsed: %.2f sec", totalTime))
        print(string.format("Average FPS: %.2f", averageFPS))
        break
    end

    nextFrameTime = nextFrameTime + targetFrameTime
end
