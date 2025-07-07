-- 📦 BẢOHUB V4 (Rayfield UI - Redz Style Full Version)

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/baobelne/rayfield-custom/main/loader.lua"))()
local Player = game.Players.LocalPlayer
local VirtualInputManager = game:GetService("VirtualInputManager")
local Workspace = game:GetService("Workspace")
local PathfindingService = game:GetService("PathfindingService")

local Window = Rayfield:CreateWindow({
   Name = "✨ BẢOHUB V4 - Redz Style",
   LoadingTitle = "BẢOHUB V4 đang khởi động...",
   LoadingSubtitle = "By baobelne",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "BảoHubV4",
      FileName = "BảoCấuHình"
   },
   Discord = {
      Enabled = false
   },
   KeySystem = false,
})

-- 🥷 TAB: FARM
local FarmTab = Window:CreateTab("🥷 Auto Farm", 4483362458)
local FarmSec = FarmTab:CreateSection("Auto Level")

_G.AutoFarm = false
_G.AutoMove = false
_G.AutoFloat = false

FarmTab:CreateToggle({
   Name = "Bật Auto Level",
   CurrentValue = false,
   Callback = function(v)
      _G.AutoFarm = v
      if v then AutoLevel() end
   end
})

FarmTab:CreateToggle({
   Name = "Tự di chuyển đến mục tiêu",
   CurrentValue = false,
   Callback = function(v)
      _G.AutoMove = v
   end
})

FarmTab:CreateToggle({
   Name = "Tự bay lên đầu quái",
   CurrentValue = false,
   Callback = function(v)
      _G.AutoFloat = v
   end
})

function SmartMove(toPos)
   if not _G.AutoMove then
      Player.Character.HumanoidRootPart.CFrame = toPos
      return
   end
   local path = PathfindingService:CreatePath({
      AgentRadius = 2,
      AgentHeight = 5,
      AgentCanJump = true,
      AgentJumpHeight = 10,
      AgentCanClimb = true
   })
   path:ComputeAsync(Player.Character.HumanoidRootPart.Position, toPos.Position)
   if path.Status == Enum.PathStatus.Complete then
      for _, waypoint in pairs(path:GetWaypoints()) do
         Player.Character.Humanoid:MoveTo(waypoint.Position)
         Player.Character.Humanoid.MoveToFinished:Wait()
      end
   else
      Player.Character.HumanoidRootPart.CFrame = toPos
   end
end

function Equip()
   local char = Player.Character
   local toolEquipped = char and char:FindFirstChildOfClass("Tool")

   if toolEquipped then return end

   local backpack = Player.Backpack:GetChildren()
   for _, tool in pairs(backpack) do
      if tool:IsA("Tool") then
         char.Humanoid:EquipTool(tool)
         break
      end
   end
end

function AutoLevel()
   task.spawn(function()
      while _G.AutoFarm do task.wait()
         pcall(function()
            local lv = Player.Data.Level.Value
            local mob, quest, questPos, mobPos

            if lv <= 10 then
               mob = "Bandit"
               quest = "BanditQuest1"
               questPos = CFrame.new(1060,17,1548)
               mobPos = CFrame.new(1142,18,1610)
            elseif lv <= 30 then
               mob = "Monkey"
               quest = "JungleQuest"
               questPos = CFrame.new(-1602,36,152)
               mobPos = CFrame.new(-1449,67,88)
            end

            if mob and quest then
               Equip()
               SmartMove(questPos)
               wait(1)
               game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", quest, 1)

               for _,v in pairs(workspace.Enemies:GetChildren()) do
                  if v.Name == mob and v:FindFirstChild("HumanoidRootPart") then
                     repeat
                        Equip()
                        local offset = Vector3.new(0,3,0)
                        if _G.AutoFloat then
                           Player.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame + offset
                        else
                           SmartMove(v.HumanoidRootPart.CFrame + offset)
                        end
                        v.HumanoidRootPart.Anchored = true
                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                        v.HumanoidRootPart.Transparency = 0.5
                        wait()
                     until v.Humanoid.Health <= 0 or not _G.AutoFarm
                  end
               end
            end

            if _G.AutoClick then AutoClick() end
         end)
      end
   end)
end

-- 🔥 Auto Attack
_G.AutoClick = false
FarmTab:CreateToggle({
   Name = "Auto Attack (đánh thường)",
   CurrentValue = false,
   Callback = function(v)
      _G.AutoClick = v
      if v then AutoClick() end
   end
})

function AutoClick()
   task.spawn(function()
      while _G.AutoClick and wait(0.2) do
         pcall(function()
            local tool = Player.Character:FindFirstChildOfClass("Tool")
            if tool then
               tool:Activate()
            end
         end)
      end
   end)
end

-- 🍉 Auto Pickup Devil Fruit
_G.AutoFruit = false
FarmTab:CreateToggle({
   Name = "Tự động nhặt trái ác quỷ",
   CurrentValue = false,
   Callback = function(v)
      _G.AutoFruit = v
      if v then AutoFruit() end
   end
})

function AutoFruit()
   task.spawn(function()
      while _G.AutoFruit and wait(1) do
         pcall(function()
            for _, fruit in pairs(Workspace:GetChildren()) do
               if fruit:IsA("Tool") and string.find(fruit.Name:lower(), "fruit") then
                  SmartMove(fruit.Handle.CFrame)
                  wait(0.2)
               end
            end
         end)
      end
   end)
end

-- 🔥 Auto Skill Z/X/C/V
_G.AutoZ = false
_G.AutoX = false
_G.AutoC = false
_G.AutoV = false

FarmTab:CreateToggle({ Name = "Auto Z", CurrentValue = false, Callback = function(v) _G.AutoZ = v if v then AutoSkill("Z") end end })
FarmTab:CreateToggle({ Name = "Auto X", CurrentValue = false, Callback = function(v) _G.AutoX = v if v then AutoSkill("X") end end })
FarmTab:CreateToggle({ Name = "Auto C", CurrentValue = false, Callback = function(v) _G.AutoC = v if v then AutoSkill("C") end end })
FarmTab:CreateToggle({ Name = "Auto V", CurrentValue = false, Callback = function(v) _G.AutoV = v if v then AutoSkill("V") end end })

function AutoSkill(key)
   spawn(function()
      while _G["Auto"..key] and wait(1) do
         pcall(function()
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode[key], false, game)
            wait(0.1)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode[key], false, game)
         end)
      end
   end)
end

-- 🌊 TAB: SEA
local SeaTab = Window:CreateTab("🌊 Sea Events", 13238613516)
SeaTab:CreateSection("Tính năng Sea Beast đang cập nhật...")

-- 🧬 TAB: RACE
local RaceTab = Window:CreateTab("🧬 Race V4", 9606551333)
RaceTab:CreateSection("Tính năng Auto Trial sẽ có sớm")

-- ⚔️ TAB: BOSS
local BossTab = Window:CreateTab("⚔️ Boss", 4581219946)
BossTab:CreateSection("Sắp có Auto Boss riêng biệt")

-- 🗺️ TAB: TELEPORT
local TeleTab = Window:CreateTab("🗺️ Teleport", 6031075938)
TeleTab:CreateSection("Dịch chuyển nhanh đến đảo")

local locationList = {
   ["Starter"] = CFrame.new(1085,17,1426),
   ["Jungle"] = CFrame.new(-1619,36,143),
   ["Desert"] = CFrame.new(1157,5,4322)
}

TeleTab:CreateDropdown({
   Name = "Chọn đảo",
   Options = {"Starter", "Jungle", "Desert"},
   CurrentOption = "Starter",
   Callback = function(opt)
      Player.Character.HumanoidRootPart.CFrame = locationList[opt]
   end
})

-- ⚙️ TAB: CÀI ĐẶT
local SetTab = Window:CreateTab("⚙️ Cài đặt", 13548965959)
SetTab:CreateSection("Phím tắt")

SetTab:CreateParagraph({Title = "Toggle GUI", Content = "Bấm Right Ctrl để ẩn/hiện GUI"})
