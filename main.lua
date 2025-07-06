
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("BẢOHUB V4 ✨", "DarkTheme")

-- TAB 1: FARM
local FarmTab = Window:NewTab("Farm")
local FarmSection = FarmTab:NewSection("Auto Farm")
FarmSection:NewToggle("Auto Level", "Farm level tự động", function(state)
    if state then
        print("Bật Auto Level")
    else
        print("Tắt Auto Level")
    end
end)

-- TAB 2: RAID
local RaidTab = Window:NewTab("Raid")
local RaidSection = RaidTab:NewSection("Auto Raid")
RaidSection:NewButton("Bắt đầu Raid", "Tự động raid", function()
    print("Đã nhấn nút Raid")
end)

-- TAB 3: Teleport
local TeleTab = Window:NewTab("Teleport")
local TeleSection = TeleTab:NewSection("Dịch chuyển nhanh")
TeleSection:NewDropdown("Chọn đảo", {"Starter", "Jungle", "Desert", "Snow"}, function(place)
    print("Dịch chuyển đến: " .. place)
end)

-- TAB 4: Settings
local SetTab = Window:NewTab("Cài đặt")
local SetSection = SetTab:NewSection("Tùy chọn")
SetSection:NewKeybind("Ẩn/Hiện GUI", "Phím mở/tắt GUI", Enum.KeyCode.RightControl, function()
    Library:ToggleUI()
end)

