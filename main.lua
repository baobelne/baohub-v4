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

   -- 📌 Gắn logo vào đây:
   Logo = "https://i.imgur.com/X5Xxnh1.png",         -- ← ảnh bạn vừa gửi
   LoadingImage = "https://i.imgur.com/X5Xxnh1.png"  -- ← ảnh hiển thị khi loading
})


-- 🔥 TAB: FARM
local FarmTab = Window:CreateTab("🥷 Auto Farm", 4483362458)
local FarmSec = FarmTab:CreateSection("Auto Level")

_G.AutoFarm = false
_G.Weapon = "Combat"

FarmTab:CreateInput({
   Name = "Tên vũ khí",
   PlaceholderText = "Ví dụ: Dragon Talon",
   RemoveTextAfterFocusLost = false,
   Callback = function(txt)
      _G.Weapon = txt
   end
})

FarmTab:CreateToggle({
   Name = "Bật Auto Level",
   CurrentValue = false,
   Callback = function(v)
      _G.AutoFarm = v
      if v then AutoLevel() end
   end
})
_G.AutoClick = false

FarmTab:CreateToggle({
   Name = "Auto Attack (Chuột trái)",
   CurrentValue = false,
   Callback = function(v)
      _G.AutoClick = v
      if v then
         AutoClick()
      end
   end
}) 
_G.AutoClick = false

FarmTab:CreateToggle({
   Name = "Auto Attack (vũ khí)",
   CurrentValue = false,
   Callback = function(v)
      _G.AutoClick = v
      if v then AutoClick() end
   end
})

function AutoClick()
   spawn(function()
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

function Equip()
   local Tool = Player.Backpack:FindFirstChild(_G.Weapon)
   if Tool then
      Player.Character.Humanoid:EquipTool(Tool)
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
               Player.Character.HumanoidRootPart.CFrame = questPos
               wait(1)
               game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", quest, 1)

               for _,v in pairs(workspace.Enemies:GetChildren()) do
                  if v.Name == mob and v:FindFirstChild("HumanoidRootPart") then
                     repeat
                        Equip()
                        Player.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
                        v.HumanoidRootPart.Anchored = true
                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                        v.HumanoidRootPart.Transparency = 0.5
                        wait()
                     until v.Humanoid.Health <= 0 or not _G.AutoFarm
                  end
               end
            end
         end)
      end
   end)
end
})

function AutoClick()
   task.spawn(function()
      while _G.AutoClick do task.wait()
         pcall(function()
            game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0))
            wait(0.1)
            game:GetService("VirtualUser"):Button1Up(Vector2.new(0,0))
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
