local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("BẢOHUB V4 ✨", "DarkTheme")

local FarmTab = Window:NewTab("Farm")
FarmTab:NewSection("Farm đang hoạt động")

local SeaTab = Window:NewTab("Sea")
SeaTab:NewSection("Sea sắp có")

local RaceTab = Window:NewTab("Race")
RaceTab:NewSection("Race V4 sắp có")

local SetTab = Window:NewTab("Cài đặt")
local section = SetTab:NewSection("Keybind")
section:NewKeybind("Toggle UI", "RightCtrl để bật/tắt", Enum.KeyCode.RightControl, function()
    Library:ToggleUI()
end)
