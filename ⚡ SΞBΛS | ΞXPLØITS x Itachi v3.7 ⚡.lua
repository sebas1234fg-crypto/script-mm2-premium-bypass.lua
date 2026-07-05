-- ============================================================================= --
-- PANEL: SΞBΛS | ΞXPLØITS x Itachi v3.7 (Modern Toggle Switch - Waguri Style)   --
-- ============================================================================= --
local ScreenGui = Instance.new("ScreenGui")
local MainPanel = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local TitleText = Instance.new("TextLabel")
local MinimizeButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local TabBar = Instance.new("Frame")
local ContentFrame = Instance.new("Frame")
local TabCombat = Instance.new("TextButton")
local TabVisuals = Instance.new("TextButton")
local TabExploits = Instance.new("TextButton")
local TabConfig = Instance.new("TextButton")
local CombatFrame = Instance.new("ScrollingFrame")
local VisualsFrame = Instance.new("ScrollingFrame")
local ExploitsFrame = Instance.new("ScrollingFrame")
local ConfigFrame = Instance.new("ScrollingFrame")
local SliderLabel = Instance.new("TextLabel")
local SliderFrame = Instance.new("Frame")
local SliderButton = Instance.new("TextButton")
local RestoreButton = Instance.new("ImageButton")

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Identidad Visual del Panel
local PanelLogo = "rbxassetid://10723386348"

-- Estados globales de trucos
local espEnabled = false
local tracersEnabled = false
local ammoEnabled = false
local hitboxEnabled = false
local autoHoldEnabled = false
local sheathEnabled = false
local fakeLagEnabled = false
local noclipEnabled = false
local jumpEnabled = false
local speedEnabled = false
local brightEnabled = false
local clickShootEnabled = false
local radarEnabled = false
local overlayEnabled = false
local coinFarmEnabled = false
local freecamEnabled = false
local silentSheriffEnabled = false
local silentAsesinoEnabled = false
local invisibleEnabled = false
local animationEnabled = true
local killAllKnifeEnabled = false
local killAuraEnabled = false
local antiFlingEnabled = false
local autoDodgeEnabled = false
local knifeTrajectoryEnabled = false
local gunBeaconEnabled = false
local autoVoteEnabled = false
local antiAfkEnabled = false
local revealMurdererChatEnabled = false
local glitchSpotEnabled = false
local aimbotEnabled = false

-- Estados globales de configuración visual
local neonPulseEnabled = false
local globalTransparency = 0
local globalDarkness = 1.0 

-- CONTENEDORES FIJOS
local PlayerVisuals = {}
local radarFrame = nil
local originalCameraType = workspace.CurrentCamera.CameraType
local ghostCharacter = nil
local originalPosition = nil
local invisibleLoop = nil
local antiAfkConnection = nil
local beaconPart = nil
local activeFloaters = {}
local nodes = {}
local currentThemeColor = Color3.fromRGB(255, 30, 80)
local CianColor = Color3.fromRGB(0, 255, 255)

-- Diccionario para obtener el estado booleano de una función de manera dinámica
local function getTrucoState(functionName)
    if functionName == "clickShoot" then return clickShootEnabled
    elseif functionName == "killAllKnife" then return killAllKnifeEnabled
    elseif functionName == "killAura" then return killAuraEnabled
    elseif functionName == "autoDodge" then return autoDodgeEnabled
    elseif functionName == "antiFling" then return antiFlingEnabled
    elseif functionName == "aimbot" then return aimbotEnabled
    elseif functionName == "silentAsesino" then return silentAsesinoEnabled
    elseif functionName == "hitbox" then return hitboxEnabled
    elseif functionName == "autoHold" then return autoHoldEnabled
    elseif functionName == "sheath" then return sheathEnabled
    elseif functionName == "fakeLag" then return fakeLagEnabled
    elseif functionName == "esp" then return espEnabled
    elseif functionName == "tracers" then return tracersEnabled
    elseif functionName == "radar" then return radarEnabled
    elseif functionName == "ammo" then return ammoEnabled
    elseif functionName == "overlay" then return overlayEnabled
    elseif functionName == "knifeTrajectory" then return knifeTrajectoryEnabled
    elseif functionName == "gunBeacon" then return gunBeaconEnabled
    elseif functionName == "coinFarm" then return coinFarmEnabled
    elseif functionName == "noclip" then return noclipEnabled
    elseif functionName == "jump" then return jumpEnabled
    elseif functionName == "speed" then return speedEnabled
    elseif functionName == "bright" then return brightEnabled
    elseif functionName == "freecam" then return freecamEnabled
    elseif functionName == "invisible" then return invisibleEnabled
    elseif functionName == "autoVote" then return autoVoteEnabled
    elseif functionName == "antiAfk" then return antiAfkEnabled
    elseif functionName == "revealMurderer" then return revealMurdererChatEnabled
    elseif functionName == "glitchSpot" then return glitchSpotEnabled
    elseif functionName == "networkAnim" then return animationEnabled
    elseif functionName == "neonPulse" then return neonPulseEnabled
    end
    return false
end

local function createVisualsForPlayer(p)
    if p == LP then return end
    if PlayerVisuals[p] then return end
    local cache = { Highlight = nil, Tracer = nil, Blip = nil }
    local line = Instance.new("Frame")
    line.BorderSizePixel = 0
    line.AnchorPoint = Vector2.new(0.5, 0.5)
    line.Visible = false
    line.Parent = ScreenGui
    cache.Tracer = line
    PlayerVisuals[p] = cache
end

local function removeVisualsForPlayer(p)
    if PlayerVisuals[p] then
        if PlayerVisuals[p].Highlight then PlayerVisuals[p].Highlight:Destroy() end
        if PlayerVisuals[p].Tracer then PlayerVisuals[p].Tracer:Destroy() end
        if PlayerVisuals[p].Blip then PlayerVisuals[p].Blip:Destroy() end
        PlayerVisuals[p] = nil
    end
end

Players.PlayerAdded:Connect(createVisualsForPlayer)
Players.PlayerRemoving:Connect(removeVisualsForPlayer)
for _, p in pairs(Players:GetPlayers()) do createVisualsForPlayer(p) end

local function getMurderer()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Backpack:FindFirstChild("Knife") or (p.Character and p.Character:FindFirstChild("Knife")) then return p end
    end
    return nil
end

local function getSheriff()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Backpack:FindFirstChild("Gun") or (p.Character and p.Character:FindFirstChild("Gun")) then return p end
    end
    return nil
end

local function getAimbotTarget()
    local murderer = getMurderer()
    if murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") and murderer.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
        return murderer.Character.HumanoidRootPart
    end
    return nil
end

local success, err = pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
if not success then ScreenGui.Parent = LP:WaitForChild("PlayerGui") end
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

-- =============================================================================
-- INTERFAZ PRINCIPAL DEL MENÚ
-- =============================================================================
MainPanel.Name = "SebasMainPanel"
MainPanel.Parent = ScreenGui
MainPanel.BackgroundColor3 = Color3.fromRGB(18, 12, 14)
MainPanel.BackgroundTransparency = globalTransparency
MainPanel.Position = UDim2.new(0.25, 0, 0.15, 0)
MainPanel.Size = UDim2.new(0, 420, 0, 390)
MainPanel.Active = true
MainPanel.ClipsDescendants = true
MainPanel.Visible = false
local MainCorner = Instance.new("UICorner", MainPanel)
MainCorner.CornerRadius = UDim.new(0, 10)
local NeonBorder = Instance.new("UIStroke", MainPanel)
NeonBorder.Thickness = 4
NeonBorder.Color = currentThemeColor
NeonBorder.Transparency = 0.1

local function registrarArrastre(gui, activarCon)
    local dragging, dragInput, dragStart, startPos
    activarCon = activarCon or gui
    activarCon.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    activarCon.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end
registrarArrastre(MainPanel, TitleBar)

local NetworkBackground = Instance.new("Frame", MainPanel)
NetworkBackground.Name = "NetworkBackground"
NetworkBackground.Size = UDim2.new(1, 0, 1, 0)
NetworkBackground.BackgroundTransparency = 1
NetworkBackground.ZIndex = 1

local function toggleNetworkAnimation(state)
    animationEnabled = state
    if animationEnabled then
        if #nodes == 0 then
            for i = 1, 22 do
                local dot = Instance.new("Frame", NetworkBackground)
                dot.Size = UDim2.new(0, 6, 0, 6)
                dot.BackgroundColor3 = currentThemeColor
                dot.BorderSizePixel = 0
                dot.Position = UDim2.new(math.random(), 0, math.random(), 0)
                dot.ZIndex = 1
                Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
                table.insert(nodes, { Obj = dot, VelX = (math.random() - 0.5) * 0.005, VelY = (math.random() - 0.5) * 0.005 })
            end
        end
    else
        for _, node in ipairs(nodes) do if node.Obj then node.Obj:Destroy() end end
        table.clear(nodes)
    end
end

RunService.RenderStepped:Connect(function()
    if animationEnabled and MainPanel.Visible then
        for _, node in ipairs(nodes) do
            if node.Obj and node.Obj.Parent then
                local nextX = node.Obj.Position.X.Scale + node.VelX
                local nextY = node.Obj.Position.Y.Scale + node.VelY
                if nextX < 0 or nextX > 1 then node.VelX = -node.VelX end
                if nextY < 0 or nextY > 1 then node.VelY = -node.VelY end
                node.Obj.Position = UDim2.new(nextX, 0, nextY, 0)
                node.Obj.BackgroundColor3 = currentThemeColor
                node.Obj.BackgroundTransparency = globalTransparency
            end
        end
    end
end)

TitleBar.Name = "TitleBar"
TitleBar.Parent = MainPanel
TitleBar.BackgroundColor3 = Color3.fromRGB(28, 16, 20)
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.ZIndex = 2
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 10)

TitleText.Parent = TitleBar
TitleText.Size = UDim2.new(0.65, 0, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.Font = Enum.Font.FredokaOne
TitleText.RichText = true
TitleText.Text = '⚡ <font color="#FF0000">SΞBΛS | ΞXPLØITS</font> <font color="#000000">x</font> <font color="#A020F0">Itachi v3.7</font> ⚡'
TitleText.TextSize = 15
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.ZIndex = 3

MinimizeButton.Parent = TitleBar
MinimizeButton.Position = UDim2.new(0.78, 0, 0.15, 0)
MinimizeButton.Size = UDim2.new(0, 30, 0, 28)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(55, 35, 40)
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 16
MinimizeButton.ZIndex = 3
Instance.new("UICorner", MinimizeButton).CornerRadius = UDim.new(0, 6)

CloseButton.Parent = TitleBar
CloseButton.Position = UDim2.new(0.88, 0, 0.15, 0)
CloseButton.Size = UDim2.new(0, 35, 0, 28)
CloseButton.BackgroundColor3 = Color3.fromRGB(190, 30, 60)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14
CloseButton.ZIndex = 3
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 6)

TabBar.Name = "TabBar"
TabBar.Parent = MainPanel
TabBar.BackgroundColor3 = Color3.fromRGB(24, 14, 18)
TabBar.Position = UDim2.new(0, 0, 0, 40)
TabBar.Size = UDim2.new(0, 105, 1, -40)
TabBar.ZIndex = 2

ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainPanel
ContentFrame.BackgroundColor3 = Color3.fromRGB(20, 12, 15)
ContentFrame.BackgroundTransparency = globalDarkness
ContentFrame.Position = UDim2.new(0, 105, 0, 40)
ContentFrame.Size = UDim2.new(1, -105, 1, -40)
ContentFrame.ZIndex = 2

local function styleTabBtn(btn, text, yPos)
    btn.Parent = TabBar
    btn.Size = UDim2.new(0, 95, 0, 35)
    btn.Position = UDim2.new(0, 5, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(40, 25, 30)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.TextSize = 12
    btn.ZIndex = 3
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
end
styleTabBtn(TabCombat, "Combat", 10)
styleTabBtn(TabVisuals, "Visuals", 50)
styleTabBtn(TabExploits, "Exploits", 90)
styleTabBtn(TabConfig, "Config⚙️", 130)

local function setupSubFrame(frm)
    frm.Parent = ContentFrame
    frm.Size = UDim2.new(1, 0, 1, 0)
    frm.BackgroundTransparency = 1
    frm.ScrollBarThickness = 5
    frm.CanvasSize = UDim2.new(0, 0, 3.5, 0)
    frm.Visible = false
    frm.ZIndex = 3
end
setupSubFrame(CombatFrame)
setupSubFrame(VisualsFrame)
setupSubFrame(ExploitsFrame)
setupSubFrame(ConfigFrame)

CombatFrame.Visible = true
TabCombat.BackgroundColor3 = Color3.fromRGB(180, 20, 50)

local function switchTab(selectedFrame, selectedBtn)
    CombatFrame.Visible = false; VisualsFrame.Visible = false; ExploitsFrame.Visible = false; ConfigFrame.Visible = false
    TabCombat.BackgroundColor3 = Color3.fromRGB(40, 25, 30)
    TabVisuals.BackgroundColor3 = Color3.fromRGB(40, 25, 30)
    TabExploits.BackgroundColor3 = Color3.fromRGB(40, 25, 30)
    TabConfig.BackgroundColor3 = Color3.fromRGB(40, 25, 30)
    selectedFrame.Visible = true
    selectedBtn.BackgroundColor3 = Color3.fromRGB(180, 20, 50)
end

TabCombat.MouseButton1Click:Connect(function() switchTab(CombatFrame, TabCombat) end)
TabVisuals.MouseButton1Click:Connect(function() switchTab(VisualsFrame, TabVisuals) end)
TabExploits.MouseButton1Click:Connect(function() switchTab(ExploitsFrame, TabExploits) end)
TabConfig.MouseButton1Click:Connect(function() switchTab(ConfigFrame, TabConfig) end)

-- =============================================================================
-- MINIMIZAR Y RESTAURAR
-- =============================================================================
RestoreButton.Name = "SebasRestoreButton"
RestoreButton.Parent = ScreenGui
RestoreButton.Position = UDim2.new(0.05, 0, 0.3, 0)
RestoreButton.Size = UDim2.new(0, 65, 0, 65)
RestoreButton.BackgroundColor3 = Color3.fromRGB(18, 12, 14)
RestoreButton.BackgroundTransparency = 0.2
RestoreButton.Visible = false
RestoreButton.Image = "rbxassetid://99579616596711"
RestoreButton.ScaleType = Enum.ScaleType.Fit
local RestoreBorder = Instance.new("UIStroke", RestoreButton)
RestoreBorder.Thickness = 4
RestoreBorder.Color = currentThemeColor
RestoreBorder.Transparency = 0.1
local RestoreCorner = Instance.new("UICorner", RestoreButton)
RestoreCorner.CornerRadius = UDim.new(0, 12)
registrarArrastre(RestoreButton)

MinimizeButton.MouseButton1Click:Connect(function()
    local closeTween = TweenService:Create(MainPanel, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Size = UDim2.new(0, 420, 0, 2), BackgroundTransparency = 1 })
    closeTween:Play(); closeTween.Completed:Wait()
    MainPanel.Visible = false; RestoreButton.Visible = true; RestoreButton.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(RestoreButton, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = UDim2.new(0, 65, 0, 65) }):Play()
end)

RestoreButton.MouseButton1Click:Connect(function()
    local hideRestore = TweenService:Create(RestoreButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Size = UDim2.new(0, 0, 0, 0) })
    hideRestore:Play(); hideRestore.Completed:Wait(); RestoreButton.Visible = false
    MainPanel.Size = UDim2.new(0, 420, 0, 2); MainPanel.BackgroundTransparency = 1; MainPanel.Visible = true
    TweenService:Create(MainPanel, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = globalTransparency }):Play()
    TweenService:Create(MainPanel, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), { Size = UDim2.new(0, 420, 0, 390) }):Play()
end)

CloseButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- =============================================================================
-- INTRO CINEMÁTICA CON MARCA PERSONALIZADA v3.7
-- =============================================================================
local IntroContainer = Instance.new("Frame", ScreenGui)
IntroContainer.Name = "SebasIntroContainer"
IntroContainer.Size = UDim2.new(1, 0, 1, 0)
IntroContainer.BackgroundTransparency = 1
IntroContainer.ZIndex = 100
local IntroText = Instance.new("TextLabel", IntroContainer)
IntroText.BackgroundTransparency = 1
IntroText.Position = UDim2.new(0.5, 0, 0.5, 0)
IntroText.Size = UDim2.new(0, 0, 0, 0)
IntroText.AnchorPoint = Vector2.new(0.5, 0.5)
IntroText.RichText = true
IntroText.Text = '⚡ <font color="#FF0000">SΞBΛS | ΞXPLØITS</font> <font color="#000000">x</font> <font color="#A020F0">Itachi v3.7</font> ⚡'
IntroText.Font = Enum.Font.FredokaOne
IntroText.TextColor3 = Color3.fromRGB(255, 255, 255)
IntroText.TextSize = 1
IntroText.TextTransparency = 1
IntroText.ZIndex = 101
local UIStroke = Instance.new("UIStroke", IntroText)
UIStroke.Color = Color3.fromRGB(255, 255, 255)
UIStroke.Thickness = 3
UIStroke.Transparency = 1

task.spawn(function()
    task.wait(0.2)
    for i = 1, 2 do
        IntroText.TextTransparency = 0.3; UIStroke.Transparency = 0.3; task.wait(0.06)
        IntroText.TextTransparency = 1; UIStroke.Transparency = 1; task.wait(0.04)
    end
    IntroText.TextTransparency = 0; UIStroke.Transparency = 0
    local textTween = TweenService:Create(IntroText, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = UDim2.new(0, 800, 0, 100), TextSize = 36 })
    textTween:Play(); textTween.Completed:Wait(); task.wait(1.0)
    TweenService:Create(IntroText, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { TextTransparency = 1 }):Play()
    TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Transparency = 1 }):Play()
    task.wait(0.5); IntroContainer:Destroy()
    MainPanel.Size = UDim2.new(0, 420, 0, 2)
    MainPanel.Position = UDim2.new(0.25, 0, 0.35, 0)
    MainPanel.BackgroundTransparency = 1
    MainPanel.Visible = true
    TweenService:Create(MainPanel, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = globalTransparency }):Play()
    TweenService:Create(MainPanel, TweenInfo.new(1.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), { Size = UDim2.new(0, 420, 0, 390), Position = UDim2.new(0.25, 0, 0.15, 0) }):Play()
end)

-- LÓGICA SILENT SHERIFF ARREGLADA
local function dispararSilentSheriff()
    local char = LP.Character if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid") if not humanoid or humanoid.Health <= 0 then return end
    local gun = LP.Backpack:FindFirstChild("Gun") or char:FindFirstChild("Gun") if not gun then return end
    if gun.Parent == LP.Backpack then humanoid:EquipTool(gun) task.wait(0.55) end
    local murderer = getMurderer()
    if murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") then
        local targetPart = murderer.Character.HumanoidRootPart
        local targetPos = targetPart.Position + (targetPart.Velocity * 0.12)
        pcall(function() gun:Activate() end)
        local shootRemote = gun:FindFirstChild("Shoot")
        if shootRemote and shootRemote:IsA("RemoteEvent") then pcall(function() shootRemote:FireServer(targetPos) end) end
        pcall(function()
            local vim = game:GetService("VirtualInputManager")
            vim:SendMouseButtonEvent(0, 0, 0, true, game, 0) task.wait(0.02)
            vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
        end)
        pcall(function()
            for _, scr in pairs(gun:GetDescendants()) do
                if scr:IsA("LocalScript") or scr:IsA("ModuleScript") then
                    local env = getsenv(scr)
                    if env and env.OnActivated then env.OnActivated() elseif env and env.Shoot then env.Shoot(targetPos) end
                end
            end
        end)
    end
end

local function silentKill(targetPlayer)
    if not LP.Character or not LP.Character:FindFirstChild("Knife") then return end
    local knife = LP.Character.Knife
    if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local targetRoot = targetPlayer.Character.HumanoidRootPart
        local knifeHandle = knife:FindFirstChild("Handle")
        if knifeHandle and firetouchinterest then
            knife:Activate()
            firetouchinterest(targetRoot, knifeHandle, 0) task.wait()
            firetouchinterest(targetRoot, knifeHandle, 1)
        end
    end
end

-- =============================================================================
-- SISTEMA ACTUALIZADO DE ACCIONES Y ACTUALIZACIÓN VISUAL DE LOS TOGGLES
-- =============================================================================
local toggleVisualUpdates = {}
local floaterVisualUpdates = {}

local function updateToggleVisualState(functionName, state)
    if toggleVisualUpdates[functionName] then
        toggleVisualUpdates[functionName](state)
    end
    if floaterVisualUpdates[functionName] then
        floaterVisualUpdates[functionName](state)
    end
end

local function ejecutarAccionDeTruco(functionName)
    if functionName == "clickShoot" then
        clickShootEnabled = not clickShootEnabled
        updateToggleVisualState("clickShoot", clickShootEnabled)
    elseif functionName == "killAllKnife" then
        killAllKnifeEnabled = not killAllKnifeEnabled
        updateToggleVisualState("killAllKnife", killAllKnifeEnabled)
    elseif functionName == "teleportAsesino" then
        local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        local murderer = getMurderer()
        if root and murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") then
            root.CFrame = murderer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        end
    elseif functionName == "killAura" then
        killAuraEnabled = not killAuraEnabled
        updateToggleVisualState("killAura", killAuraEnabled)
    elseif functionName == "autoDodge" then
        autoDodgeEnabled = not autoDodgeEnabled
        updateToggleVisualState("autoDodge", autoDodgeEnabled)
    elseif functionName == "antiFling" then
        antiFlingEnabled = not antiFlingEnabled
        updateToggleVisualState("antiFling", antiFlingEnabled)
    elseif functionName == "aimbot" then
        aimbotEnabled = not aimbotEnabled
        updateToggleVisualState("aimbot", aimbotEnabled)
    elseif functionName == "shootMurder" then
        dispararSilentSheriff()
    elseif functionName == "silentAsesino" then
        silentAsesinoEnabled = not silentAsesinoEnabled
        updateToggleVisualState("silentAsesino", silentAsesinoEnabled)
    elseif functionName == "hitbox" then
        hitboxEnabled = not hitboxEnabled
        updateToggleVisualState("hitbox", hitboxEnabled)
    elseif functionName == "autoHold" then
        autoHoldEnabled = not autoHoldEnabled
        updateToggleVisualState("autoHold", autoHoldEnabled)
    elseif functionName == "sheath" then
        sheathEnabled = not sheathEnabled
        updateToggleVisualState("sheath", sheathEnabled)
    elseif functionName == "fakeLag" then
        fakeLagEnabled = not fakeLagEnabled
        updateToggleVisualState("fakeLag", fakeLagEnabled)
        settings().Network.IncomingReplicationLag = fakeLagEnabled and 1 or 0
    elseif functionName == "esp" then
        espEnabled = not espEnabled
        updateToggleVisualState("esp", espEnabled)
        if not espEnabled then for _, cache in pairs(PlayerVisuals) do if cache.Highlight then cache.Highlight.Enabled = false end end end
    elseif functionName == "tracers" then
        tracersEnabled = not tracersEnabled
        updateToggleVisualState("tracers", tracersEnabled)
        if not tracersEnabled then for _, cache in pairs(PlayerVisuals) do if cache.Tracer then cache.Tracer.Visible = false end end end
    elseif functionName == "ammo" then
        ammoEnabled = not ammoEnabled
        updateToggleVisualState("ammo", ammoEnabled)
    elseif functionName == "radar" then
        radarEnabled = not radarEnabled
        updateToggleVisualState("radar", radarEnabled)
        if radarEnabled then
            if not radarFrame then
                radarFrame = Instance.new("Frame", ScreenGui); radarFrame.Size = UDim2.new(0, 130, 0, 130); radarFrame.Position = UDim2.new(0, 15, 0, 160)
                radarFrame.BackgroundColor3 = Color3.fromRGB(12, 8, 10); radarFrame.BackgroundTransparency = 0.2; radarFrame.BorderSizePixel = 0
                Instance.new("UICorner", radarFrame).CornerRadius = UDim.new(0, 8)
                local rb = Instance.new("UIStroke", radarFrame); rb.Color = currentThemeColor; rb.Thickness = 1.5
                local centerDot = Instance.new("Frame", radarFrame); centerDot.Size = UDim2.new(0, 6, 0, 6); centerDot.Position = UDim2.new(0.5, -3, 0.5, -3); centerDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Instance.new("UICorner", centerDot).CornerRadius = UDim.new(1, 0)
            end
            radarFrame.Visible = true
        else
            if radarFrame then radarFrame.Visible = false; for _, cache in pairs(PlayerVisuals) do if cache.Blip then cache.Blip.Visible = false end end end
        end
    elseif functionName == "overlay" then
        overlayEnabled = not overlayEnabled
        updateToggleVisualState("overlay", overlayEnabled)
        if not overlayEnabled then
            for _, p in pairs(Players:GetPlayers()) do
                if p.Character and p.Character:FindFirstChild("Head") then
                    local tag = p.Character.Head:FindFirstChild("DeltaInfoTag"); if tag then tag:Destroy() end
                end
            end
        end
    elseif functionName == "knifeTrajectory" then
        knifeTrajectoryEnabled = not knifeTrajectoryEnabled
        updateToggleVisualState("knifeTrajectory", knifeTrajectoryEnabled)
    elseif functionName == "gunBeacon" then
        gunBeaconEnabled = not gunBeaconEnabled
        updateToggleVisualState("gunBeacon", gunBeaconEnabled)
        if not gunBeaconEnabled and beaconPart then beaconPart:Destroy(); beaconPart = nil end
    elseif functionName == "coinFarm" then
        coinFarmEnabled = not coinFarmEnabled
        updateToggleVisualState("coinFarm", coinFarmEnabled)
    elseif functionName == "noclip" then
        noclipEnabled = not noclipEnabled
        updateToggleVisualState("noclip", noclipEnabled)
    elseif functionName == "jump" then
        jumpEnabled = not jumpEnabled
        updateToggleVisualState("jump", jumpEnabled)
    elseif functionName == "speed" then
        speedEnabled = not speedEnabled
        updateToggleVisualState("speed", speedEnabled)
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.Humanoid.WalkSpeed = speedEnabled and 24 or 16
        end
    elseif functionName == "bright" then
        brightEnabled = not brightEnabled
        updateToggleVisualState("bright", brightEnabled)
        game:GetService("Lighting").Ambient = brightEnabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(128, 128, 128)
        game:GetService("Lighting").Brightness = brightEnabled and 2 or 1
    elseif functionName == "freecam" then
        freecamEnabled = not freecamEnabled
        updateToggleVisualState("freecam", freecamEnabled)
        local camera = workspace.CurrentCamera
        if freecamEnabled then
            originalCameraType = camera.CameraType; camera.CameraType = Enum.CameraType.Scriptable
        else
            camera.CameraType = originalCameraType; if LP.Character and LP.Character:FindFirstChild("Humanoid") then camera.CameraSubject = LP.Character.Humanoid end
        end
    elseif functionName == "invisible" then
        invisibleEnabled = not invisibleEnabled
        updateToggleVisualState("invisible", invisibleEnabled)
        local char = LP.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if invisibleEnabled then
            if root and char:FindFirstChild("Humanoid") then
                originalPosition = root.CFrame; char.Archivable = true
                local skyPlatform = Instance.new("Part", workspace); skyPlatform.Name = "SkyAnchor_Delta"; skyPlatform.Size = Vector3.new(12, 1, 12)
                skyPlatform.CFrame = CFrame.new(originalPosition.Position.X, 1000, originalPosition.Position.Z); skyPlatform.Anchored = true; skyPlatform.Transparency = 1
                ghostCharacter = char:Clone(); ghostCharacter.Name = "Ghost_Model"
                for _, part in pairs(ghostCharacter:GetDescendants()) do
                    if part:IsA("BasePart") then part.Transparency = 0.5; part.CanCollide = false elseif part:IsA("Decal") then part.Transparency = 0.5 end
                end
                ghostCharacter.Parent = workspace; workspace.CurrentCamera.CameraSubject = ghostCharacter:FindFirstChild("Humanoid"); root.CFrame = skyPlatform.CFrame + Vector3.new(0, 3, 0)
                invisibleLoop = RunService.Heartbeat:Connect(function()
                    if ghostCharacter and char and root and workspace:FindFirstChild("SkyAnchor_Delta") then
                        ghostCharacter.Humanoid:Move(char.Humanoid.MoveDirection, false)
                        if char.Humanoid.Jump then ghostCharacter.Humanoid.Jump = true end
                        if not char:FindFirstChildOfClass("Tool") then root.CFrame = workspace.SkyAnchor_Delta.CFrame + Vector3.new(0, 3, 0); root.Velocity = Vector3.new(0,0,0) else root.CFrame = ghostCharacter.HumanoidRootPart.CFrame end
                    end
                end)
            end
        else
            if invisibleLoop then invisibleLoop:Disconnect(); invisibleLoop = nil end
            if workspace:FindFirstChild("SkyAnchor_Delta") then workspace.SkyAnchor_Delta:Destroy() end
            if ghostCharacter then
                if root and ghostCharacter:FindFirstChild("HumanoidRootPart") then root.CFrame = ghostCharacter.HumanoidRootPart.CFrame end
                ghostCharacter:Destroy(); ghostCharacter = nil
            end
            if char and char:FindFirstChild("Humanoid") then workspace.CurrentCamera.CameraSubject = char.Humanoid end
        end
    elseif functionName == "autoVote" then
        autoVoteEnabled = not autoVoteEnabled
        updateToggleVisualState("autoVote", autoVoteEnabled)
    elseif functionName == "antiAfk" then
        antiAfkEnabled = not antiAfkEnabled
        updateToggleVisualState("antiAfk", antiAfkEnabled)
        if antiAfkEnabled then
            antiAfkConnection = LP.Idled:Connect(function()
                game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame); task.wait(1)
                game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end)
        else
            if antiAfkConnection then antiAfkConnection:Disconnect(); antiAfkConnection = nil end
        end
    elseif functionName == "revealMurderer" then
        revealMurdererChatEnabled = not revealMurdererChatEnabled
        updateToggleVisualState("revealMurderer", revealMurdererChatEnabled)
    elseif functionName == "glitchSpot" then
        glitchSpotEnabled = not glitchSpotEnabled
        updateToggleVisualState("glitchSpot", glitchSpotEnabled)
        local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        if root then
            if glitchSpotEnabled then
                originalPosition = root.CFrame; root.CFrame = CFrame.new(math.random(-5000, 5000), 2500, math.random(-5000, 5000))
                local p = Instance.new("Part", workspace); p.Name = "GlitchPlatform"; p.Size = Vector3.new(15, 1, 15); p.CFrame = root.CFrame - Vector3.new(0, 3, 0); p.Anchored = true
            else
                if workspace:FindFirstChild("GlitchPlatform") then workspace.GlitchPlatform:Destroy() end; if originalPosition then root.CFrame = originalPosition end
            end
        end
    elseif functionName == "networkAnim" then
        local state = not animationEnabled; toggleNetworkAnimation(state)
        updateToggleVisualState("networkAnim", state)
    elseif functionName == "teleportPistola" then
        local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") if not root then return end
        local targetGunDrop = nil
        for _, obj in pairs(workspace:GetDescendants()) do
            if (obj.Name == "GunDrop" or obj.Name == "Gun") and not obj:IsDescendantOf(LP.Character) then
                local isPlayerWeapon = false
                for _, player in pairs(Players:GetPlayers()) do if player.Character and obj:IsDescendantOf(player.Character) then isPlayerWeapon = true; break end end
                if not isPlayerWeapon and (obj:IsA("BasePart") or obj:IsA("Model")) then targetGunDrop = obj; break end
            end
        end
        if targetGunDrop then
            local gunCFrame = targetGunDrop:IsA("BasePart") and targetGunDrop.CFrame or (targetGunDrop.PrimaryPart and targetGunDrop.PrimaryPart.CFrame or (targetGunDrop:FindFirstChild("Handle") and targetGunDrop.Handle.CFrame))
            if gunCFrame then
                local sPos = root.CFrame; root.CFrame = gunCFrame; task.wait(0.12)
                if root and LP.Character:FindFirstChildOfClass("Humanoid").Health > 0 then root.CFrame = sPos end
            end
        end
    elseif functionName == "suicidio" then
        local h = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") if h then h.Health = 0 end
    elseif functionName == "neonPulse" then
        neonPulseEnabled = not neonPulseEnabled
        updateToggleVisualState("neonPulse", neonPulseEnabled)
    end
end

-- ANIMACIÓN: EFECTO PULSO NEÓN COMPLETO SINCRO
RunService.RenderStepped:Connect(function()
    if neonPulseEnabled then
        local speed = 4
        local alpha = (math.sin(tick() * speed) + 1) / 2
        local currentTransparency = math.clamp(alpha, 0.05, 0.6)
        if MainPanel.Visible then NeonBorder.Transparency = currentTransparency end
        if RestoreButton.Visible then RestoreBorder.Transparency = currentTransparency end
    else
        NeonBorder.Transparency = 0.1
        RestoreBorder.Transparency = 0.1
    end
end)

-- =============================================================================
-- SISTEMA FLOTANTE INTEGRADO CON INTERRUPTORES (BOLITA Y PISTA)
-- =============================================================================
local function setupFloatingSystem(mainTriggerFrame, functionName, titleText)
    local pressID = 0
    mainTriggerFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            pressID = pressID + 1
            local currentID = pressID
            task.wait(0.8)
            if pressID == currentID then
                local existingFloater = activeFloaters[mainTriggerFrame]
                if existingFloater and existingFloater.Parent then
                    existingFloater:Destroy()
                    floaterVisualUpdates[functionName] = nil
                    activeFloaters[mainTriggerFrame] = nil
                else
                    -- Crear el contenedor flotante interactivo (Modern Waguri Switch Mini)
                    local floatContainer = Instance.new("Frame", ScreenGui)
                    floatContainer.BackgroundColor3 = Color3.fromRGB(32, 18, 22)
                    floatContainer.Active = true
                    Instance.new("UICorner", floatContainer).CornerRadius = UDim.new(0, 8)
                    floatContainer.Size = UDim2.new(0, 165, 0, 36)
                    floatContainer.Position = UDim2.new(0.4, 0, 0.4, 0)
                    local s = Instance.new("UIStroke", floatContainer)
                    s.Color = currentThemeColor; s.Thickness = 1.5
                    
                    local lbl = Instance.new("TextLabel", floatContainer)
                    lbl.Size = UDim2.new(0, 110, 1, 0)
                    lbl.Position = UDim2.new(0, 8, 0, 0)
                    lbl.BackgroundTransparency = 1
                    lbl.Font = Enum.Font.GothamBold
                    lbl.Text = "📌 " .. titleText
                    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
                    lbl.TextSize = 10
                    lbl.TextXAlignment = Enum.TextXAlignment.Left
                    
                    -- Pista del Interruptor Flotante
                    local track = Instance.new("Frame", floatContainer)
                    track.Size = UDim2.new(0, 32, 0, 16)
                    track.Position = UDim2.new(1, -40, 0.5, -8)
                    track.BackgroundColor3 = Color3.fromRGB(50, 40, 45)
                    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)
                    
                    -- Bolita del Interruptor Flotante
                    local ball = Instance.new("Frame", track)
                    ball.Size = UDim2.new(0, 12, 0, 12)
                    ball.Position = UDim2.new(0, 2, 0.5, -6)
                    ball.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Instance.new("UICorner", ball).CornerRadius = UDim.new(1, 0)
                    
                    local touch = Instance.new("TextButton", floatContainer)
                    touch.Size = UDim2.new(1, 0, 1, 0)
                    touch.BackgroundTransparency = 1
                    touch.Text = ""
                    touch.ZIndex = 12
                    
                    registrarArrastre(floatContainer, touch)
                    
                    -- Lógica de actualización visual para este flotante específico
                    local function updateMiniVisual(isEnabled)
                        local targetPos = isEnabled and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
                        local targetColor = isEnabled and currentThemeColor or Color3.fromRGB(50, 40, 45)
                        TweenService:Create(ball, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = targetPos }):Play()
                        TweenService:Create(track, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundColor3 = targetColor }):Play()
                    end
                    
                    -- Inicializar visual según estado actual
                    local inicialState = getTrucoState(functionName)
                    updateMiniVisual(inicialState)
                    
                    floaterVisualUpdates[functionName] = updateMiniVisual
                    
                    touch.MouseButton1Click:Connect(function()
                        ejecutarAccionDeTruco(functionName)
                    end)
                    
                    activeFloaters[mainTriggerFrame] = floatContainer
                end
                pressID = 0
            end
        end
    end)
    mainTriggerFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if pressID ~= 0 then
                pressID = 0
                ejecutarAccionDeTruco(functionName)
            end
        end
    end)
end

-- =============================================================================
-- CREADOR DE COMPONENTES VISUALES MODERNOS (ESTILO INTERFAZ WAGURI)
-- =============================================================================
local function createModernToggle(parent, functionName, title, description, yPos)
    local Container = Instance.new("Frame")
    local TitleLabel = Instance.new("TextLabel")
    local DescLabel = Instance.new("TextLabel")
    local SwitchTrack = Instance.new("Frame")
    local SwitchBall = Instance.new("Frame")
    local TouchButton = Instance.new("TextButton")
    
    Container.Name = functionName .. "_ToggleContainer"
    Container.Parent = parent
    Container.Size = UDim2.new(0, 280, 0, 48)
    Container.Position = UDim2.new(0, 12, 0, yPos)
    Container.BackgroundColor3 = Color3.fromRGB(28, 18, 22)
    Container.BorderSizePixel = 0
    Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 8)
    
    TitleLabel.Parent = Container
    TitleLabel.Size = UDim2.new(0.7, 0, 0.5, 0)
    TitleLabel.Position = UDim2.new(0, 10, 0, 6)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Color3.fromRGB(245, 245, 245)
    TitleLabel.TextSize = 12
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.ZIndex = 4
    
    DescLabel.Parent = Container
    DescLabel.Size = UDim2.new(0.7, 0, 0.4, 0)
    DescLabel.Position = UDim2.new(0, 10, 0, 24)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Font = Enum.Font.SourceSans
    DescLabel.Text = description
    DescLabel.TextColor3 = Color3.fromRGB(150, 140, 145)
    DescLabel.TextSize = 11
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.ZIndex = 4
    
    SwitchTrack.Parent = Container
    SwitchTrack.Size = UDim2.new(0, 38, 0, 20)
    SwitchTrack.Position = UDim2.new(1, -48, 0.5, -10)
    SwitchTrack.BackgroundColor3 = Color3.fromRGB(50, 40, 45)
    SwitchTrack.BorderSizePixel = 0
    Instance.new("UICorner", SwitchTrack).CornerRadius = UDim.new(1, 0)
    SwitchTrack.ZIndex = 4
    
    SwitchBall.Parent = SwitchTrack
    SwitchBall.Size = UDim2.new(0, 14, 0, 14)
    SwitchBall.Position = UDim2.new(0, 3, 0.5, -7)
    SwitchBall.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SwitchBall.BorderSizePixel = 0
    Instance.new("UICorner", SwitchBall).CornerRadius = UDim.new(1, 0)
    SwitchBall.ZIndex = 5
    
    TouchButton.Parent = Container
    TouchButton.Size = UDim2.new(1, 0, 1, 0)
    TouchButton.BackgroundTransparency = 1
    TouchButton.Text = ""
    TouchButton.ZIndex = 10
    
    setupFloatingSystem(TouchButton, functionName, title)
    
    toggleVisualUpdates[functionName] = function(isEnabled)
        local targetPos = isEnabled and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
        local targetColor = isEnabled and currentThemeColor or Color3.fromRGB(50, 40, 45)
        TweenService:Create(SwitchBall, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = targetPos }):Play()
        TweenService:Create(SwitchTrack, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundColor3 = targetColor }):Play()
    end
end

local function createModernActionClick(parent, functionName, title, description, yPos)
    local Container = Instance.new("Frame")
    local TitleLabel = Instance.new("TextLabel")
    local DescLabel = Instance.new("TextLabel")
    local ActionIcon = Instance.new("TextLabel")
    local TouchButton = Instance.new("TextButton")
    
    Container.Name = functionName .. "_ClickContainer"
    Container.Parent = parent
    Container.Size = UDim2.new(0, 280, 0, 48)
    Container.Position = UDim2.new(0, 12, 0, yPos)
    Container.BackgroundColor3 = Color3.fromRGB(36, 16, 22)
    Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 8)
    local b = Instance.new("UIStroke", Container); b.Color = Color3.fromRGB(80, 30, 40); b.Thickness = 1
    
    TitleLabel.Parent = Container; TitleLabel.Size = UDim2.new(0.7, 0, 0.5, 0); TitleLabel.Position = UDim2.new(0, 10, 0, 6); TitleLabel.BackgroundTransparency = 1
    TitleLabel.Font = Enum.Font.GothamBold; TitleLabel.Text = title; TitleLabel.TextColor3 = Color3.fromRGB(255, 200, 210); TitleLabel.TextSize = 12; TitleLabel.TextXAlignment = Enum.TextXAlignment.Left; TitleLabel.ZIndex = 4
    
    DescLabel.Parent = Container; DescLabel.Size = UDim2.new(0.7, 0, 0.4, 0); DescLabel.Position = UDim2.new(0, 10, 0, 24); DescLabel.BackgroundTransparency = 1
    DescLabel.Font = Enum.Font.SourceSans; DescLabel.Text = description; DescLabel.TextColor3 = Color3.fromRGB(180, 150, 155); DescLabel.TextSize = 11; DescLabel.TextXAlignment = Enum.TextXAlignment.Left; DescLabel.ZIndex = 4
    
    ActionIcon.Parent = Container; ActionIcon.Size = UDim2.new(0, 30, 0, 30); ActionIcon.Position = UDim2.new(1, -40, 0.5, -15); ActionIcon.BackgroundTransparency = 1
    ActionIcon.Font = Enum.Font.GothamBold; ActionIcon.Text = "⚡"; ActionIcon.TextColor3 = Color3.fromRGB(255, 230, 0); ActionIcon.TextSize = 16; ActionIcon.ZIndex = 4
    
    TouchButton.Parent = Container
    TouchButton.Size = UDim2.new(1, 0, 1, 0)
    TouchButton.BackgroundTransparency = 1
    TouchButton.Text = ""
    TouchButton.ZIndex = 10 
    
    TouchButton.MouseButton1Click:Connect(function()
        ejecutarAccionDeTruco(functionName)
    end)
end

-- =============================================================================
-- SECCIÓN DE ASIGNACIÓN DE CONTROLES
-- =============================================================================
-- COMBAT FRAME (Y-GAP: 54)
createModernActionClick(CombatFrame, "shootMurder", "💥 Disparar Asesino Ahora", "Ejecuta un disparo certero inmediato de forma silenciosa.", 10)
createModernToggle(CombatFrame, "silentAsesino", "Silent Asesino Masivo", "Mata de forma silenciosa a todos estando parado.", 64)
createModernToggle(CombatFrame, "clickShoot", "Clic para Disparar", "Dispara automáticamente al hacer clic en pantalla.", 118)
createModernToggle(CombatFrame, "killAllKnife", "Kill All Teleport", "Hará teletransporte consecutivo rápido matando a todos.", 172)
createModernActionClick(CombatFrame, "teleportAsesino", "Teleport al Asesino", "Te posiciona por encima de la ubicación del asesino.", 226)
createModernToggle(CombatFrame, "killAura", "Silent Kill Aura", "Activa el aura automática expansiva sobre enemigos.", 280)
createModernToggle(CombatFrame, "autoDodge", "Auto-Dodge Predictivo", "Esquiva cuchillos lanzados calculando el ping.", 334)
createModernToggle(CombatFrame, "antiFling", "Estabilizador Anti-Fling", "Previene que mueras a causa de bloqueos de colisión.", 388)
createModernActionClick(CombatFrame, "teleportPistola", "Teleport a Pistola Tirada", "Te lleva hacia la ubicación de la pistola caída en el mapa.", 442)
createModernToggle(CombatFrame, "hitbox", "Agrandar Hitbox Cuchillo", "Expande de forma masiva el rango físico de daño.", 496)
createModernToggle(CombatFrame, "autoHold", "Auto-Equipar Armas", "Mantiene las herramientas en mano de forma automática.", 550)
createModernToggle(CombatFrame, "sheath", "Auto-Esconder Cuchillo", "Guarda el arma rápidamente de forma táctica.", 604)
createModernToggle(CombatFrame, "fakeLag", "Lag Táctico (FakeLag)", "Genera un retraso falso de red para desorientar.", 658)
createModernToggle(CombatFrame, "aimbot", "Safe Aimbot Sheriff", "Fija la cámara automáticamente hacia el enemigo.", 712)

-- VISUALS FRAME
createModernToggle(VisualsFrame, "esp", "Ver Roles (ESP)", "Muestra marcos resaltados de color según rol de jugador sin parpadeos.", 10)
createModernToggle(VisualsFrame, "tracers", "Líneas de Rastreo (Tracers)", "Dibuja guías vectoriales desde tu posición a los rivales.", 64)
createModernToggle(VisualsFrame, "radar", "Radar 2D Portátil", "Habilita una pantalla de radar bidimensional en esquina.", 118)
createModernToggle(VisualsFrame, "ammo", "Rastreador de Balas Sheriff", "Indica de forma visual si la ronda de tiro está lista.", 172)
createModernToggle(VisualsFrame, "overlay", "Info sobre Cabeza", "Coloca un recuadro de texto informativo flotante.", 226)
createModernToggle(VisualsFrame, "knifeTrajectory", "Visor Trayectoria Láser", "Proyecta una trayectoria lineal simulada de disparo.", 280)
createModernToggle(VisualsFrame, "gunBeacon", "Faro Luz Pistola Tirada", "Emite un haz lumínico vertical permanente sobre el drop.", 334)

-- EXPLOITS FRAME
createModernToggle(ExploitsFrame, "coinFarm", "Auto-Farm Monedas", "Colecciona monedas del mapa de manera automatizada.", 10)
createModernToggle(ExploitsFrame, "noclip", "Noclip (Paredes)", "Elimina colisiones de tu cuerpo para atravesar muros.", 64)
createModernToggle(ExploitsFrame, "jump", "Salto Infinito", "Habilita la capacidad de saltar suspendido en el aire.", 118)
createModernToggle(ExploitsFrame, "speed", "Velocidad x1.5 (no usar con noclip)", "Aumenta el paso de caminata seguro a x1.5 de velocidad base.", 172)
createModernToggle(ExploitsFrame, "bright", "Brillo Total (FullBright)", "Remueve la oscuridad ambiental iluminando el entorno.", 226)
createModernToggle(ExploitsFrame, "freecam", "Cámara Libre Invisible", "Separa tu punto de vista de tu avatar de forma oculta.", 280)
createModernToggle(ExploitsFrame, "invisible", "Modo Invisible (Fantasma)", "Clona tu avatar mientras te vuelves inlocalizable.", 334)
createModernToggle(ExploitsFrame, "autoVote", "Voto de Mapa Fantasma", "Emite sufragios automáticos aleatorios de mapas.", 388)
createModernToggle(ExploitsFrame, "antiAfk", "Anti-AFK Desconexión", "Elude el temporizador de inactividad nativo de Roblox.", 442)
createModernToggle(ExploitsFrame, "revealMurderer", "Revelar Asesino (Chat)", "Notifica de forma abierta la identidad del atacante.", 496)
createModernToggle(ExploitsFrame, "glitchSpot", "Modo Escondite Glitch", "Te aloja en una zona del vacío fuera de alcance.", 550)
createModernToggle(ExploitsFrame, "networkAnim", "Animación de Red", "Alterna los procesos de renderizado de nodos de fondo.", 604)
createModernActionClick(ExploitsFrame, "suicidio", "Suicidio de Emergencia", "Forza el restablecimiento de salud de tu personaje.", 658)

-- CONFIG FRAME
createModernToggle(ConfigFrame, "neonPulse", "Efecto Neón Pulsante", "Hace que el borde de la interfaz destelle armónicamente.", 10)

-- SLIDERS DE PERSONALIZACIÓN
SliderLabel.Parent = ConfigFrame; SliderLabel.Size = UDim2.new(0, 280, 0, 15); SliderLabel.Position = UDim2.new(0, 12, 0, 75); SliderLabel.ZIndex = 4
SliderLabel.BackgroundTransparency = 1; SliderLabel.Text = "Tono de Color del Tema:"; SliderLabel.TextColor3 = Color3.fromRGB(220, 220, 220); SliderLabel.TextSize = 11; SliderLabel.TextXAlignment = Enum.TextXAlignment.Left

SliderFrame.Parent = ConfigFrame; SliderFrame.Size = UDim2.new(0, 280, 0, 12); SliderFrame.Position = UDim2.new(0, 12, 0, 95); SliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50); SliderFrame.ZIndex = 4
Instance.new("UICorner", SliderFrame).CornerRadius = UDim.new(0, 4)

SliderButton.Parent = SliderFrame; SliderButton.Size = UDim2.new(0, 20, 1, 0); SliderButton.Position = UDim2.new(0, 0, 0, 0); SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255); SliderButton.Text = ""; SliderButton.ZIndex = 5
Instance.new("UICorner", SliderButton).CornerRadius = UDim.new(0, 4)

local draggingColor = false
local function updateSliderColor(input)
    local relativeX = input.Position.X - SliderFrame.AbsolutePosition.X
    local percentage = math.clamp(relativeX / SliderFrame.AbsoluteSize.X, 0, 1)
    SliderButton.Position = UDim2.new(percentage, -10, 0, 0)
    currentThemeColor = Color3.fromHSV(percentage, 1, 1)
    NeonBorder.Color = currentThemeColor
    RestoreBorder.Color = currentThemeColor
end

SliderButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingColor = true end
end)
UserInputService.InputChanged:Connect(function(input)
    if draggingColor and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then updateSliderColor(input) end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingColor = false end
end)

local TransLabel = Instance.new("TextLabel", ConfigFrame); TransLabel.Size = UDim2.new(0, 280, 0, 15); TransLabel.Position = UDim2.new(0, 12, 0, 125); TransLabel.BackgroundTransparency = 1; TransLabel.Text = "Transparencia del Menú:"; TransLabel.TextColor3 = Color3.fromRGB(220, 220, 220); TransLabel.TextSize = 11; TransLabel.TextXAlignment = Enum.TextXAlignment.Left; TransLabel.ZIndex = 4
local TransFrame = Instance.new("Frame", ConfigFrame); TransFrame.Size = UDim2.new(0, 280, 0, 12); TransFrame.Position = UDim2.new(0, 12, 0, 145); TransFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50); TransFrame.ZIndex = 4; Instance.new("UICorner", TransFrame).CornerRadius = UDim.new(0, 4)
local TransButton = Instance.new("TextButton", TransFrame); TransButton.Size = UDim2.new(0, 20, 1, 0); TransButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255); TransButton.Text = ""; TransButton.ZIndex = 5; Instance.new("UICorner", TransButton).CornerRadius = UDim.new(0, 4)

local draggingTrans = false
TransButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingTrans = true end
end)
UserInputService.InputChanged:Connect(function(input)
    if draggingTrans and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local relativeX = input.Position.X - TransFrame.AbsolutePosition.X
        local percentage = math.clamp(relativeX / TransFrame.AbsoluteSize.X, 0, 1)
        TransButton.Position = UDim2.new(percentage, -10, 0, 0)
        globalTransparency = percentage
        MainPanel.BackgroundTransparency = globalTransparency
        TitleBar.BackgroundTransparency = globalTransparency
        TabBar.BackgroundTransparency = globalTransparency
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingTrans = false end
end)

-- =============================================================================
-- PROCESOS OPERATIVOS DEL JUEGO
-- =============================================================================
local jugadoresEliminados = {}
workspace.ChildAdded:Connect(function(c) if c.Name == "Normal" or c.Name == "Map" then table.clear(jugadoresEliminados) end end)

UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and clickShootEnabled and input.UserInputType == Enum.UserInputType.MouseButton1 then
        local gun = LP.Character and LP.Character:FindFirstChild("Gun") if gun then gun:Activate() end
    end
end)

RunService.Heartbeat:Connect(function()
    if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        local myRoot = LP.Character.HumanoidRootPart
        local knife = LP.Character:FindFirstChild("Knife")
        if knife then
            if silentAsesinoEnabled then
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LP and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local tHum = player.Character:FindFirstChildOfClass("Humanoid")
                        if tHum and tHum.Health > 0 then silentKill(player) end
                    end
                end
            elseif killAllKnifeEnabled then
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LP and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local tHum = player.Character:FindFirstChildOfClass("Humanoid")
                        if tHum and tHum.Health > 0 and not jugadoresEliminados[player.Name] then
                            myRoot.CFrame = player.Character.HumanoidRootPart.CFrame
                            knife:Activate(); jugadoresEliminados[player.Name] = true; task.wait(0.05)
                        end
                    end
                end
            elseif killAuraEnabled then
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LP and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local tHum = player.Character:FindFirstChildOfClass("Humanoid")
                        if tHum and tHum.Health > 0 and (player.Character.HumanoidRootPart.Position - myRoot.Position).Magnitude <= 22 then
                            knife:Activate()
                            if firetouchinterest then firetouchinterest(player.Character.HumanoidRootPart, knife.Handle, 0) firetouchinterest(player.Character.HumanoidRootPart, knife.Handle, 1) end
                        end
                    end
                end
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if autoDodgeEnabled and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        local myRoot = LP.Character.HumanoidRootPart
        local m = getMurderer()
        if m and m.Character and m.Character:FindFirstChild("HumanoidRootPart") then
            local murdererRoot = m.Character.HumanoidRootPart
            local knife = m.Character:FindFirstChild("Knife") or m.Backpack:FindFirstChild("Knife")
            local distance = (murdererRoot.Position - myRoot.Position).Magnitude
            if knife then
                local velocityFactor = murdererRoot.Velocity.Magnitude * 0.45
                local safetyRadius = math.clamp(14 + velocityFactor, 14, 28)
                if distance <= safetyRadius then
                    local backstep = -murdererRoot.CFrame.LookVector * 24
                    local sideStep = murdererRoot.CFrame.RightVector * (math.random(0, 1) == 0 and 18 or -18)
                    myRoot.CFrame = myRoot.CFrame + backstep + sideStep + Vector3.new(0, 8, 0)
                    myRoot.Velocity = Vector3.new(0, 0, 0)
                end
            end
        end
        for _, obj in pairs(workspace:GetChildren()) do
            if (obj.Name == "Knife" or obj.Name == "ThrownKnife" or obj:FindFirstChild("KnifeVisual")) and obj:IsA("BasePart") then
                local knifeDist = (obj.Position - myRoot.Position).Magnitude
                if knifeDist <= 65 then
                    local cam = workspace.CurrentCamera
                    local escapeDirection = cam.CFrame.RightVector * (math.random(0, 1) == 0 and 32 or -32)
                    myRoot.CFrame = myRoot.CFrame + escapeDirection + Vector3.new(0, 12, 0)
                    myRoot.Velocity = Vector3.new(0, 0, 0)
                end
            end
        end
    end
end)

local lastAnnounced = ""
task.spawn(function()
    while true do
        task.wait(1)
        if revealMurdererChatEnabled then
            local murderer = getMurderer()
            if murderer and lastAnnounced ~= murderer.Name then
                lastAnnounced = murderer.Name
                local c = TextChatService:FindFirstChild("TextChannels") and TextChatService.TextChannels:FindFirstChild("RBXGeneral")
                if c then c:SendAsync("[S-EXPLOITS]: " .. murderer.Name .. " ES EL ASESINO.") end
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(5)
        if autoVoteEnabled then
            local voting = LP.PlayerGui:FindFirstChild("MainGui") and LP.PlayerGui.MainGui:FindFirstChild("Voting")
            if voting and voting.Visible then
                local maps = voting:FindFirstChild("Maps")
                if maps then
                    local choice = maps:GetChildren()[math.random(1, #maps:GetChildren())]
                    if choice and choice:IsA("TextButton") then choice:Activate() end
                end
            end
        end
    end
end)

-- SISTEMA DE VALIDACIÓN Y FORZADO DE ESP
task.spawn(function()
    while true do
        task.wait(5)
        if espEnabled then
            local murderer = getMurderer()
            local sheriff = getSheriff()
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local cache = PlayerVisuals[p]
                    if not cache then createVisualsForPlayer(p) cache = PlayerVisuals[p] end
                    if cache and (not cache.Highlight or cache.Highlight.Parent ~= p.Character or not cache.Highlight:IsA("Highlight")) then
                        if cache.Highlight then pcall(function() cache.Highlight:Destroy() end) end
                        local h = Instance.new("Highlight")
                        h.FillTransparency = 0.5; h.OutlineTransparency = 0; h.Parent = p.Character
                        cache.Highlight = h
                    end
                    local forcedColor = Color3.fromRGB(0, 255, 0)
                    if p == murderer then forcedColor = Color3.fromRGB(255, 0, 0) elseif p == sheriff then forcedColor = Color3.fromRGB(0, 100, 255) end
                    if cache.Highlight then cache.Highlight.Enabled = true; cache.Highlight.FillColor = forcedColor; cache.Highlight.OutlineColor = forcedColor end
                end
            end
        end
    end
end)

-- RENDERS GLOBALES Y GUN CHAMS
RunService.RenderStepped:Connect(function()
    local localRoot = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    local murderer = getMurderer()
    local sheriff = getSheriff()
    
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Tool") and (obj.Name == "Gun" or obj:FindFirstChild("GunScript")) then
            if not obj:FindFirstChild("GunChams") then
                local hl = Instance.new("Highlight")
                hl.Name = "GunChams"; hl.FillColor = CianColor; hl.FillTransparency = 0.4; hl.OutlineColor = CianColor; hl.OutlineTransparency = 0; hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; hl.Parent = obj
            end
        end
    end
    
    if gunBeaconEnabled then
        local gunFound = nil
        for _, obj in pairs(workspace:GetDescendants()) do
            if (obj.Name == "GunDrop" or obj.Name == "Gun") and (obj:IsA("BasePart") or obj:IsA("Model")) then
                local isPlayerWeapon = false
                for _, player in pairs(Players:GetPlayers()) do if player.Character and obj:IsDescendantOf(player.Character) then isPlayerWeapon = true; break end end
                if not isPlayerWeapon then gunFound = obj; break end
            end
        end
        if gunFound then
            local gunCFrame = gunFound:IsA("BasePart") and gunFound.CFrame or (gunFound:FindFirstChild("Handle") and gunFound.Handle.CFrame) or (gunFound.PrimaryPart and gunFound.PrimaryPart.CFrame)
            if gunCFrame then
                if not beaconPart or not beaconPart.Parent then
                    beaconPart = Instance.new("Part", workspace)
                    beaconPart.Name = "GunBeaconPart"; beaconPart.Size = Vector3.new(1, 1000, 1); beaconPart.Anchored = true; beaconPart.CanCollide = false; beaconPart.Material = Enum.Material.Neon; beaconPart.Color = Color3.fromRGB(128, 0, 128); beaconPart.Transparency = 0.3
                end
                beaconPart.CFrame = CFrame.new(gunCFrame.Position + Vector3.new(0, 500, 0))
            end
        else
            if beaconPart then beaconPart:Destroy(); beaconPart = nil end
        end
    else
        if beaconPart then beaconPart:Destroy(); beaconPart = nil end
    end
    
    if knifeTrajectoryEnabled and localRoot and LP.Character:FindFirstChild("Knife") then
        local knife = LP.Character.Knife
        if knife:FindFirstChild("Handle") then
            local ray = Ray.new(knife.Handle.Position, localRoot.CFrame.LookVector * 150)
            local part, pos = workspace:FindPartOnRay(ray, LP.Character)
            local laser = workspace:FindFirstChild("DeltaLaser") or Instance.new("Part", workspace)
            laser.Name = "DeltaLaser"; laser.Anchored = true; laser.CanCollide = false; laser.Color = Color3.fromRGB(255, 0, 0); laser.Material = Enum.Material.Neon; laser.Transparency = 0.2
            local dist = (knife.Handle.Position - pos).Magnitude
            laser.Size = Vector3.new(0.3, 0.3, dist)
            laser.CFrame = CFrame.new(knife.Handle.Position, pos) * CFrame.new(0, 0, -dist/2)
        end
    else
        if workspace:FindFirstChild("DeltaLaser") then workspace.DeltaLaser:Destroy() end
    end
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP then
            local cache = PlayerVisuals[p]
            if not cache then createVisualsForPlayer(p); cache = PlayerVisuals[p] end
            if cache and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Head") then
                local pRoot = p.Character.HumanoidRootPart
                local head = p.Character.Head
                local color = Color3.fromRGB(255, 255, 255)
                local roleText = "Inocente"
                if p == murderer then
                    color = Color3.fromRGB(255, 0, 0); roleText = "ASESINO"
                elseif p == sheriff then
                    color = Color3.fromRGB(0, 100, 255); roleText = "SHERIFF"
                end
                
                if overlayEnabled then
                    local tag = head:FindFirstChild("DeltaInfoTag")
                    if not tag then
                        tag = Instance.new("BillboardGui"); tag.Name = "DeltaInfoTag"; tag.Parent = head; tag.Size = UDim2.new(0, 130, 0, 45); tag.AlwaysOnTop = true; tag.ExtentsOffset = Vector3.new(0, 3, 0)
                        local lbl = Instance.new("TextLabel", tag); lbl.Name = "InfoLabel"; lbl.Size = UDim2.new(1, 0, 1, 0); lbl.BackgroundTransparency = 1; lbl.Font = Enum.Font.SourceSansBold; lbl.TextSize = 14; lbl.TextStrokeTransparency = 0.2; lbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                    end
                    local playerLevel = p:FindFirstChild("PlayerData") and p.PlayerData:FindFirstChild("Level") and p.PlayerData.Level.Value or "0"
                    tag.InfoLabel.Text = p.Name .. "\n[" .. roleText .. "]\nNivel: " .. tostring(playerLevel); tag.InfoLabel.TextColor3 = color
                else
                    local tag = head:FindFirstChild("DeltaInfoTag"); if tag then tag:Destroy() end
                end
                
                if radarEnabled and radarFrame and localRoot then
                    if not cache.Blip or cache.Blip.Parent ~= radarFrame then
                        local blip = Instance.new("Frame", radarFrame); blip.Size = UDim2.new(0, 6, 0, 6); Instance.new("UICorner", blip).CornerRadius = UDim.new(1, 0)
                        local bs = Instance.new("UIStroke", blip); bs.Thickness = 1; bs.Color = Color3.fromRGB(0, 0, 0); cache.Blip = blip
                    end
                    local relPos = localRoot.CFrame:ToObjectSpace(pRoot.CFrame).Position
                    local scale = 0.65
                    local radarX = math.clamp(65 + (relPos.X * scale), 4, 126)
                    local radarY = math.clamp(65 + (relPos.Z * scale), 4, 126)
                    cache.Blip.Position = UDim2.new(0, radarX - 3, 0, radarY - 3); cache.Blip.BackgroundColor3 = color; cache.Blip.Visible = true
                else
                    if cache.Blip then cache.Blip.Visible = false end
                end
                
                if espEnabled then
                    if not cache.Highlight or cache.Highlight.Parent ~= p.Character then
                        if cache.Highlight then cache.Highlight:Destroy() end
                        local h = Instance.new("Highlight")
                        h.FillTransparency = 0.5; h.OutlineTransparency = 0; h.Parent = p.Character
                        cache.Highlight = h
                    end
                    cache.Highlight.Enabled = true; cache.Highlight.FillColor = color; cache.Highlight.OutlineColor = color
                else
                    if cache.Highlight then cache.Highlight.Enabled = false end
                end
                
                if tracersEnabled and cache.Tracer then
                    local pechoPart = p.Character:FindFirstChild("UpperTorso") or p.Character:FindFirstChild("Torso") or pRoot
                    if pechoPart then
                        local targetWorldPos = pechoPart.Position
                        local vector, onScreen = Camera:WorldToViewportPoint(targetWorldPos)
                        if onScreen then
                            local sPos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                            local tPos = Vector2.new(vector.X, vector.Y)
                            local distance = (tPos - sPos).Magnitude
                            local angle = math.deg(math.atan2(tPos.Y - sPos.Y, tPos.X - sPos.X))
                            cache.Tracer.BackgroundColor3 = color; cache.Tracer.Size = UDim2.new(0, distance, 0, 2); cache.Tracer.Position = UDim2.new(0, (sPos.X + tPos.X) / 2, 0, (sPos.Y + tPos.Y) / 2); cache.Tracer.Rotation = angle; cache.Tracer.Visible = true
                        else
                            cache.Tracer.Visible = false
                        end
                    else
                        cache.Tracer.Visible = false
                    end
                else
                    if cache.Tracer then cache.Tracer.Visible = false end
                end
            else
                if cache then
                    if cache.Highlight then cache.Highlight.Enabled = false end; if cache.Tracer then cache.Tracer.Visible = false end; if cache.Blip then cache.Blip.Visible = false end
                end
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if aimbotEnabled and LP.Character and LP.Character:FindFirstChild("Gun") then
        local t = getAimbotTarget() if t then workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, t.Position) end
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if hitboxEnabled and LP.Character and LP.Character:FindFirstChild("Knife") then
            local handle = LP.Character.Knife:FindFirstChild("Handle") if handle then handle.Size = Vector3.new(15, 15, 15); handle.CanCollide = false end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.05)
        if coinFarmEnabled and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            for _, o in pairs(workspace:GetDescendants()) do
                if o.Name == "CoinContainer" or o.Name == "Coin" or o.Name == "CoinVisual" then if o:IsA("BasePart") then LP.Character.HumanoidRootPart.CFrame = o.CFrame break end end
            end
        end
    end
end)

RunService.Stepped:Connect(function()
    if noclipEnabled and LP.Character then
        for _, part in pairs(LP.Character:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end
    end
end)

UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.Insert then if RestoreButton.Visible == false then MainPanel.Visible = not MainPanel.Visible end end
end)

local jumpConnection
LP.CharacterAdded:Connect(function(newCharacter)
    table.clear(jugadoresEliminados)
    local humanoid = newCharacter:WaitForChild("Humanoid", 5)
    if humanoid then
        if speedEnabled then humanoid.WalkSpeed = 24 end
        if jumpEnabled then
            if jumpConnection then jumpConnection:Disconnect() end
            jumpConnection = UserInputService.JumpRequest:Connect(function() humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end)
        end
    end
end)

toggleNetworkAnimation(true)

-- NOTIFICACIÓN DE INYECCIÓN
local function showNotification()
    local NotificationFrame = Instance.new("Frame")
    local Corner = Instance.new("UICorner")
    local Border = Instance.new("UIStroke")
    local Icon = Instance.new("ImageLabel")
    local MessageText = Instance.new("TextLabel")
    
    NotificationFrame.Name = "SebasNotification"; NotificationFrame.Parent = ScreenGui; NotificationFrame.Position = UDim2.new(1, 20, 0.85, 0); NotificationFrame.Size = UDim2.new(0, 270, 0, 60); NotificationFrame.BackgroundColor3 = Color3.fromRGB(24, 20, 24); NotificationFrame.ZIndex = 200
    Corner.CornerRadius = UDim.new(0, 8); Corner.Parent = NotificationFrame
    Border.Color = currentThemeColor; Border.Thickness = 2; Border.Parent = NotificationFrame
    Icon.Parent = NotificationFrame; Icon.BackgroundTransparency = 1; Icon.Position = UDim2.new(0, 12, 0.5, -18); Icon.Size = UDim2.new(0, 36, 0, 36); Icon.Image = PanelLogo; Icon.ImageColor3 = Color3.fromRGB(255, 255, 255); Icon.ZIndex = 201
    
    MessageText.Parent = NotificationFrame; MessageText.BackgroundTransparency = 1; MessageText.Position = UDim2.new(0, 60, 0, 0); MessageText.Size = UDim2.new(1, -70, 1, 0); MessageText.Font = Enum.Font.GothamBold; MessageText.Text = "<font color='#FF0000'>SΞBΛS | ΞXPLØITS</font> <font color='#000000'>x</font> <font color='#A020F0'>Itachi v3.7</font>\n(execute susesfull)"; MessageText.RichText = true; MessageText.TextColor3 = Color3.fromRGB(255, 255, 255); MessageText.TextSize = 13; MessageText.TextXAlignment = Enum.TextXAlignment.Left; MessageText.ZIndex = 201
    
    task.spawn(function()
        local tweenIn = TweenService:Create(NotificationFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Position = UDim2.new(1, -290, 0.85, 0) })
        tweenIn:Play() task.wait(0.2)
        Border.Color = Color3.fromRGB(255, 255, 255) task.wait(0.1)
        Border.Color = currentThemeColor task.wait(3.5)
        local tweenOut = TweenService:Create(NotificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Position = UDim2.new(1, 20, 0.85, 0) })
        tweenOut:Play() tweenOut.Completed:Wait()
        NotificationFrame:Destroy()
    end)
end

showNotification()
print("SΞBΛS | ΞXPLØITS x Itachi v3.7: INSTALADO CON MINI TOGGLES FLOTANTES")
