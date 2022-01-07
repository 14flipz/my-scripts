if not game:IsLoaded() then 
    game.Loaded:Wait() 
end

local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local RootPart = Character:FindFirstChild("HumanoidRootPart")
local Humanoid = Character:FindFirstChild("Humanoid")

local Main = {
    AutoFarm = {
        Enabled = false,
        Distance = 5,
        MobToFarm = nil
    }
}

local Config = {
    WindowName = "flipz hub",
    Color = Color3.fromRGB(40, 45, 85),
    Keybind = Enum.KeyCode.RightControl
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BracketV3.lua"))()
local Window = Library:CreateWindow(Config, game:GetService("CoreGui"))
local AutoFarmTab = Window:CreateTab("AutoFarm")
local UiTab = Window:CreateTab("UI Settings")
local AutoFarmSection = AutoFarmTab:CreateSection("AutoFarms")
local BackgroundSection = UiTab:CreateSection("Background")

local AutoFarmToggle = AutoFarmSection:CreateToggle("Auto Kill Mobs", nil, function(bool)
    Main.AutoFarm.Enabled = bool

    while Main.AutoFarm.Enabled do
        for _, Mob in pairs(game.Workspace.Mobs:GetChildren()) do
            if Mob.Name == Main.AutoFarm.MobToFarm or Main.AutoFarm.MobToFarm == "All" then
                while (Mob.Humanoid.Health ~= 0 or not Mob:IsDescendantOf(workspace)) do 
                    Mob.HumanoidRootPart.Anchored = true
                    RootPart.CFrame = Mob.HumanoidRootPart.CFrame - Mob.HumanoidRootPart.CFrame.LookVector * Main.AutoFarm.Distance
                    ReplicatedStorage.Events.attack:FireServer("Slash")
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.R, false, game)
                    task.wait(.06)
                    if Mob.Humanoid.Health == Mob.Humanoid.MaxHealth then
                        RootPart.CFrame = Mob.HumanoidRootPart.CFrame - Mob.HumanoidRootPart.CFrame.LookVector * 5
                        ReplicatedStorage.Events.attack:FireServer("Slash")
                        task.wait(0.3)
                    end
                end
            end
        end
        task.wait()
    end
end)

local AutoFarmDistance = AutoFarmSection:CreateSlider("Distance From Mob", 0, 35, nil, true, function(value)
    Main.AutoFarm.Distance = value
end)

local AutoFarmMobToFarm = AutoFarmSection:CreateDropdown("Mob To Farm", {"Grass Monster", "All"}, function(string)
    Main.AutoFarm.MobToFarm = string
end)

local ImageDropdown = BackgroundSection:CreateDropdown("Image", {"Default","Hearts","Abstract","Hexagon","Circles","Lace With Flowers","Floral"}, function(Name)
    if Name == "Default" then
        Window:SetBackground("2151741365")
    elseif Name == "Hearts" then
        Window:SetBackground("6073763717")
    elseif Name == "Abstract" then
        Window:SetBackground("6073743871")
    elseif Name == "Hexagon" then
        Window:SetBackground("6073628839")
    elseif Name == "Circles" then
        Window:SetBackground("6071579801")
    elseif Name == "Lace With Flowers" then
        Window:SetBackground("6071575925")
    elseif Name == "Floral" then
        Window:SetBackground("5553946656")
    end
end)


ImageDropdown:SetOption("Default")

local BackgroundColorpicker = BackgroundSection:CreateColorpicker("Color", function(Color)
    Window:SetBackgroundColor(Color)
end)
BackgroundColorpicker:UpdateColor(Color3.new(0,0,0))

local TransparencySlider = BackgroundSection:CreateSlider("Transparency",0,1,nil,false, function(Value)
    Window:SetBackgroundTransparency(Value)
end)
TransparencySlider:SetValue(0)

local TileScaleSlider = BackgroundSection:CreateSlider("Tile Scale",0,1,nil,false, function(Value)
    Window:SetTileScale(Value)
end)

TileScaleSlider:SetValue(0.85)
