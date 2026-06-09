-- LUNAR HUB (Generic Showcase UI)
-- Visual Only

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LunarHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

--------------------------------------------------
-- FLOATING BUTTONS
--------------------------------------------------

local MenuBtn = Instance.new("TextButton")
MenuBtn.Parent = ScreenGui
MenuBtn.Size = UDim2.new(0,45,0,45)
MenuBtn.Position = UDim2.new(0,10,0.5,-54)
MenuBtn.Text = "≡"
MenuBtn.TextSize = 10
MenuBtn.Font = Enum.Font.GothamBold
MenuBtn.BackgroundColor3 = Color3.fromRGB(130,70,255)
MenuBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner",MenuBtn)

local BatBtn = Instance.new("TextButton")
BatBtn.Parent = ScreenGui
BatBtn.Size = UDim2.new(0,38,0,32)
BatBtn.Position = UDim2.new(0,55,0.5,-54)
BatBtn.Text = "BAT"
BatBtn.TextSize = 12
BatBtn.Font = Enum.Font.GothamBold
BatBtn.BackgroundColor3 = Color3.fromRGB(35,35,50)
BatBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner",BatBtn)

local SideBtn = Instance.new("TextButton")
SideBtn.Parent = ScreenGui
SideBtn.Size = UDim2.new(0,45,0,32)
SideBtn.Position = UDim2.new(0,98,0.5,-54)
SideBtn.Text = "LEFT"
SideBtn.TextSize = 12
SideBtn.Font = Enum.Font.GothamBold
SideBtn.BackgroundColor3 = Color3.fromRGB(35,35,50)
SideBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner",SideBtn)

--------------------------------------------------
-- MAIN PANEL
--------------------------------------------------

local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0,225,0,380)
Main.Position = UDim2.new(0.5,-112,0.5,-190)
Main.BackgroundColor3 = Color3.fromRGB(20,20,30)
Main.BorderSizePixel = 0
Instance.new("UICorner",Main)

local Scroll = Instance.new("ScrollingFrame")
Scroll.Parent = Main
Scroll.Position = UDim2.new(0,0,0,30)
Scroll.Size = UDim2.new(1,0,1,-30)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 4
Scroll.CanvasSize = UDim2.new(0,0,0,500)
Scroll.ScrollingDirection = Enum.ScrollingDirection.Y
--------------------------------------------------
-- TITLE BAR
--------------------------------------------------

local TitleBar = Instance.new("Frame")
TitleBar.Parent = Main
TitleBar.Size = UDim2.new(1,0,0,30)
TitleBar.BackgroundTransparency = 1

local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1,0,1,0)
Title.BackgroundTransparency = 1
Title.Text = "LUNAR HUB"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

--------------------------------------------------
-- TEXTBOX CREATOR
--------------------------------------------------

local function CreateBox(title,y,value)

	local Label = Instance.new("TextLabel")
	Label.Parent = Scroll
	Label.Position = UDim2.new(0.05,0,0,y)
	Label.Size = UDim2.new(0.9,0,0,16)
	Label.BackgroundTransparency = 1
	Label.Text = title
	Label.TextColor3 = Color3.new(1,1,1)
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.Font = Enum.Font.Gotham
	Label.TextSize = 11

	local Box = Instance.new("TextBox")
	Box.Parent = Scroll
	Box.Position = UDim2.new(0.05,0,0,y+18)
	Box.Size = UDim2.new(0.9,0,0,28)
	Box.Text = value
	Box.BackgroundColor3 = Color3.fromRGB(35,35,50)
	Box.TextColor3 = Color3.new(1,1,1)
	Box.Font = Enum.Font.Gotham
	Box.TextSize = 13
	Instance.new("UICorner",Box)

end

CreateBox("Speed Control",35,"0")
CreateBox("Before Grab Speed",95,"38")
CreateBox("After Grab Speed",155,"38")

--------------------------------------------------
-- MODE LABEL
--------------------------------------------------

local ModeLabel = Instance.new("TextLabel")
ModeLabel.Parent = Scroll
ModeLabel.Position = UDim2.new(0.05,0,0,215)
ModeLabel.Size = UDim2.new(0.9,0,0,16)
ModeLabel.BackgroundTransparency = 1
ModeLabel.Text = "Autoplay Side Configuration"
ModeLabel.TextColor3 = Color3.new(1,1,1)
ModeLabel.TextXAlignment = Enum.TextXAlignment.Left
ModeLabel.Font = Enum.Font.Gotham
ModeLabel.TextSize = 11

--------------------------------------------------
-- MODE BUTTONS
--------------------------------------------------

local CurrentMode = "LEFT"

local LeftBtn = Instance.new("TextButton")
local RightBtn = Instance.new("TextButton")
local AutoBtn = Instance.new("TextButton")

local function StyleButton(btn)
	btn.Parent = Main
	btn.Size = UDim2.new(0,65,0,28)
	btn.BackgroundColor3 = Color3.fromRGB(35,35,50)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 11
	Instance.new("UICorner",btn)
end

StyleButton(LeftBtn)
StyleButton(RightBtn)
StyleButton(AutoBtn)

LeftBtn.Position = UDim2.new(0.05,0,0,240)
RightBtn.Position = UDim2.new(0.37,0,0,240)
AutoBtn.Position = UDim2.new(0.69,0,0,240)

LeftBtn.Text = "LEFT"
RightBtn.Text = "RIGHT"
AutoBtn.Text = "AUTO"

local function UpdateMode(mode)
	CurrentMode = mode

	LeftBtn.BackgroundColor3 = Color3.fromRGB(35,35,50)
	RightBtn.BackgroundColor3 = Color3.fromRGB(35,35,50)
	AutoBtn.BackgroundColor3 = Color3.fromRGB(35,35,50)

	if mode == "LEFT" then
		LeftBtn.BackgroundColor3 = Color3.fromRGB(130,70,255)
	elseif mode == "RIGHT" then
		RightBtn.BackgroundColor3 = Color3.fromRGB(130,70,255)
	else
		AutoBtn.BackgroundColor3 = Color3.fromRGB(130,70,255)
	end

	SideBtn.Text = mode
end

UpdateMode("LEFT")

LeftBtn.MouseButton1Click:Connect(function()
	UpdateMode("LEFT")
end)

RightBtn.MouseButton1Click:Connect(function()
	UpdateMode("RIGHT")
end)

AutoBtn.MouseButton1Click:Connect(function()
	UpdateMode("AUTO")
end)

--------------------------------------------------
-- TOGGLE PANEL
--------------------------------------------------

local ToggleLabel = Instance.new("TextLabel")
ToggleLabel.Parent = Scroll
ToggleLabel.Position = UDim2.new(0.05,0,0,280)
ToggleLabel.Size = UDim2.new(0.9,0,0,16)
ToggleLabel.BackgroundTransparency = 1
ToggleLabel.Text = "Toggle Panel"
ToggleLabel.TextColor3 = Color3.new(1,1,1)
ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
ToggleLabel.Font = Enum.Font.Gotham
ToggleLabel.TextSize = 11

local function CreateToggle(name,y)

	local state = false

	local Btn = Instance.new("TextButton")
	Btn.Parent = Main
	Btn.Position = UDim2.new(0.05,0,0,y)
	Btn.Size = UDim2.new(0.9,0,0,28)
	Btn.BackgroundColor3 = Color3.fromRGB(35,35,50)
	Btn.Text = name.." : OFF"
	Btn.TextColor3 = Color3.new(1,1,1)
	Btn.Font = Enum.Font.GothamBold
	Btn.TextSize = 11
	Instance.new("UICorner",Btn)

	Btn.MouseButton1Click:Connect(function()

		state = not state

		if state then
			Btn.Text = name.." : ON"
			Btn.BackgroundColor3 = Color3.fromRGB(130,70,255)
		else
			Btn.Text = name.." : OFF"
			Btn.BackgroundColor3 = Color3.fromRGB(35,35,50)
		end

	end)

end

CreateToggle("Infinite Jump",305)
CreateToggle("Auto Loop Steal",340)

--------------------------------------------------
-- MINIMIZE
--------------------------------------------------

MenuBtn.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
end)

--------------------------------------------------
-- DRAG FROM TITLE ONLY
--------------------------------------------------

local dragging = false
local dragStart
local startPos

TitleBar.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then

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
		input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch
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
