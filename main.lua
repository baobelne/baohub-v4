-- BẢOHUB V4 - ĐẦY ĐỦ GIAO DIỆN GIỐNG REDZHUB

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("BẢOHUB V4 ✨", "DarkTheme")

-- 🥷 TAB: FARM
local FarmTab = Window:NewTab("Farm")
local FarmSection = FarmTab:NewSection("Auto Farm")

_G.AutoFarm = false
_G.SelectedWeapon = "Combat" -- đổi tên nếu dùng vũ khí khác

FarmSection:NewToggle("Auto Level", "Farm theo level", function(state)
    _G.AutoFarm = state
    if state then AutoLevel() end
end)

FarmSection:NewTextbox("Tên vũ khí", "Ví dụ: Dragon Talon", function(txt)
    _G.SelectedWeapon = txt
end)

function EquipWeapon()
    local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(_G.SelectedWeapon)
    if tool then
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
    end
end

function AutoLevel()
    spawn(function()
        while _G.AutoFarm and wait(0.5) do
            pcall(function()
                local lv = game.Players.LocalPlayer.Data.Level.Value
                local mobName, mobQuest, questPos, mobPos = nil, nil, nil, nil

                if lv <= 10 then
                    mobName = "Bandit"
                    mobQuest = "BanditQuest1"
                    questPos = CFrame.new(1060, 17, 1548)
                    mobPos = CFrame.new(1142, 18, 1610)
                elseif lv <= 30 then
                    mobName = "Monkey"
                    mobQuest = "JungleQuest"
                    questPos = CFrame.new(-1602, 36, 152)
                    mobPos = CFrame.new(-1449, 67, 88)
                end

                if mobName then
                    EquipWeapon()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = questPos
                    wait(1)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", mobQuest, 1)

                    for _, mob in pairs(game.Workspace.Enemies:GetChildren()) do
                        if mob.Name == mobName and mob:FindFirstChild("HumanoidRootPart") then
                            repeat
                                EquipWeapon()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
                                mob.HumanoidRootPart.Anchored = true
                                mob.HumanoidRootPart.Transparency = 0.5
                                mob.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                wait()
                            until mob.Humanoid.Health <= 0 or not _G.AutoFarm
                        end
                    end
                end
            end)
        end
    end)
end

-- 👹 TAB: RACE (khung sẵn)
local RaceTab = Window:NewTab("Race")
local RaceSection = RaceTab:NewSection("Race V4")
RaceSection:NewButton("Mở Gương Race", "Auto farm Mirror Fractal + Mở Trial", function()
    print("Tính năng đang cập nhật...")
end)

-- 🌊 TAB: SEA
local SeaTab = Window:NewTab("Sea")
local SeaSection = SeaTab:NewSection("Săn Biển")
SeaSection:NewButton("Auto Sea Beast", "Tự động săn rồng biển", function()
    print("Tính năng đang cập nhật...")
end)

-- 🗺️ TAB: TELEPORT
local TeleTab = Window:NewTab("Teleport")
local TeleSection = TeleTab:NewSection("Dịch chuyển nhanh")

local locations = {
    Starter = CFrame.new(1085, 17, 1426),
    Jungle = CFrame.new(-1619, 36, 143),
    Desert = CFrame.new(1157, 5, 4322)
}

TeleSection:NewDropdown("Chọn đảo", {"Starter", "Jungle", "Desert"}, function(place)
    local target = locations[place]
    if target then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target
    end
end)

-- ⚙️ TAB: CÀI ĐẶT
local SetTab = Window:NewTab("Cài đặt")
local SetSection = SetTab:NewSection("Tùy chỉnh")
SetSection:NewKeybind("Ẩn/Hiện GUI", "Right Ctrl", Enum.KeyCode.RightControl, function()
    Library:ToggleUI()
end)

