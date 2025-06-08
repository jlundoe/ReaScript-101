-- create table with only audio items
selAudioItems = {}

-- get selected media items
  -- count selected media items
itemCount = reaper.CountSelectedMediaItems(0)

  -- loop through selected items
  for i = 1, itemCount do
      -- store items temporarily
    item = reaper.GetSelectedMediaItem(0, i - 1)
    -- check if item is an audio or midi item
      activeTake = reaper.GetActiveTake(item)
      itemSource = reaper.GetMediaItemTake_Source(activeTake)
      sourceType = reaper.GetMediaSourceType(itemSource)
      if sourceType ~= "MIDI" then
         -- take audio item, and put it in this first table we created
        table.insert(selAudioItems, item)
      else
        -- reaper.ShowConsoleMsg("found midi item")
      end
  end
  

-- generate rnd colorcode
colorCode = reaper.ColorToNative(math.random(0, 255), math.random(0, 255), math.random(0, 255))|0x1000000

-- set audio items with generate new volume
  --loop through audio items
  for key, value in pairs(selAudioItems) do
    -- generate random volume value
    newItemVol = (math.random(10, 100))/100
    -- set item to this new volume value
    reaper.SetMediaItemInfo_Value(value, "D_VOL", newItemVol)
      -- set items to generated colorcode
    reaper.SetMediaItemInfo_Value(value, "I_CUSTOMCOLOR", colorCode)
  end