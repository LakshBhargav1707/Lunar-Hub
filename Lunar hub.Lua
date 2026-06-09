-- SHINARA HUB: FINAL WORKING VERSION
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

-- Global Variables
local SpeedVal = 38
local AutoGrab = false
local InfJump = false

--------------------------------------------------
-- CORE MECHANISMS
--------------------------------------------------
-- Speed Management
RunService.Heartbeat:Connect(function()
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = SpeedVal
    end
end)

-- Infinite Jump
UIS.JumpRequest:Connect(function()
    if InfJump then
        Player.Character:FindFirstChild("Humanoid"):ChangeState("Jumping")
    end
end)

-- Auto Grab (Spam Tool)
RunService.RenderStepped:Connect(function()
    if AutoGrab then
        local char = Player.Character
        local tool = char and char:FindFirstChildOfClass("Tool")
        if tool then tool:Activate() end
    end
end)

--------------------------------------------------
-- UI SETUP (Merged)
--------------------------------------------------
-- (Floating buttons logic...)
-- [Baki UI code pehle jaisa rahega, bas button clicks mein ye actions add karein]

-- Box Focus Lost (Speed Update)
-- SpeedBox.FocusLost:Connect(function(enter) SpeedVal = tonumber(SpeedBox.Text) or 38 end)

-- Toggle Logic (Connections)
-- A_Toggle.MouseButton1Click:Connect(function() InfJump = not InfJump end)
-- B_Toggle.MouseButton1Click:Connect(function() AutoGrab = not AutoGrab end)

-- Bat Equipping Logic
local function EquipBat()
    local backpack = Player.Backpack
    local bat = backpack:FindFirstChildOfClass("Tool")
    if bat then bat.Parent = Player.Character end
end
-- BatBtn.MouseButton1Click:Connect(EquipBat)
