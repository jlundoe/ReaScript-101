-- USER CONFIG AREA -----------------------------------------------------------

-- set the max volume variation in dB (the value will either be added or subtracted)
local maxVolumeVariation = 6
-- boolean - set popup input value on or off (if on the value above this line is ignored)
local popup = true
-- boolean - set volume variation to be relative to current item volume
local relVolumeVariation = false
------------------------------------------------------- END OF USER CONFIG AREA

-- rnd volume generator
function generateNewVolValue(currentItemVol, maxVolDifference)
    -- generate random DB volume value
    local rndDb = math.random()*maxVolDifference
    local itemDb = 20*math.log(currentItemVol, 10)

    -- randomly decide to add or subtract
    local randomNumber = math.random(0, 1)
    if randomNumber == 1 then
        itemDb = itemDb - rndDb
    else
        itemDb = itemDb + rndDb
    end
    
    -- convert new db back to float
    local newItemFloat = 10^(itemDb/20)

    return newItemFloat
end

function main()
    -- create table with only audio items
    -- create table to store selected audio items
    local selAudioItems = {}
    -- get selected media items
    -- count selected media items
    local itemCount = reaper.CountSelectedMediaItems(0)
    -- loop through selected items
    for i = 1, itemCount do
        -- store item temporarily
        local item = reaper.GetSelectedMediaItem(0, i - 1)
        -- check if item is an audio or midi item
        local activeTake = reaper.GetActiveTake(item)
        if activeTake ~= nil then
            local itemSource = reaper.GetMediaItemTake_Source(activeTake)
            local sourceType = reaper.GetMediaSourceType(itemSource)
            -- if audio item, store item in table
            if sourceType ~= "MIDI" then
                table.insert(selAudioItems, item)
            else
                -- reaper.ShowConsoleMsg("ignoring midi item")
            end
        end
    end

    -- generate rnd colorcode
    local colorCode = reaper.ColorToNative(math.random(0, 255), math.random(0, 255), math.random(0, 255))
    
    -- set audio items rnd volume change
    -- loop through items in table
    for key, value in pairs(selAudioItems) do
        local currentItemVol
        if relVolumeVariation then
            -- get current item volume
            currentItemVol = reaper.GetMediaItemInfo_Value(value, "D_VOL")
        else
            -- reset item volume to zero
            currentItemVol = 1
        end
        -- generate new item volume (new value relative to it's previous volume)
        local newItemVol = generateNewVolValue(currentItemVol, maxVolumeVariation)
        -- set item to new random volume
        reaper.SetMediaItemInfo_Value(value, "D_VOL", newItemVol)
    
        -- set items to generated colorcode (as indicator)
        reaper.SetMediaItemInfo_Value(value, "I_CUSTOMCOLOR", colorCode|0x1000000)
    end
end

-- popup function is on
if popup == true then
    local retval, input = reaper.GetUserInputs("Input max volume variation amount", 1, "Amount in dB:", "")
    if retval then
      local isNumber = false
      local findNoNumbers = string.match(input, "[^%d]")
      if findNoNumbers == nil then
        isNumber = true
      end
      if isNumber then
        maxVolumeVariation = tonumber(input)
        -- execute main script
        main()
      else
        reaper.ShowMessageBox("Input not a number", "Aborting", 0)
      end
    else
        reaper.ShowMessageBox("No input", "Aborting", 0)
    end
end

-- popup function is off
if not popup then
    main()
end