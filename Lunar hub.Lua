local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LunarHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Main Frame
local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0, 350, 0, 420)
Main.Position = UDim2.new(0.5, -175, 0.5, -210)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
Main.BorderSizePixel = 0

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

-- Title
local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "🌙 Lunar Hub"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.TextColor3 = Color3.fromRGB(170, 85, 255)

-- Floating Menu Button
local MenuButton = Instance.new("TextButton")
MenuButton.Parent = ScreenGui
MenuButton.Size = UDim2.new(0, 50, 0, 50)
MenuButton.Position = UDim2.new(0, 15, 0.5, -25)
MenuButton.Text = "☰"
MenuButton.Font = Enum.Font.GothamBold
MenuButton.TextSize = 28
MenuButton.TextColor3 = Color3.new(1,1,1)
MenuButton.BackgroundColor3 = Color3.fromRGB(120, 60, 255)
Instance.new("UICorner", MenuButton)

-- Textboxes
local function CreateBox(name, posY, value)
	local Label = Instance.new("TextLabel")
	Label.Parent = Main
	Label.Size = UDim2.new(0.45, 0, 0, 35)
	Label.Position = UDim2.new(0.05, 0, 0, posY)
	Label.BackgroundTransparency = 1
	Label.Text = name
	Label.Font = Enum.Font.Gotham
	Label.TextSize = 16
	Label.TextColor3 = Color3.new(1,1,1)

	local Box = Instance.new("TextBox")
	Box.Parent = Main
	Box.Size = UDim2.new(0.35, 0, 0, 35)
	Box.Position = UDim2.new(0.6, 0, 0, posY)
	Box.Text = value
	Box.Font = Enum.Font.Gotham
	Box.TextSize = 16
	Box.BackgroundColor3 = Color3.fromRGB(35,35,50)
	Box.TextColor3 = Color3.new(1,1,1)

	Instance.new("UICorner", Box)
end

CreateBox("Walking Speed", 70, "16")
CreateBox("Grab Speed", 120, "36")
CreateBox("Sweep Speed", 170, "38")

-- Toggle Buttons
local function CreateToggle(text, posY)
	local Btn = Instance.new("TextButton")
	Btn.Parent = Main
	Btn.Size = UDim2.new(0.9, 0, 0, 40)
	Btn.Position = UDim2.new(0.05, 0, 0, posY)
	Btn.BackgroundColor3 = Color3.fromRGB(35,35,50)
	Btn.TextColor3 = Color3.new(1,1,1)
	Btn.Font = Enum.Font.GothamBold
	Btn.TextSize = 16

	local state = false
	Btn.Text = text .. " : OFF"

	Instance.new("UICorner", Btn)

	Btn.MouseButton1Click:Connect(function()
		state = not state
		Btn.Text = text .. (state and " : ON" or " : OFF")
	end)
end

CreateToggle("Auto Loop Steal", 240)
CreateToggle("Infinite Jump", 290)
CreateToggle("ESP", 340)

-- Minimize
local Visible = true

MenuButton.MouseButton1Click:Connect(function()
	Visible = not Visible
	Main.Visible = Visible
end)

-- Dragging
local dragging = false
local dragStart
local startPos

Main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch
	or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = Main.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and (
		input.UserInputType == Enum.UserInputType.Touch
		or input.UserInputType == Enum.UserInputType.MouseMovement
	) then
		local delta = input.Position - dragStart
		Main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)
