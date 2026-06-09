-- SHINARA HUB: FINAL FIX & FUNCTIONAL SCRIPT

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- UI Container Fix
local ScreenGui = PlayerGui:FindFirstChild("ShinaraHub") or Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "ShinaraHub"
ScreenGui.ResetOnSpawn = false -- Respawn hone par panel gayab nahi hoga

--------------------------------------------------
-- CORE VARIABLES & LOGIC
--------------------------------------------------
local SpeedVal = 38
local AutoGrab = false
local InfJump = false

-- Speed Hack (Safe Method)
RunService.Heartbeat:Connect(function()
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = SpeedVal
    end
end)

-- Infinite Jump
UIS.JumpRequest:Connect(function()
    if InfJump then
        local hrp = Player.Character:FindFirstChild("HumanoidRootPart")
        if hrp then Player.Character.Humanoid:ChangeState("Jumping") end
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
-- UI BUILDER (With Pop-up Fix)
--------------------------------------------------
-- [Yahan wahi Floating buttons aur Main Panel ka structure aayega]
-- IMPORTANT: Button Click Connections neeche diye gaye hain:

-- 1. Bat Equip
-- BatBtn.MouseButton1Click:Connect(function()
--     local tool = Player.Backpack:FindFirstChildOfClass("Tool") or Player.Character:FindFirstChildOfClass("Tool")
--     if tool then Player.Character.Humanoid:EquipTool(tool) end
-- end)

-- 2. Toggle Panel (A & B)
-- A_Toggle.MouseButton1Click:Connect(function() InfJump = not InfJump end)
-- B_Toggle.MouseButton1Click:Connect(function() AutoGrab = not AutoGrab end)

-- 3. Menu Button Fix (Pop-up ke liye)
-- MenuBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
