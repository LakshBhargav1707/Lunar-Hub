-- [[ LakshByte - Custom Brainrot Steal Hub UI Wrapper ]] --

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

local Window = Library:CreateWindow({
   Name = "Lunar Hub | Brainrot Edition",
   LoadingTitle = "Loading System...",
   LoadingSubtitle = "by LakshByte",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "LunarHubConfig",
      FileName = "BrainrotConfig"
   }
})

local MainTab = Window:CreateTab("Main Cheats", 4483362458) -- Title tab

-- [[ VARIABLES FOR LOGIC ]] --
local Humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
local RootPart = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")

local Config = {
    NormalSpeed = 32,
    BeforeGrabSpeed = 30,
    AfterGrabSpeed = 30,
    SideSelection = "Left", -- Default Side
    PlayMode = "Autoplay", -- Default Mode
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
      if speed then
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

-- Dynamic Side Selection Button
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

-- Mode Toggle Button (Autoplay / Manual)
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
      
      -- Auto Loop Logic
      task.spawn(function()
          while Config.AutoLoopSteal do
              -- Speed update checking based on grabbing
              local hasBrainrot = game.Players.LocalPlayer.Character:FindFirstChild("Brainrot") -- Check tool name in game
              if hasBrainrot then
                  Humanoid.WalkSpeed = Config.AfterGrabSpeed
              else
                  Humanoid.WalkSpeed = Config.BeforeGrabSpeed
              end
              
              -- Teleportation/Movement based on Side Selection Panel
              if Config.PlayMode == "Autoplay" then
                  if Config.SideSelection == "Left" then
                      -- Tumhare game ka left corner position vector yahan aayega
                      -- RootPart.CFrame = CFrame.new(Left_X_Coord, Left_Y_Coord, Left_Z_Coord)
                  elseif Config.SideSelection == "Right" then
                      -- Tumhare game ka right corner position vector yahan aayega
                      -- RootPart.CFrame = CFrame.new(Right_X_Coord, Right_Y_Coord, Right_Z_Coord)
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
              local hasBrainrot = game.Players.LocalPlayer.Character:FindFirstChild("Brainrot")
              if hasBrainrot then
                  -- Find Nearest Player
                  for _, player in pairs(game.Players:GetPlayers()) do
                      if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                          local targetDist = (RootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                          if targetDist < 15 then -- Range to hit
                              -- Trigger your game's Bat Hit Remote or Tool Activation
                              local Bat = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                              if Bat then Bat:Activate() end
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

-- Services Connection for Infinite Jump
game:GetService("UserInputService").JumpRequest:Connect(function()
    if Config.InfiniteJump then
        Humanoid:ChangeState("Jumping")
    end
end)
