 local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Button = Instance.new("TextButton")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "BaoHubV4Test"

Frame.Size = UDim2.new(0, 250, 0, 150)
Frame.Position = UDim2.new(0.5, -125, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Parent = ScreenGui

Button.Size = UDim2.new(1, 0, 0, 50)
Button.Position = UDim2.new(0, 0, 0, 50)
Button.Text = "BảoHub V4"
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.BackgroundColor3 = Color3.fromRGB(60, 120, 200)
Button.Font = Enum.Font.Gotham
Button.TextSize = 22
Button.Parent = Frame

Button.MouseButton1Click:Connect(function()
	game.StarterGui:SetCore("SendNotification", {
		Title = "BảoHub";
		Text = "Nút đã hoạt động!";
		Duration = 5;
	})
end)
