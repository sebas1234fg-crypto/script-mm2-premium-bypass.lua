-- =============================================================================
-- SEBAS EXPLOITS MEGA MENU - VERSIÓN COMPLETA
-- CON BOTÓN DE RESTAURACIÓN DE TEXTURA DIRECTA (99579616596711)
-- =============================================================================

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
local TabMisc = Instance.new("TextButton")

local CombatFrame = Instance.new("ScrollingFrame")
local VisualsFrame = Instance.new("ScrollingFrame")
local MiscFrame = Instance.new("ScrollingFrame")

local SliderLabel = Instance.new("TextLabel")
local SliderFrame = Instance.new("Frame")
local SliderButton = Instance.new("TextButton")

local RestoreButton = Instance.new("ImageButton") 

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

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
local aimbotEnabled = false
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

local espHighlights = {}
local tracerLines = {}
local overlayTags = {}
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

local function clearEsp()
    for _, h in pairs(espHighlights) do if h then h:Destroy() end end
    table.clear(espHighlights)
end

local function clearTracers()
    for _, line in pairs(tracerLines) do if line then line:Destroy() end end
    table.clear(tracerLines)
end

local function clearOverlays()
    for _, tag in pairs(overlayTags) do if tag then tag:Destroy() end end
    table.clear(overlayTags)
end

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

-- =============================================================================
-- INTERFAZ PRINCIPAL DEL MENÚ
-- =============================================================================
MainPanel.Name = "SebasMainPanel"
MainPanel.Parent = ScreenGui
MainPanel.BackgroundColor3 = Color3.fromRGB(18, 12, 14)
MainPanel.Position = UDim2.new(0.25, 0, 0.15, 0)
MainPanel.Size = UDim2.new(0, 420, 0, 390)
MainPanel.Active = true
MainPanel.Draggable = true
MainPanel.ClipsDescendants = true
MainPanel.Visible = false 

local MainCorner = Instance.new("UICorner", MainPanel)
MainCorner.CornerRadius = UDim.new(0, 10)

local NeonBorder = Instance.new("UIStroke", MainPanel)
NeonBorder.Thickness = 2
NeonBorder.Color = currentThemeColor
NeonBorder.Transparency = 1

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
                
                table.insert(nodes, {
                    Obj = dot,
                    VelX = (math.random() - 0.5) * 0.005,
                    VelY = (math.random() - 0.5) * 0.005
                })
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
TitleText.Text = "SEBAS EXPLOITS — PANEL MULTIHACK"
TitleText.TextColor3 = Color3.fromRGB(255, 70, 90)
TitleText.TextSize = 13
TitleText.Font = Enum.Font.SourceSansBold
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
ContentFrame.BackgroundTransparency = 0.15
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
    btn.TextSize = 13
    btn.ZIndex = 3
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
end

styleTabBtn(TabCombat, "Combat", 10)
styleTabBtn(TabVisuals, "Visuals", 50)
styleTabBtn(TabMisc, "Misc", 95)

local function setupSubFrame(frm)
    frm.Parent = ContentFrame
    frm.Size = UDim2.new(1, 0, 1, 0)
    frm.BackgroundTransparency = 1
    frm.ScrollBarThickness = 5
    frm.CanvasSize = UDim2.new(0, 0, 5.5, 0) 
    frm.Visible = false
    frm.ZIndex = 3
end

setupSubFrame(CombatFrame)
setupSubFrame(VisualsFrame)
setupSubFrame(MiscFrame)

CombatFrame.Visible = true
TabCombat.BackgroundColor3 = Color3.fromRGB(180, 20, 50)

local function switchTab(selectedFrame, selectedBtn)
    CombatFrame.Visible = false; VisualsFrame.Visible = false; MiscFrame.Visible = false
    TabCombat.BackgroundColor3 = Color3.fromRGB(40, 25, 30)
    TabVisuals.BackgroundColor3 = Color3.fromRGB(40, 25, 30)
    TabMisc.BackgroundColor3 = Color3.fromRGB(40, 25, 30)
    selectedFrame.Visible = true
    selectedBtn.BackgroundColor3 = Color3.fromRGB(180, 20, 50)
end

TabCombat.MouseButton1Click:Connect(function() switchTab(CombatFrame, TabCombat) end)
TabVisuals.MouseButton1Click:Connect(function() switchTab(VisualsFrame, TabVisuals) end)
TabMisc.MouseButton1Click:Connect(function() switchTab(MiscFrame, TabMisc) end)

-- =============================================================================
-- CONFIGURACIÓN DEL BOTÓN DE MINIMIZADO CON TU NUEVO ID DE TEXTURA DIRECTA
-- =============================================================================
RestoreButton.Name = "SebasRestoreButton"
RestoreButton.Parent = ScreenGui
RestoreButton.Position = UDim2.new(0.05, 0, 0.3, 0)
RestoreButton.Size = UDim2.new(0, 65, 0, 65)
RestoreButton.BackgroundColor3 = Color3.fromRGB(18, 12, 14)
RestoreButton.BackgroundTransparency = 0.2
RestoreButton.Visible = false
RestoreButton.Draggable = true

RestoreButton.Image = "rbxassetid://99579616596711"
RestoreButton.ScaleType = Enum.ScaleType.Fit

local RestoreBorder = Instance.new("UIStroke", RestoreButton)
RestoreBorder.Thickness = 1.5
RestoreBorder.Color = currentThemeColor
RestoreBorder.Transparency = 0.3

local RestoreCorner = Instance.new("UICorner", RestoreButton)
RestoreCorner.CornerRadius = UDim.new(0, 12)

MinimizeButton.MouseButton1Click:Connect(function() MainPanel.Visible = false; RestoreButton.Visible = true end)
RestoreButton.MouseButton1Click:Connect(function() MainPanel.Visible = true; RestoreButton.Visible = false end)
CloseButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local ClickShootButton = Instance.new("TextButton")
local KillAllKnifeButton = Instance.new("TextButton")
local TeleportAsesinoButton = Instance.new("TextButton")
local KillAuraButton = Instance.new("TextButton")
local AutoDodgeButton = Instance.new("TextButton")
local AntiFlingButton = Instance.new("TextButton")
local TeleportButton = Instance.new("TextButton")
local HitboxButton = Instance.new("TextButton")
local AutoHoldButton = Instance.new("TextButton")
local SheathButton = Instance.new("TextButton")
local FakeLagButton = Instance.new("TextButton")
local SheriffAimbotButton = Instance.new("TextButton")

local EspButton = Instance.new("TextButton")
local TracerButton = Instance.new("TextButton")
local RadarButton = Instance.new("TextButton")
local AmmoButton = Instance.new("TextButton")
local OverlayButton = Instance.new("TextButton")
local KnifeTrajectoryButton = Instance.new("TextButton")
local GunBeaconButton = Instance.new("TextButton")

local CoinButton = Instance.new("TextButton")
local NoclipButton = Instance.new("TextButton")
local JumpButton = Instance.new("TextButton")
local SpeedButton = Instance.new("TextButton")
local BrightButton = Instance.new("TextButton")
local FreecamButton = Instance.new("TextButton")
local InvisibleButton = Instance.new("TextButton")
local AutoVoteButton = Instance.new("TextButton")
local AntiAfkButton = Instance.new("TextButton")
local RevealMurdererChatButton = Instance.new("TextButton")
local GlitchSpotButton = Instance.new("TextButton")
local AnimToggleButton = Instance.new("TextButton") 
local ResetButton = Instance.new("TextButton")

-- =============================================================================
-- INTRO CINEMÁTICA LENTA "SEBAS EXPLOITS" (MODIFICADA)
-- =============================================================================
local IntroContainer = Instance.new("Frame", ScreenGui)
IntroContainer.Name = "SebasIntroContainer"
IntroContainer.Size = UDim2.new(1, 0, 1, 0)
IntroContainer.BackgroundTransparency = 1
IntroContainer.ZIndex = 100

local IntroText = Instance.new("TextLabel", IntroContainer)
IntroText.Name = "IntroText"
IntroText.BackgroundTransparency = 1
IntroText.Position = UDim2.new(0.5, 0, 0.5, 0)
IntroText.Size = UDim2.new(0, 0, 0, 0)
IntroText.AnchorPoint = Vector2.new(0.5, 0.5)
IntroText.RichText = true
IntroText.Text = '<font color="#FF0000">⚡ SΞBΛS | ΞXPLØITS ⚡</font> <font color="#000000">X</font> <font color="#800080">Itachi</font>'
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
    for i = 1, 3 do
        IntroText.TextTransparency = 0.3; UIStroke.Transparency = 0.3; task.wait(0.06)
        IntroText.TextTransparency = 1; UIStroke.Transparency = 1; task.wait(0.04)
    end
    
    IntroText.TextTransparency = 0; UIStroke.Transparency = 0
    local textTween = TweenService:Create(IntroText, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 800, 0, 100),
        TextSize = 42
    })
    textTween:Play(); textTween.Completed:Wait()
    
    task.wait(1.2)
    
    local fadeTween = TweenService:Create(IntroText, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { TextTransparency = 1 })
    local strokeTween = TweenService:Create(UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Transparency = 1 })
    fadeTween:Play(); strokeTween:Play(); fadeTween.Completed:Wait()
    IntroContainer:Destroy()
    
    -- Entrada lenta del Panel del menú
    MainPanel.Size = UDim2.new(0, 420, 0, 2)
    MainPanel.Position = UDim2.new(0.25, 0, 0.35, 0)
    MainPanel.BackgroundTransparency = 1
    MainPanel.Visible = true
    
    TweenService:Create(MainPanel, TweenInfo.new(1.0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = 0 }):Play()
    TweenService:Create(MainPanel, TweenInfo.new(1.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 420, 0, 390),
        Position = UDim2.new(0.25, 0, 0.15, 0)
    }):Play()
    
    TweenService:Create(NeonBorder, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Transparency = 0.4 }):Play()
end)

-- =============================================================================
-- LOGICA OPERATIVA DE LOS BOTONES
-- =============================================================================
local function triggerAction(btn)
    if btn == ClickShootButton then
        clickShootEnabled = not clickShootEnabled
        ClickShootButton.BackgroundColor3 = clickShootEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(150, 40, 40)
        ClickShootButton.Text = clickShootEnabled and "Clic para Disparar Asesino: ON" or "Clic para Disparar Asesino: OFF"
    elseif btn == KillAllKnifeButton then
        killAllKnifeEnabled = not killAllKnifeEnabled
        KillAllKnifeButton.BackgroundColor3 = killAllKnifeEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(180, 0, 50)
        KillAllKnifeButton.Text = killAllKnifeEnabled and "Kill All Teleport (Ultra Fast): ON" or "Kill All Teleport (Ultra Fast): OFF"
    elseif btn == TeleportAsesinoButton then
        local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        local murderer = getMurderer()
        if root and murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") then
            root.CFrame = murderer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        end
    elseif btn == KillAuraButton then
        killAuraEnabled = not killAuraEnabled
        KillAuraButton.BackgroundColor3 = killAuraEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(190, 20, 100)
        KillAuraButton.Text = killAuraEnabled and "Silent Kill Aura Cuchillo: ON" or "Silent Kill Aura Cuchillo: OFF"
    elseif btn == AutoDodgeButton then
        autoDodgeEnabled = not autoDodgeEnabled
        AutoDodgeButton.BackgroundColor3 = autoDodgeEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(110, 30, 150)
        AutoDodgeButton.Text = autoDodgeEnabled and "Auto-Dodge vs Asesino: ON" or "Auto-Dodge vs Asesino: OFF"
    elseif btn == AntiFlingButton then
        antiFlingEnabled = not antiFlingEnabled
        AntiFlingButton.BackgroundColor3 = antiFlingEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(60, 60, 90)
        AntiFlingButton.Text = antiFlingEnabled and "Estabilizador Anti-Fling: ON" or "Estabilizador Anti-Fling: OFF"
    elseif btn == SheriffAimbotButton then
        aimbotEnabled = not aimbotEnabled
        SheriffAimbotButton.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(0, 140, 150)
        SheriffAimbotButton.Text = aimbotEnabled and "Safe Aimbot Sheriff: ON" or "Safe Aimbot Sheriff: OFF"
    elseif btn == HitboxButton then
        hitboxEnabled = not hitboxEnabled
        HitboxButton.BackgroundColor3 = hitboxEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(130, 40, 130)
        HitboxButton.Text = hitboxEnabled and "Agrandar Hitbox Cuchillo: ON" or "Agrandar Hitbox Cuchillo: OFF"
    elseif btn == AutoHoldButton then
        autoHoldEnabled = not autoHoldEnabled
        AutoHoldButton.BackgroundColor3 = autoHoldEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(50, 50, 50)
        AutoHoldButton.Text = autoHoldEnabled and "Auto-Equipar Armas: ON" or "Auto-Equipar Armas: OFF"
    elseif btn == SheathButton then
        sheathEnabled = not sheathEnabled
        SheathButton.BackgroundColor3 = sheathEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(70, 40, 20)
        SheathButton.Text = sheathEnabled and "Auto-Esconder Cuchillo: ON" or "Auto-Esconder Cuchillo: OFF"
    elseif btn == FakeLagButton then
        fakeLagEnabled = not fakeLagEnabled
        FakeLagButton.BackgroundColor3 = fakeLagEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(100, 100, 100)
        FakeLagButton.Text = fakeLagEnabled and "Lag Táctico (FakeLag): ON" or "Lag Táctico (FakeLag): OFF"
        settings().Network.IncomingReplicationLag = fakeLagEnabled and 1 or 0
    elseif btn == EspButton then
        espEnabled = not espEnabled
        EspButton.BackgroundColor3 = espEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(80, 40, 120)
        EspButton.Text = espEnabled and "Ver Roles (ESP): ACTIVADO" or "Ver Roles (ESP): DESACTIVADO"
        if not espEnabled then clearEsp() end
    elseif btn == TracerButton then
        tracersEnabled = not tracersEnabled
        TracerButton.BackgroundColor3 = tracersEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(120, 60, 20)
        TracerButton.Text = tracersEnabled and "Líneas de Rastreo (Tracers): ON" or "Líneas de Rastreo (Tracers): OFF"
        if not tracersEnabled then clearTracers() end
    elseif btn == AmmoButton then
        ammoEnabled = not ammoEnabled
        AmmoButton.BackgroundColor3 = ammoEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(0, 100, 150)
        AmmoButton.Text = ammoEnabled and "Rastreador de Balas Sheriff: ON" or "Rastreador de Balas Sheriff: OFF"
    elseif btn == RadarButton then
        radarEnabled = not radarEnabled
        RadarButton.BackgroundColor3 = radarEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(20, 100, 60)
        RadarButton.Text = radarEnabled and "Radar 2D Portátil: ACTIVADO" or "Radar 2D Portátil: DESACTIVADO"
        if radarEnabled then
            radarFrame = Instance.new("Frame", ScreenGui)
            radarFrame.Size = UDim2.new(0, 120, 0, 120)
            radarFrame.Position = UDim2.new(0, 10, 0, 150)
            radarFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            radarFrame.BackgroundTransparency = 0.3
            Instance.new("UICorner", radarFrame).CornerRadius = UDim.new(0, 8)
        else
            if radarFrame then radarFrame:Destroy(); radarFrame = nil end
        end
    elseif btn == OverlayButton then
        overlayEnabled = not overlayEnabled
        OverlayButton.BackgroundColor3 = overlayEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(140, 140, 0)
        OverlayButton.Text = overlayEnabled and "Nivel Info sobre Cabeza: ON" or "Nivel Info sobre Cabeza: OFF"
        if not overlayEnabled then clearOverlays() end
    elseif btn == KnifeTrajectoryButton then
        knifeTrajectoryEnabled = not knifeTrajectoryEnabled
        KnifeTrajectoryButton.BackgroundColor3 = knifeTrajectoryEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(200, 50, 0)
        KnifeTrajectoryButton.Text = knifeTrajectoryEnabled and "Visor Trayectoria Láser: ON" or "Visor Trayectoria Láser: OFF"
    elseif btn == GunBeaconButton then
        gunBeaconEnabled = not gunBeaconEnabled
        GunBeaconButton.BackgroundColor3 = gunBeaconEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(0, 150, 200)
        GunBeaconButton.Text = gunBeaconEnabled and "Faro Luz Pistola Tirada: ON" or "Faro Luz Pistola Tirada: OFF"
        if not gunBeaconEnabled and beaconPart then beaconPart:Destroy(); beaconPart = nil end
    elseif btn == CoinButton then
        coinFarmEnabled = not coinFarmEnabled
        CoinButton.BackgroundColor3 = coinFarmEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(160, 120, 0)
        CoinButton.Text = coinFarmEnabled and "Auto-Farm Monedas (Ultra-Fast): ON" or "Auto-Farm Monedas (Ultra-Fast): OFF"
    elseif btn == NoclipButton then
        noclipEnabled = not noclipEnabled
        NoclipButton.BackgroundColor3 = noclipEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(70, 70, 70)
        NoclipButton.Text = noclipEnabled and "Noclip (Paredes): ON" or "Noclip (Paredes): OFF"
    elseif btn == JumpButton then
        jumpEnabled = not jumpEnabled
        JumpButton.BackgroundColor3 = jumpEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(0, 120, 120)
        JumpButton.Text = jumpEnabled and "Salto Infinito: ACTIVADO" or "Salto Infinito: DESACTIVADO"
    elseif btn == SpeedButton then
        speedEnabled = not speedEnabled
        SpeedButton.BackgroundColor3 = speedEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(40, 140, 100)
        SpeedButton.Text = speedEnabled and "Velocidad Estable (+X2): ON" or "Velocidad Estable (+X2): OFF"
    elseif btn == BrightButton then
        brightEnabled = not brightEnabled
        BrightButton.BackgroundColor3 = brightEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(180, 140, 40)
        BrightButton.Text = brightEnabled and "Brillo Total (FullBright): ON" or "Brillo Total (FullBright): OFF"
        game:GetService("Lighting").Ambient = brightEnabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(128, 128, 128)
        game:GetService("Lighting").Brightness = brightEnabled and 2 or 1
    elseif btn == FreecamButton then
        freecamEnabled = not freecamEnabled
        FreecamButton.BackgroundColor3 = freecamEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(120, 0, 120)
        FreecamButton.Text = freecamEnabled and "Cámara Libre Invisible: ON" or "Cámara Libre Invisible: OFF"
        local camera = workspace.CurrentCamera
        if freecamEnabled then 
            originalCameraType = camera.CameraType; camera.CameraType = Enum.CameraType.Scriptable
        else 
            camera.CameraType = originalCameraType
            if LP.Character and LP.Character:FindFirstChild("Humanoid") then camera.CameraSubject = LP.Character.Humanoid end 
        end
    elseif btn == InvisibleButton then
        invisibleEnabled = not invisibleEnabled
        InvisibleButton.BackgroundColor3 = invisibleEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(0, 150, 150)
        InvisibleButton.Text = invisibleEnabled and "Modo Invisible (Fantasma): ON" or "Modo Invisible (Fantasma): OFF"
        
        local char = LP.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        
        if invisibleEnabled then
            if root and char:FindFirstChild("Humanoid") then
                originalPosition = root.CFrame
                char.Archivable = true
                
                local skyPlatform = Instance.new("Part", workspace)
                skyPlatform.Name = "SkyAnchor_Delta"
                skyPlatform.Size = Vector3.new(12, 1, 12)
                skyPlatform.CFrame = CFrame.new(originalPosition.Position.X, 1000, originalPosition.Position.Z)
                skyPlatform.Anchored = true; skyPlatform.Transparency = 1
                
                ghostCharacter = char:Clone()
                ghostCharacter.Name = "Ghost_Model"
                for _, part in pairs(ghostCharacter:GetDescendants()) do
                    if part:IsA("BasePart") then part.Transparency = 0.5; part.CanCollide = false
                    elseif part:IsA("Decal") then part.Transparency = 0.5 end
                end
                ghostCharacter.Parent = workspace
                workspace.CurrentCamera.CameraSubject = ghostCharacter:FindFirstChild("Humanoid")
                root.CFrame = skyPlatform.CFrame + Vector3.new(0, 3, 0)
                
                invisibleLoop = RunService.Heartbeat:Connect(function()
                    if ghostCharacter and char and root and workspace:FindFirstChild("SkyAnchor_Delta") then
                        ghostCharacter.Humanoid:Move(char.Humanoid.MoveDirection, false)
                        if char.Humanoid.Jump then ghostCharacter.Humanoid.Jump = true end
                        if not char:FindFirstChildOfClass("Tool") then
                            root.CFrame = workspace.SkyAnchor_Delta.CFrame + Vector3.new(0, 3, 0)
                            root.Velocity = Vector3.new(0,0,0)
                        else
                            root.CFrame = ghostCharacter.HumanoidRootPart.CFrame
                        end
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
    elseif btn == AutoVoteButton then
        autoVoteEnabled = not autoVoteEnabled
        AutoVoteButton.BackgroundColor3 = autoVoteEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(60, 40, 40)
        AutoVoteButton.Text = autoVoteEnabled and "Voto de Mapa Fantasma: ON" or "Voto de Mapa Fantasma: OFF"
    elseif btn == AntiAfkButton then
        antiAfkEnabled = not antiAfkEnabled
        AntiAfkButton.BackgroundColor3 = antiAfkEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(50, 70, 50)
        AntiAfkButton.Text = antiAfkEnabled and "Anti-AFK Desconexión: ON" or "Anti-AFK Desconexión: OFF"
        if antiAfkEnabled then
            antiAfkConnection = LP.Idled:Connect(function()
                game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                task.wait(1)
                game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end)
        else
            if antiAfkConnection then antiAfkConnection:Disconnect(); antiAfkConnection = nil end
        end
    elseif btn == RevealMurdererChatButton then
        revealMurdererChatEnabled = not revealMurdererChatEnabled
        RevealMurdererChatButton.BackgroundColor3 = revealMurdererChatEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(30, 80, 80)
        RevealMurdererChatButton.Text = revealMurdererChatEnabled and "Revelar Asesino (Chat): ON" or "Revelar Asesino (Chat): OFF"
    elseif btn == GlitchSpotButton then
        glitchSpotEnabled = not glitchSpotEnabled
        GlitchSpotButton.BackgroundColor3 = glitchSpotEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(120, 90, 30)
        GlitchSpotButton.Text = glitchSpotEnabled and "Modo Escondite Glitch: ON" or "Modo Escondite Glitch: OFF"
        local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        if root then
            if glitchSpotEnabled then
                originalPosition = root.CFrame
                root.CFrame = CFrame.new(math.random(-5000, 5000), 2500, math.random(-5000, 5000))
                local p = Instance.new("Part", workspace)
                p.Name = "GlitchPlatform"; p.Size = Vector3.new(15, 1, 15)
                p.CFrame = root.CFrame - Vector3.new(0, 3, 0); p.Anchored = true
            else
                if workspace:FindFirstChild("GlitchPlatform") then workspace.GlitchPlatform:Destroy() end
                if originalPosition then root.CFrame = originalPosition end
            end
        end
    elseif btn == AnimToggleButton then
        local state = not animationEnabled
        toggleNetworkAnimation(state)
        AnimToggleButton.BackgroundColor3 = state and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(40, 25, 30)
        AnimToggleButton.Text = state and "Animación de Red: ON" or "Animación de Red: OFF"
    elseif btn == TeleportButton then
        local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local gunDrop = workspace:FindFirstChild("GunDrop") or workspace:FindFirstChild("Gun")
        if gunDrop and gunDrop:IsA("BasePart") then
            local sPos = root.CFrame; root.CFrame = gunDrop.CFrame; task.wait(0.12)
            if root and LP.Character:FindFirstChildOfClass("Humanoid").Health > 0 then root.CFrame = sPos end
        else
            local sheriff = getSheriff()
            if sheriff and sheriff.Character and sheriff.Character:FindFirstChild("HumanoidRootPart") then root.CFrame = sheriff.Character.HumanoidRootPart.CFrame + Vector3.new(0, 4, 0) end
        end
    elseif btn == ResetButton then
        local h = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        if h then h.Health = 0 end
    end
end

local function setupFloatingSystem(mainButton)
    local isHolding = false
    mainButton.MouseButton1Down:Connect(function()
        isHolding = true; task.wait(0.8)
        if isHolding then
            local existingFloater = activeFloaters[mainButton]
            if existingFloater and existingFloater.Parent then
                existingFloater:Destroy(); activeFloaters[mainButton] = nil
            else
                local floatBtn = Instance.new("TextButton", ScreenGui)
                floatBtn.BackgroundColor3 = mainButton.BackgroundColor3
                floatBtn.Text = mainButton.Text; floatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                floatBtn.TextSize = 11; floatBtn.Active = true; floatBtn.Draggable = true
                Instance.new("UICorner", floatBtn).CornerRadius = UDim.new(0, 6)
                floatBtn.Size = UDim2.new(0, 200, 0, 32)
                floatBtn.Position = UDim2.new(0.4, 0, 0.4, 0)
                
                mainButton:GetPropertyChangedSignal("Text"):Connect(function()
                    if floatBtn and floatBtn.Parent then
                        floatBtn.Text = mainButton.Text; floatBtn.BackgroundColor3 = mainButton.BackgroundColor3
                    end
                end)
                floatBtn.MouseButton1Click:Connect(function() triggerAction(mainButton) end)
                activeFloaters[mainButton] = floatBtn
            end
            isHolding = false
        end
    end)
    mainButton.MouseButton1Up:Connect(function() isHolding = false end)
    mainButton.MouseButton1Click:Connect(function() triggerAction(mainButton) end)
end

local function styleHackBtn(btn, parent, text, yPos, color)
    btn.Parent = parent
    btn.Size = UDim2.new(0, 280, 0, 32)
    btn.Position = UDim2.new(0, 12, 0, yPos)
    btn.BackgroundColor3 = color; btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255); btn.TextSize = 12; btn.ZIndex = 4
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 7)
    setupFloatingSystem(btn)
end

styleHackBtn(ClickShootButton, CombatFrame, "Clic para Disparar Asesino: OFF", 10, Color3.fromRGB(150, 40, 40))
styleHackBtn(KillAllKnifeButton, CombatFrame, "Kill All Teleport (Ultra Fast): OFF", 50, Color3.fromRGB(180, 0, 50))
styleHackBtn(TeleportAsesinoButton, CombatFrame, "Teleport al Asesino (Instantáneo)", 90, Color3.fromRGB(255, 80, 0))
styleHackBtn(KillAuraButton, CombatFrame, "Silent Kill Aura Cuchillo: OFF", 130, Color3.fromRGB(190, 20, 100))
styleHackBtn(AutoDodgeButton, CombatFrame, "Auto-Dodge vs Asesino (2m): OFF", 170, Color3.fromRGB(110, 30, 150))
styleHackBtn(AntiFlingButton, CombatFrame, "Estabilizador Anti-Fling: OFF", 210, Color3.fromRGB(60, 60, 90))
styleHackBtn(TeleportButton, CombatFrame, "Teleport a Sheriff / Pistola", 250, Color3.fromRGB(0, 80, 160))
styleHackBtn(HitboxButton, CombatFrame, "Agrandar Hitbox Cuchillo: OFF", 290, Color3.fromRGB(130, 40, 130))
styleHackBtn(AutoHoldButton, CombatFrame, "Auto-Equipar Armas: OFF", 330, Color3.fromRGB(50, 50, 50))
styleHackBtn(SheathButton, CombatFrame, "Auto-Esconder Cuchillo: OFF", 370, Color3.fromRGB(70, 40, 20))
styleHackBtn(FakeLagButton, CombatFrame, "Lag Táctico (FakeLag): OFF", 410, Color3.fromRGB(100, 100, 100))
styleHackBtn(SheriffAimbotButton, CombatFrame, "Safe Aimbot Sheriff: OFF", 450, Color3.fromRGB(0, 140, 150))

styleHackBtn(EspButton, VisualsFrame, "Ver Roles (ESP): DESACTIVADO", 10, Color3.fromRGB(80, 40, 120))
styleHackBtn(TracerButton, VisualsFrame, "Líneas de Rastreo (Tracers): OFF", 50, Color3.fromRGB(120, 60, 20))
styleHackBtn(RadarButton, VisualsFrame, "Radar 2D Portátil: DESACTIVADO", 90, Color3.fromRGB(20, 100, 60))
styleHackBtn(AmmoButton, VisualsFrame, "Rastreador de Balas Sheriff: OFF", 130, Color3.fromRGB(0, 100, 150))
styleHackBtn(OverlayButton, VisualsFrame, "Nivel Info sobre Cabeza: OFF", 170, Color3.fromRGB(140, 140, 0))
styleHackBtn(KnifeTrajectoryButton, VisualsFrame, "Visor Trayectoria Láser: OFF", 210, Color3.fromRGB(200, 50, 0))
styleHackBtn(GunBeaconButton, VisualsFrame, "Faro Luz Pistola Tirada: OFF", 250, Color3.fromRGB(0, 150, 200))

styleHackBtn(CoinButton, MiscFrame, "Auto-Farm Monedas (Ultra-Fast): OFF", 10, Color3.fromRGB(160, 120, 0))
styleHackBtn(NoclipButton, MiscFrame, "Noclip (Paredes): OFF", 50, Color3.fromRGB(70, 70, 70))
styleHackBtn(JumpButton, MiscFrame, "Salto Infinito: DESACTIVADO", 90, Color3.fromRGB(0, 120, 120))
styleHackBtn(SpeedButton, MiscFrame, "Velocidad Estable (+X2): OFF", 130, Color3.fromRGB(40, 140, 100))
styleHackBtn(BrightButton, MiscFrame, "Brillo Total (FullBright): OFF", 170, Color3.fromRGB(180, 140, 40))
styleHackBtn(FreecamButton, MiscFrame, "Cámara Libre Invisible: OFF", 210, Color3.fromRGB(120, 0, 120))
styleHackBtn(InvisibleButton, MiscFrame, "Modo Invisible (Fantasma): OFF", 250, Color3.fromRGB(0, 150, 150))
styleHackBtn(AutoVoteButton, MiscFrame, "Voto de Mapa Fantasma: OFF", 290, Color3.fromRGB(60, 40, 40))
styleHackBtn(AntiAfkButton, MiscFrame, "Anti-AFK Desconexión: OFF", 330, Color3.fromRGB(50, 70, 50))
styleHackBtn(RevealMurdererChatButton, MiscFrame, "Revelar Asesino (Chat): OFF", 370, Color3.fromRGB(30, 80, 80))
styleHackBtn(GlitchSpotButton, MiscFrame, "Modo Escondite Glitch: OFF", 410, Color3.fromRGB(120, 90, 30))
styleHackBtn(AnimToggleButton, MiscFrame, "Animación de Red: ON", 450, Color3.fromRGB(40, 25, 30)) 
styleHackBtn(ResetButton, MiscFrame, "Suicidio de Emergencia (Reset)", 490, Color3.fromRGB(180, 0, 0))

SliderLabel.Parent = MiscFrame; SliderLabel.Size = UDim2.new(0, 280, 0, 15); SliderLabel.Position = UDim2.new(0, 12, 0, 535); SliderLabel.ZIndex = 4
SliderLabel.BackgroundTransparency = 1; SliderLabel.Text = "Desliza para cambiar colores del panel:"; SliderLabel.TextColor3 = Color3.fromRGB(200, 200, 200); SliderLabel.TextSize = 10

SliderFrame.Parent = MiscFrame; SliderFrame.Size = UDim2.new(0, 280, 0, 12); SliderFrame.Position = UDim2.new(0, 12, 0, 555); SliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50); SliderFrame.ZIndex = 4
Instance.new("UICorner", SliderFrame).CornerRadius = UDim.new(0, 4)

SliderButton.Parent = SliderFrame; SliderButton.Size = UDim2.new(0, 20, 1, 0); SliderButton.Position = UDim2.new(0, 0, 0, 0); SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255); SliderButton.Text = ""; SliderButton.ZIndex = 5
Instance.new("UICorner", SliderButton).CornerRadius = UDim.new(0, 4)

local draggingColor = false
local function updateSliderColor(input)
    local relativeX = input.Position.X - SliderFrame.AbsolutePosition.X
    local percentage = math.clamp(relativeX / SliderFrame.AbsoluteSize.X, 0, 1)
    SliderButton.Position = UDim2.new(percentage, -10, 0, 0)
    currentThemeColor = Color3.fromHSV(percentage, 1, 1)
    
    MainPanel.BackgroundColor3 = Color3.fromHSV(percentage, 0.95, 0.2)
    TitleBar.BackgroundColor3 = Color3.fromHSV(percentage, 0.95, 0.3)
    TabBar.BackgroundColor3 = Color3.fromHSV(percentage, 0.95, 0.3)
    ContentFrame.BackgroundColor3 = Color3.fromHSV(percentage, 0.95, 0.45)
    NeonBorder.Color = currentThemeColor
    RestoreBorder.Color = currentThemeColor
end

SliderButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingColor = true end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if draggingColor and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then updateSliderColor(input) end
end)
game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingColor = false end
end)

local jugadoresEliminados = {} 
workspace.ChildAdded:Connect(function(c) if c.Name == "Normal" or c.Name == "Map" then table.clear(jugadoresEliminados) end end)

game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
    if not processed and clickShootEnabled and input.UserInputType == Enum.UserInputType.MouseButton1 then
        local gun = LP.Character and LP.Character:FindFirstChild("Gun")
        if gun then gun:Activate() end
    end
end)

RunService.Heartbeat:Connect(function()
    if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        local myRoot = LP.Character.HumanoidRootPart
        local knife = LP.Character:FindFirstChild("Knife")
        
        if knife then
            if killAllKnifeEnabled then
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
                            firetouchinterest(player.Character.HumanoidRootPart, knife.Handle, 0)
                            firetouchinterest(player.Character.HumanoidRootPart, knife.Handle, 1)
                        end
                    end
                end
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if autoDodgeEnabled and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        local m = getMurderer()
        if m and m.Character and m.Character:FindFirstChild("HumanoidRootPart") and m.Character:FindFirstChild("Knife") then
            if (m.Character.HumanoidRootPart.Position - LP.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                LP.Character.HumanoidRootPart.CFrame = m.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 8)
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

RunService.Heartbeat:Connect(function()
    clearEsp(); clearTracers()
    if not overlayEnabled then clearOverlays() end
    if radarFrame and radarEnabled then for _, c in pairs(radarFrame:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end end
    
    local Camera = workspace.CurrentCamera
    local localRoot = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    
    if gunBeaconEnabled then
        local gunDrop = workspace:FindFirstChild("GunDrop") or workspace:FindFirstChild("Gun")
        if gunDrop and gunDrop:IsA("BasePart") then
            if not beaconPart or not beaconPart.Parent then
                beaconPart = Instance.new("Part", workspace); beaconPart.Size = Vector3.new(2, 500, 2)
                beaconPart.Anchored = true; beaconPart.CanCollide = false; beaconPart.Material = Enum.Material.Neon
                beaconPart.Color = Color3.fromRGB(0, 180, 255); beaconPart.Transparency = 0.4
            end
            beaconPart.CFrame = gunDrop.CFrame + Vector3.new(0, 250, 0)
        else
            if beaconPart then beaconPart:Destroy(); beaconPart = nil end
        end
    end

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Head") then
            local color = Color3.fromRGB(255, 255, 255)
            local roleText = "Inocente"
            local isMurderer = false
            
            if p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife") then 
                color = Color3.fromRGB(255, 0, 0); roleText = "ASESINO"; isMurderer = true
            elseif p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun") then 
                color = Color3.fromRGB(0, 100, 255); roleText = "SHERIFF"
                if ammoEnabled then
                    AmmoButton.Text = p.Character:FindFirstChild("Gun") and "Sheriff: ¡TIRO LISTO!" or "Sheriff: Guardado"
                    AmmoButton.BackgroundColor3 = p.Character:FindFirstChild("Gun") and Color3.fromRGB(180, 50, 50) or Color3.fromRGB(40, 140, 40)
                end
            end
            
            if overlayEnabled then
                local head = p.Character.Head
                local tag = head:FindFirstChild("DeltaInfoTag")
                if not tag then
                    tag = Instance.new("BillboardGui", head); tag.Name = "DeltaInfoTag"; tag.Size = UDim2.new(0, 100, 0, 40)
                    tag.AlwaysOnTop = true; tag.StreamedOutBehavior = Enum.StreamedOutBehavior.Persistent
                    local lbl = Instance.new("TextLabel", tag); lbl.Size = UDim2.new(1, 0, 1, 0)
                    lbl.BackgroundTransparency = 1; lbl.Font = Enum.Font.SourceSansBold; lbl.TextSize = 13
                    table.insert(overlayTags, tag)
                end
                tag.TextLabel.Text = p.Name .. "\n[" .. roleText .. "]"
                tag.TextLabel.TextColor3 = color
            end

            if espEnabled then
                local h = Instance.new("Highlight", ScreenGui); h.Adornee = p.Character; h.FillColor = color
                h.FillTransparency = 0.5; h.OutlineColor = color; table.insert(espHighlights, h)
            end

            if tracersEnabled then
                local vector, onScreen = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
                if onScreen then
                    local Line = Instance.new("Frame", ScreenGui); Line.BackgroundColor3 = color; Line.BorderSizePixel = 0
                    local sPos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    local distance = (Vector2.new(vector.X, vector.Y) - sPos).Magnitude
                    Line.Size = UDim2.new(0, distance, 0, 2)
                    Line.Position = UDim2.new(0, (sPos.X + vector.X) / 2 - distance / 2, 0, (sPos.Y + vector.Y) / 2)
                    Line.Rotation = math.deg(math.atan2(vector.Y - sPos.Y, vector.X - sPos.X))
                    table.insert(tracerLines, Line)
                end
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if aimbotEnabled and LP.Character and LP.Character:FindFirstChild("Gun") then
        local t = getAimbotTarget()
        if t then workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, t.Position) end
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if hitboxEnabled and LP.Character and LP.Character:FindFirstChild("Knife") then
            local handle = LP.Character.Knife:FindFirstChild("Handle")
            if handle then handle.Size = Vector3.new(15, 15, 15); handle.CanCollide = false end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.05)
        if coinFarmEnabled and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            for _, o in pairs(workspace:GetDescendants()) do
                if o.Name == "CoinContainer" or o.Name == "Coin" or o.Name == "CoinVisual" then
                    if o:IsA("BasePart") then LP.Character.HumanoidRootPart.CFrame = o.CFrame break end
                end
            end
        end
    end
end)

RunService.Stepped:Connect(function()
    if noclipEnabled and LP.Character then
        for _, part in pairs(LP.Character:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end
    end
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if jumpEnabled and LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then
        LP.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

RunService.Heartbeat:Connect(function()
    local h = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if h then h.WalkSpeed = speedEnabled and 45 or 16 end
end)

toggleNetworkAnimation(true)
print("SEBAS EXPLOITS DE MM2 CARGADO AL 100% CON ID DE TEXTURA FIJA")
