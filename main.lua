local FarmTab = Window:NewTab("Farm")
local FarmSection = FarmTab:NewSection("Tự động luyện cấp")

_G.AutoFarm = false
_G.SelectedWeapon = "Combat" -- Thay bằng tên vũ khí bạn dùng (ví dụ: "Sharkman Karate")

FarmSection:NewToggle("Auto Level", "Tự động đánh quái theo cấp", function(state)
    _G.AutoFarm = state
    if state then
        AutoLevel()
    end
end)

FarmSection:NewTextbox("Tên vũ khí", "Gõ đúng tên vũ khí bạn đang dùng", function(txt)
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

                -- Bạn có thể thêm nhiều cấp hơn nếu muốn
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
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                                mob.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                mob.HumanoidRootPart.Transparency = 0.5
                                mob.HumanoidRootPart.Anchored = true
                                wait()
                            until mob.Humanoid.Health <= 0 or not _G.AutoFarm
                        end
                    end
                end
            end)
        end
    end)
end


FarmSection:NewSection("Boss")

local BossList = {"Saber Expert", "Bobby", "Yeti", "Magma Admiral"}
FarmSection:NewDropdown("Chọn Boss", BossList, function(boss)
    _G.SelectedBoss = boss
end)

FarmSection:NewButton("Đánh Boss", "Tự tìm và đánh boss đã chọn", function()
    local boss = game.Workspace.Enemies:FindFirstChild(_G.SelectedBoss)
    if boss and boss:FindFirstChild("HumanoidRootPart") then
        repeat
            EquipWeapon()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
            wait()
        until boss.Humanoid.Health <= 0
    end
end)
