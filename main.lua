-- BẢOHUB V4 - GIAO DIỆN ĐA TAB

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("BẢOHUB V4 ✨", "Midnight")

-- ⚔️ TAB: AUTO FARM
local FarmTab = Window:NewTab("Farm")
local FarmSection = FarmTab:NewSection("Auto Farm")
FarmSection:NewToggle("Auto Level", "Tự động farm level", function(state)
    if state then
        print("Đã bật auto level")
        -- Gắn code farm vào đây
    else
        print("Đã tắt auto level")
    end
end)

-- 🔥 TAB: RAID
local RaidTab = Window:NewTab("Raid")
local RaidSection = RaidTab:NewSection("Auto Raid")
RaidSection:NewButton("Start Raid 🔥", "Tự động Raid", function()
    print("Bắt đầu raid!")
    -- Code raid ở đây
end)

-- 🧭 TAB: TELEPORT
local TeleTab = Window:NewTab("Teleport")
local TeleSection = TeleTab:NewSection("Di chuyển nhanh")
TeleSection:NewDropdown("Đảo", {"Starter", "Desert", "Snow", "Marine"}, function(place)
    print("Dịch chuyển đến: " .. place)
    -- Code teleport đảo ở đây
end)

-- ⚙️ TAB: SETTINGS
local SetTab = Window:NewTab("Cài đặt")
local SetSection = SetTab:NewSection("Tùy chỉnh")
SetSection:NewKeybind("Hiện / Ẩn GUI", "Phím mở menu", Enum.KeyCode.RightControl, function()
	Library:ToggleUI()
end)
