-- Lunar Hub | Undected
-- Visual UI Only (No Functional Buttons)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

pcall(function()
	if PlayerGui:FindFirstChild("LunarHubUI") then
		PlayerGui.LunarHubUI:Destroy()
	end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LunarHubUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Main Panel
local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0, 165, 0, 420)
Main.Position = UDim2.new(0.5, -82, 0.5, -210)
Main.BackgroundColor3 = Color3.fromRGB(15,15,20)
Main.BorderSizePixel = 0

Instance.new("UICorner", Main).CornerRadius = UDim.new(0,12)

local Stroke = Instance.new("UIStroke")
Stroke.Parent = Main
Stroke.Color = Color3.fromRGB(255,255,255)
Stroke.Thickness = 1

-- Title
local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1,0,0,35)
Title.BackgroundTransparency = 1
Title.Text = "LUNAR HUB"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14

local Sub = Instance.new("TextLabel")
Sub.Parent = Main
Sub.Position = UDim2.new(0,0,0,20)
Sub.Size = UDim2.new(1,0,0,20)
Sub.BackgroundTransparency = 1
Sub.Text = "Undected"
Sub.TextColor3 = Color3.fromRGB(170,170,170)
Sub.Font = Enum.Font.Gotham
Sub.TextSize = 10

-- Scroll
local Scroll = Instance.new("ScrollingFrame")
Scroll.Parent = Main
Scroll.Position = UDim2.new(0,5,0,45)
Scroll.Size = UDim2.new(1,-10,1,-50)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 3
Scroll.CanvasSize = UDim2.new(0,0,0,900)

local Layout = Instance.new("UIListLayout")
Layout.Parent = Scroll
Layout.Padding = UDim.new(0,8)

local function CreateButton(text, purple)
	local Btn = Instance.new("TextButton")
	Btn.Parent = Scroll
	Btn.Size = UDim2.new(1,0,0,38)
	Btn.Text = text
	Btn.Font = Enum.Font.Gotham
	Btn.TextSize = 11
	Btn.TextColor3 = Color3.new(1,1,1)
	Btn.BackgroundColor3 = purple and Color3.fromRGB(180,140,255) or Color3.fromRGB(20,20,25)
	Btn.AutoButtonColor = false

	Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,8)

	local S = Instance.new("UIStroke")
	S.Parent = Btn
	S.Color = Color3.fromRGB(255,255,255)
	S.Thickness = 1

	return Btn
end

CreateButton("SPEED : 0")
CreateButton("AUTO MEDUSA")
CreateButton("FLIGHT MODE")
CreateButton("INFINITE JUMP")
CreateButton("OPTIMIZER")
CreateButton("ANTI RAGDOLL")
CreateButton("GALAXY SKY")
CreateButton("UNWALK")
CreateButton("FPS BOOST")
CreateButton("AUTO FARM")
CreateButton("AUTO GRAB")
CreateButton("BUTTON VISIBILITY")
CreateButton("SHOW UI")
CreateButton("CUSTOM SPEED")
CreateButton("PREDICT")
CreateButton("LEFT", true)
CreateButton("RIGHT")
CreateButton("AUTO", true)

-- Left Floating Panel
local Left = Instance.new("Frame")
Left.Parent = ScreenGui
Left.Size = UDim2.new(0,160,0,90)
Left.Position = UDim2.new(0,20,0.25,0)
Left.BackgroundTransparency = 1

local function MiniButton(parent,text,x,y,w)
	local B = Instance.new("TextButton")
	B.Parent = parent
	B.Size = UDim2.new(0,w or 40,0,30)
	B.Position = UDim2.new(0,x,0,y)
	B.Text = text
	B.Font = Enum.Font.Gotham
	B.TextSize = 11
	B.TextColor3 = Color3.new(1,1,1)
	B.BackgroundColor3 = Color3.fromRGB(20,20,25)

	Instance.new("UICorner",B).CornerRadius = UDim.new(1,0)

	local S = Instance.new("UIStroke")
	S.Parent = B
	S.Color = Color3.new(1,1,1)

	return B
end

MiniButton(Left,"◼",0,0)
MiniButton(Left,"≡",45,0)
MiniButton(Left,"💬",90,0)
MiniButton(Left,"⚙",135,0)

MiniButton(Left,"II",0,40,35)
MiniButton(Left,"BAT",40,40,50)
MiniButton(Left,"LEFT",95,40,55)

-- Right Buttons
local Right = Instance.new("Frame")
Right.Parent = ScreenGui
Right.Size = UDim2.new(0,60,0,120)
Right.Position = UDim2.new(1,-90,0.35,0)
Right.BackgroundTransparency = 1

MiniButton(Right,"TP1",0,0,50)
MiniButton(Right,"DROP",0,40,50)
MiniButton(Right,"TP2",0,80,50)

-- Draggable
local dragging = false
local dragStart, startPos

Main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch
	or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = Main.Position
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.Touch
	or input.UserInputType == Enum.UserInputType.MouseMovement) then
		local delta = input.Position - dragStart
		Main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch
	or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)
