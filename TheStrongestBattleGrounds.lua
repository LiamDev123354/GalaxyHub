local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local SupaActive = false
local UppercutDetected = false
local Triggered = false

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "galaxy hub"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Position = UDim2.new(0.05, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 240, 0, 150)
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.Parent = MainFrame

local CreditLabel = Instance.new("TextLabel")
CreditLabel.Parent = MainFrame
CreditLabel.Size = UDim2.new(1, 0, 0.15, 0)
CreditLabel.Position = UDim2.new(0, 0, 0, 0)
CreditLabel.BackgroundTransparency = 1
CreditLabel.Text = "GALAXY HUB"
CreditLabel.TextColor3 = Color3.fromRGB(170, 130, 255)
CreditLabel.Font = Enum.Font.SourceSansBold
CreditLabel.TextSize = 16

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = MainFrame
StatusLabel.Position = UDim2.new(0, 0, 0.2, 0)
StatusLabel.Size = UDim2.new(1, 0, 0.2, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "SYSTEM: DISABLED"
StatusLabel.TextColor3 = Color3.fromRGB(255, 75, 75)
StatusLabel.Font = Enum.Font.SourceSansBold
StatusLabel.TextSize = 13

local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = MainFrame
ToggleButton.Position = UDim2.new(0.1, 0, 0.5, 0)
ToggleButton.Size = UDim2.new(0.8, 0, 0.3, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
ToggleButton.Text = "TURN ON SUPA TECH"
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 12

local UICorner2 = Instance.new("UICorner")
UICorner2.Parent = ToggleButton

local function getClosestEnemy()
    local closestPlayer = nil
    local shortestDistance = 164

    local myRoot = LocalPlayer.Character
        and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

    if not myRoot then
        return nil
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local enemyRoot = player.Character:FindFirstChild("HumanoidRootPart")
            local enemyHumanoid = player.Character:FindFirstChildOfClass("Humanoid")

            if enemyRoot and enemyHumanoid and enemyHumanoid.Health > 0 then
                local distance = (myRoot.Position - enemyRoot.Position).Magnitude

                if distance < shortestDistance then
                    shortestDistance = distance
                    closestPlayer = player
                end
            end
        end
    end

    return closestPlayer
end

local function runSupaHeadLoop()
    task.spawn(function()
        while SupaActive do
            local myChar = LocalPlayer.Character
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")

            if UppercutDetected and myRoot and not Triggered then
                local horizontalVelocity = Vector3.new(
                    myRoot.AssemblyLinearVelocity.X,
                    0,
                    myRoot.AssemblyLinearVelocity.Z
                ).Magnitude

                if horizontalVelocity > 35 then
                    Triggered = true
                    UppercutDetected = false

                    StatusLabel.Text = "SUPA LOCK ACTIVE!"
                    StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)

                    local startTime = tick()

                    while tick() - startTime < 1.2 and SupaActive do
                        local target = getClosestEnemy()

                        if target and target.Character and myRoot then
                            local enemyHead = target.Character:FindFirstChild("Head")
                            local enemyTorso = target.Character:FindFirstChild("Torso")
                                or target.Character:FindFirstChild("UpperTorso")

                            if enemyHead and enemyTorso then
                                local targetPosition = enemyTorso.Position:Lerp(enemyHead.Position, 0.5)
                                local targetLook = CFrame.lookAt(myRoot.Position, targetPosition)
                                local desiredPosition = targetPosition - (targetLook.LookVector * 3.2)

                                myRoot.CFrame = CFrame.lookAt(desiredPosition, targetPosition)

                                enemyTorso.AssemblyLinearVelocity = Vector3.new(0, 2.5, 0)
                                myRoot.AssemblyLinearVelocity = Vector3.new(0, 2.5, 0)
                            end
                        end

                        RunService.PostSimulation:Wait()
                    end

                    Triggered = false

                    if SupaActive then
                        StatusLabel.Text = "SYSTEM: ON (WAITING UPPERCUT)"
                        StatusLabel.TextColor3 = Color3.fromRGB(75, 255, 75)
                    end
                end
            end

            RunService.PostSimulation:Wait()
        end
    end)
end

task.spawn(function()
    while true do
        if SupaActive then
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")

            if hum then
                local animator = hum:FindFirstChildOfClass("Animator")

                if animator then
                    animator.AnimationPlayed:Connect(function(track)
                        local id = tostring(track.Animation.AnimationId)

                        if string.find(id, "1047")
                        or string.find(id, "125")
                        or string.find(id, "uppercut") then

                            UppercutDetected = true
                            Triggered = false

                            StatusLabel.Text = "UPPERCUT DETECTED!"
                            StatusLabel.TextColor3 = Color3.fromRGB(0, 240, 255)

                            task.delay(1.5, function()
                                if not Triggered then
                                    UppercutDetected = false

                                    if SupaActive then
                                        StatusLabel.Text = "SYSTEM: ON (WAITING UPPERCUT)"
                                        StatusLabel.TextColor3 = Color3.fromRGB(75, 255, 75)
                                    end
                                end
                            end)
                        end
                    end)
                end
            end
        end

        task.wait(0.4)
    end
end)

ToggleButton.MouseButton1Click:Connect(function()
    SupaActive = not SupaActive

    if SupaActive then
        StatusLabel.Text = "SYSTEM: ON (WAITING UPPERCUT)"
        StatusLabel.TextColor3 = Color3.fromRGB(75, 255, 75)

        ToggleButton.Text = "TURN OFF SUPA TECH"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)

        runSupaHeadLoop()
    else
        StatusLabel.Text = "SYSTEM: DISABLED"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 75, 75)

        ToggleButton.Text = "TURN ON SUPA TECH"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 180, 50)

        UppercutDetected = false
        Triggered = false
    end
end)
