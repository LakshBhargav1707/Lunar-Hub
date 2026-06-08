-- [[ LakshByte - Custom Brainrot Steal Hub UI Wrapper ]] --
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

local Window = Library:CreateWindow({
   Name = "Lunar Hub | Brainrot Edition",
   LoadingTitle = "Loading System...",
   LoadingSubtitle = "by LakshByte",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = "LunarHubConfig",
      FileName = "BrainrotConfig"
   }
})

local MainTab = Window:CreateTab("Main Cheats", 4483362458)

-- [[ VARIABLES FOR LOGIC ]] --
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Character reset hone par variables auto-update honge
Player.CharacterAdded:Connect(function(NewChar)
    Character = NewChar
    Humanoid = NewChar:WaitForChild("Humanoid")
    RootPart = NewChar:WaitForChild("HumanoidRootPart")
end)

local Config = {
    NormalSpeed = 32,
    BeforeGrabSpeed = 30,
    AfterGrabSpeed = 30,
    SideSelection = "Left",
    PlayMode = "Autoplay",
    AutoLoopSteal = false,
    AutoBat = false,
    InfiniteJump = false
}

-- [[ 1. SPEED SECTION ]] --
MainTab:CreateSection("Speed Modifiers")

MainTab:CreateInput({
   Name = "WalkSpeed (Type Number)",
   PlaceholderText = "Default: 32",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      local speed = tonumber(Text)
      if speed and Humanoid then
          Config.NormalSpeed = speed
          Humanoid.WalkSpeed = speed
      end
   end,
})

MainTab:CreateInput({
   Name = "Before Grab Speed",
   PlaceholderText = "Default: 30",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      local speed = tonumber(Text)
      if speed then Config.BeforeGrabSpeed = speed end
   end,
})

MainTab:CreateInput({
   Name = "After Grab Speed",
   PlaceholderText = "Default: 30",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      local speed = tonumber(Text)
      if speed then Config.AfterGrabSpeed = speed end
   end,
})

-- [[ 2. SIDE SELECTION & MODE ]] --
MainTab:CreateSection("Side Selection & Mode")

local SideBtn
SideBtn = MainTab:CreateButton({
   Name = "Side Selection: LEFT",
   Callback = function()
      if Config.SideSelection == "Left" then
          Config.SideSelection = "Right"
          SideBtn:Set("Side Selection: RIGHT")
      else
          Config.SideSelection = "Left"
          SideBtn:Set("Side Selection: LEFT")
      end
   end,
})

local ModeBtn
ModeBtn = MainTab:CreateButton({
   Name = "Mode: Autoplay",
   Callback = function()
      if Config.PlayMode == "Autoplay" then
          Config.PlayMode = "Manual"
          ModeBtn:Set("Mode: Manual")
      else
          Config.PlayMode = "Autoplay"
          ModeBtn:Set("Mode: Autoplay")
      end
   end,
})

-- [[ 3. AUTOMATION LOOPS ]] --
MainTab:CreateSection("Automation")

MainTab:CreateToggle({
   Name = "Auto Loop Steal",
   CurrentValue = false,
   Flag = "AutoSteal",
   Callback = function(Value)
      Config.AutoLoopSteal = Value
      
      task.spawn(function()
          while Config.AutoLoopSteal do
              if Character and Humanoid then
                  -- Check tool named "Brainrot" or similar in Character
                  local hasBrainrot = Character:FindFirstChild("Brainrot") or Player.Backpack:FindFirstChild("Brainrot")
                  if hasBrainrot then
                      Humanoid.WalkSpeed = Config.AfterGrabSpeed
                  else
                      Humanoid.WalkSpeed = Config.BeforeGrabSpeed
                  end
                  
                  -- Autoplay corner movement logic
                  if Config.PlayMode == "Autoplay" and RootPart then
                      if Config.SideSelection == "Left" then
                          -- Left movement action (Ya toh walk ya halka teleport)
                          -- RootPart.CFrame = RootPart.CFrame * CFrame.new(-1, 0, 0)
                       Rhineif Config.SideSelection == "Right" then
                          -- Right movement action
                          -- RootPart.CFrame = RootPart.CFrame * CFrame.new(1, 0, 0)
                      end
                  end
              end
              task.wait(0.1)
          end
      end)
   end,
})

MainTab:CreateToggle({
   Name = "Auto Bat (Hit Players)",
   CurrentValue = false,
   Flag = "AutoBat",
   Callback = function(Value)
      Config.AutoBat = Value
      
      task.spawn(function()
          while Config.AutoBat do
              if Character and RootPart then
                  for _, player in pairs(game.Players:GetPlayers()) do
                      if player ~= Player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                          local targetRoot = player.Character.HumanoidRootPart
                          local targetDist = (RootPart.Position - targetRoot.Position).Magnitude
                          
                          if targetDist < 15 then 
                              local Tool = Character:FindFirstChildOfClass("Tool")
                              if Tool then 
                                  Tool:Activate() 
                              end
                          end
                      end
                  end
              end
              task.wait(0.2)
          end
      end)
   end,
})

-- [[ 4. INFINITE JUMP ]] --
MainTab:CreateSection("Movement Exploits")

MainTab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "InfJump",
   Callback = function(Value)
      Config.InfiniteJump = Value
   end,
})

game:GetService("UserInputService").JumpRequest:Connect(function()
    if Config.InfiniteJump and Humanoid then
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)
