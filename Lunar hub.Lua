local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "LunarHub"
gui.ResetOnSpawn = false
gui.Parent = PlayerGui

local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0,220,0,300)
main.Position = UDim2.new(0.5,-110,0.5,-150)
main.BackgroundColor3 = Color3.fromRGB(22,22,32)
Instance.new("UICorner", main)

local title = Instance.new("TextLabel")
title.Parent = main
title.Size = UDim2.new(1,0,0,28)
title.BackgroundTransparency = 1
title.Text = "LUNAR HUB"
title.TextColor3 = Color3.fromRGB(170,85,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16

local function box(y, text, value)
	local lbl = Instance.new("TextLabel")
	lbl.Parent = main
	lbl.Position = UDim2.new(0.05,0,0,y)
	lbl.Size = UDim2.new(0.55,0,0,22)
	lbl.BackgroundTransparency = 1
	lbl.Text = text
	lbl.TextColor3 = Color3.new(1,1,1)
	lbl.Font = Enum.Font.Gotham
	lbl.TextSize = 12

	local tb = Instance.new("TextBox")
	tb.Parent = main
	tb.Position = UDim2.new(0.65,0,0,y)
	tb.Size = UDim2.new(0.25,0,0,22)
	tb.Text = value
	tb.BackgroundColor3 = Color3.fromRGB(35,35,50)
	tb.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner", tb)
end

box(35,"Speed","0")
box(65,"Before Speed","38")
box(95,"After Speed","38")

local selected = nil

local function modeButton(name,x)
	local b = Instance.new("TextButton")
	b.Parent = main
	b.Size = UDim2.new(0,60,0,25)
	b.Position = UDim2.new(0,x,0,130)
	b.Text = name
	b.BackgroundColor3 = Color3.fromRGB(40,40,55)
	b.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner", b)

	b.MouseButton1Click:Connect(function()
		for _,v in pairs(main:GetChildren()) do
			if v:IsA("TextButton") and (v.Text=="LEFT" or v.Text=="RIGHT" or v.Text=="MANUAL") then
				v.BackgroundColor3 = Color3.fromRGB(40,40,55)
			end
		end
		b.BackgroundColor3 = Color3.fromRGB(170,85,255)
		selected = name
	end)
end

modeButton("LEFT",10)
modeButton("RIGHT",80)
modeButton("MANUAL",150)

local function toggle(name,y)
	local state = false

	local b = Instance.new("TextButton")
	b.Parent = main
	b.Size = UDim2.new(0.9,0,0,28)
	b.Position = UDim2.new(0.05,0,0,y)
	b.BackgroundColor3 = Color3.fromRGB(35,35,50)
	b.Text = name.." : OFF"
	b.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner", b)

	b.MouseButton1Click:Connect(function()
		state = not state
		b.Text = name.." : "..(state and "ON" or "OFF")
		b.BackgroundColor3 = state and Color3.fromRGB(170,85,255) or Color3.fromRGB(35,35,50)
	end)
end

toggle("Toggle A",170)
toggle("Toggle B",205)
toggle("Toggle C",240)

local menu = Instance.new("TextButton")
menu.Parent = gui
menu.Size = UDim2.new(0,40,0,40)
menu.Position = UDim2.new(0,10,0.5,-20)
menu.Text = "☰"
menu.BackgroundColor3 = Color3.fromRGB(170,85,255)

local side1 = Instance.new("TextButton")
side1.Parent = gui
side1.Size = UDim2.new(0,40,0,40)
side1.Position = UDim2.new(0,10,0.5,30)
side1.Text = "A"

local side2 = Instance.new("TextButton")
side2.Parent = gui
side2.Size = UDim2.new(0,40,0,40)
side2.Position = UDim2.new(0,10,0.5,80)
side2.Text = "B"

menu.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)
