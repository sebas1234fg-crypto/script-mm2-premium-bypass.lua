-- =============================================================================
-- DELTA MM2 MEGA MENU - ULTRA PREMIUM (EDICIÓN COMBAT EXTENDED V3.5 - HYPERCOLOR)
-- CON INTRO HOLOGRÁFICA "SEBAS EXPLOITS"
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
local RestoreButton = Instance.new("TextButton")

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LP = game:GetService("Players").LocalPlayer

-- VARIABLES GLOBALES DE LOS HACKS
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

local espHighlights = {}
local tracerLines = {}
local radarFrame = nil
local originalCameraType = workspace.CurrentCamera.CameraType

local ghostCharacter = nil
local originalPosition = nil
local invisibleLoop = nil

local activeFloaters = {}
local nodes = {}
local currentThemeColor = Color3.fromRGB(0, 150, 255) 

-- --- FUNCIONES DE LIMPIEZA ---
local function clearEsp()
    for _, h in pairs(espHighlights) do if h then h:Destroy() end end
    table.clear(espHighlights)
end

local function clearTracers()
    for _, line in pairs(tracerLines) do if line then line:Destroy() end end
    table.clear(tracerLines)
end

local function getMurderer()
    for _, p in pairs(game:GetService("Players"):GetPlayers()) do
        if p.Backpack:FindFirstChild("Knife") or (p.Character and p.Character:FindFirstChild("Knife")) then return p end
    end
    return nil
end

local function getSheriff()
    for _, p in pairs(game:GetService("Players"):GetPlayers()) do
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

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- =============================================================================
-- ANIMACIÓN DE ENTRADA ULTRA BACANA: SEBAS EXPLOITS (MM2)
-- =============================================================================
local IntroContainer = Instance.new("Frame")
IntroContainer.Name = "SebasIntroContainer"
IntroContainer.Size = UDim2.new(1, 0, 1, 0)
IntroContainer.BackgroundTransparency = 1 -- Fondo completamente transparente solicitado
IntroContainer.ZIndex = 100
IntroContainer.Parent = ScreenGui

local IntroText = Instance.new("TextLabel")
IntroText.Name = "IntroText"
IntroText.Parent = IntroContainer
IntroText.BackgroundTransparency = 1
IntroText.Position = UDim2.new(0.5, 0, 0.5, 0)
IntroText.Size = UDim2.new(0, 0, 0, 0) -- Inicia desde tamaño cero para expandirse
IntroText.AnchorPoint = Vector2.new(0.5, 0.5)
IntroText.Text = "SEBAS EXPLOITS (MM2)"
IntroText.Font = Enum.Font.FredokaOne -- Estilo robusto y moderno
IntroText.TextColor3 = Color3.fromRGB(0, 180, 255) -- Azul eléctrico Cyberpunk
IntroText.TextSize = 1 -- Empieza minúsculo
IntroText.TextTransparency = 1
IntroText.ZIndex = 101

-- Efecto de resplandor / Sombra de texto azul
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(0, 80, 255)
UIStroke.Thickness = 3
UIStroke.Transparency = 1
UIStroke.Parent = IntroText

-- Ejecución de la intro cinemática
task.spawn(function()
    MainPanel.Visible = false -- Mantiene oculto el panel mientras corre la intro
    task.wait(0.2)
    
    -- 1. Efecto Glitch/Parpadeo inicial de aparición
    for i = 1, 3 do
        IntroText.TextTransparency = 0.3
        UIStroke.Transparency = 0.3
        task.wait(0.06)
        IntroText.TextTransparency = 1
        UIStroke.Transparency = 1
        task.wait(0.04)
    end
    
    -- 2. Expansión física (Tween) hacia el centro de la pantalla
    IntroText.TextTransparency = 0
    UIStroke.Transparency = 0
    
    local textTween = TweenService:Create(IntroText, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 600, 0, 100),
        TextSize = 42
    })
    textTween:Play()
    textTween.Completed:Wait()
    
    -- 3. Pequeño efecto dinámico de pulso sutil mientras se lee
    TweenService:Create(IntroText, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {
        Size = UDim2.new(0, 630, 0, 110),
        TextColor3 = Color3.fromRGB(0, 230, 255)
    }):Play()
    
    task.wait(1.5) -- Tiempo de exposición del logo en pantalla
    
    -- 4. Desvanecimiento suave e interpolado (Fade Out)
    local fadeTween = TweenService:Create(IntroText, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        TextTransparency = 1
    })
    local strokeTween = TweenService:Create(UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Transparency = 1
    })
    
    fadeTween:Play()
    strokeTween:Play()
    fadeTween.Completed:Wait()
    
    IntroContainer:Destroy() -- Limpieza absoluta del contenedor de la intro
    MainPanel.Visible = true -- Despliega el menú listo para la acción
end)

-- =============================================================================
-- CONFIGURACIÓN PANEL PRINCIPAL Y SISTEMAS
-- =============================================================================
MainPanel.Name = "DeltaMM2UltraPremium"
MainPanel.Parent = ScreenGui
MainPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainPanel.Position = UDim2.new(0.25, 0, 0.15, 0)
MainPanel.Size = UDim2.new(0, 420, 0, 390)
MainPanel.Active = true
MainPanel.Draggable = true
MainPanel.ClipsDescendants = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainPanel

local NetworkBackground = Instance.new("Frame")
NetworkBackground.Name = "NetworkBackground"
NetworkBackground.Size = UDim2.new(1, 0, 1, 0)
NetworkBackground.BackgroundTransparency = 1
NetworkBackground.ZIndex = 1 
NetworkBackground.Parent = MainPanel

local function toggleNetworkAnimation(state)
    animationEnabled = state
    if animationEnabled then
        if #nodes == 0 then
            for i = 1, 22 do
                local dot = Instance.new("Frame")
                dot.Size = UDim2.new(0, 6, 0, 6)
                dot.BackgroundColor3 = currentThemeColor
                dot.BackgroundTransparency = 0 
                dot.BorderSizePixel = 0
                dot.Position = UDim2.new(math.random(), 0, math.random(), 0)
                dot.ZIndex = 1
                dot.Parent = NetworkBackground
                
                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(1, 0)
                corner.Parent = dot
                
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
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.ZIndex = 2

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

TitleText.Parent = TitleBar
TitleText.Size = UDim2.new(0.65, 0, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.Text = "Delta MM2 - Custom Master Menu"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 14
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.ZIndex = 3

MinimizeButton.Parent = TitleBar
MinimizeButton.Position = UDim2.new(0.78, 0, 0.15, 0)
MinimizeButton.Size = UDim2.new(0, 30, 0, 28)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 16
MinimizeButton.ZIndex = 3
Instance.new("UICorner", MinimizeButton).CornerRadius = UDim.new(0, 6)

CloseButton.Parent = TitleBar
CloseButton.Position = UDim2.new(0.88, 0, 0.15, 0)
CloseButton.Size = UDim2.new(0, 35, 0, 28)
CloseButton.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14
CloseButton.ZIndex = 3
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 6)

TabBar.Name = "TabBar"
TabBar.Parent = MainPanel
TabBar.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
TabBar.Position = UDim2.new(0, 0, 0, 40)
TabBar.Size = UDim2.new(0, 105, 1, -40)
TabBar.ZIndex = 2

ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainPanel
ContentFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
ContentFrame.BackgroundTransparency = 0.15
ContentFrame.Position = UDim2.new(0, 105, 0, 40)
ContentFrame.Size = UDim2.new(1, -105, 1, -40)
ContentFrame.ZIndex = 2

local function styleTabBtn(btn, text, yPos)
    btn.Parent = TabBar
    btn.Size = UDim2.new(0, 95, 0, 35)
    btn.Position = UDim2.new(0, 5, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
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
    frm.CanvasSize = UDim2.new(0, 0, 3.5, 0)
    frm.Visible = false
    frm.ZIndex = 3
end

setupSubFrame(CombatFrame)
setupSubFrame(VisualsFrame)
setupSubFrame(MiscFrame)

CombatFrame.Visible = true
TabCombat.BackgroundColor3 = Color3.fromRGB(0, 120, 200)

local function switchTab(selectedFrame, selectedBtn)
    CombatFrame.Visible = false; VisualsFrame.Visible = false; MiscFrame.Visible = false
    TabCombat.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabVisuals.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabMisc.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    selectedFrame.Visible = true
    selectedBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
end

TabCombat.MouseButton1Click:Connect(function() switchTab(CombatFrame, TabCombat) end)
TabVisuals.MouseButton1Click:Connect(function() switchTab(VisualsFrame, TabVisuals) end)
TabMisc.MouseButton1Click:Connect(function() switchTab(MiscFrame, TabMisc) end)

RestoreButton.Parent = ScreenGui
RestoreButton.Position = UDim2.new(0.05, 0, 0.3, 0)
RestoreButton.Size = UDim2.new(0, 55, 0, 55)
RestoreButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
RestoreButton.Text = "MM2"
RestoreButton.TextColor3 = Color3.fromRGB(0, 255, 150)
RestoreButton.TextSize = 14
RestoreButton.Visible = false
RestoreButton.Draggable = true
Instance.new("UICorner", RestoreButton).CornerRadius = UDim.new(0, 12)

MinimizeButton.MouseButton1Click:Connect(function() MainPanel.Visible = false; RestoreButton.Visible = true end)
RestoreButton.MouseButton1Click:Connect(function() MainPanel.Visible = true; RestoreButton.Visible = false end)
CloseButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- DECLARACIÓN DE BOTONES
local ClickShootButton = Instance.new("TextButton")
local KillAllKnifeButton = Instance.new("TextButton")
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

local CoinButton = Instance.new("TextButton")
local NoclipButton = Instance.new("TextButton")
local JumpButton = Instance.new("TextButton")
local SpeedButton = Instance.new("TextButton")
local BrightButton = Instance.new("TextButton")
local FreecamButton = Instance.new("TextButton")
local InvisibleButton = Instance.new("TextButton")
local AnimToggleButton = Instance.new("TextButton") 
local ResetButton = Instance.new("TextButton")

-- DISPARADORES EJECUTABLES
local function triggerAction(btn)
    if btn == ClickShootButton then
        clickShootEnabled = not clickShootEnabled
        ClickShootButton.BackgroundColor3 = clickShootEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(150, 40, 40)
        ClickShootButton.Text = clickShootEnabled and "Clic para Disparar Asesino: ON" or "Clic para Disparar Asesino: OFF"
    elseif btn == KillAllKnifeButton then
        killAllKnifeEnabled = not killAllKnifeEnabled
        KillAllKnifeButton.BackgroundColor3 = killAllKnifeEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(180, 0, 50)
        KillAllKnifeButton.Text = killAllKnifeEnabled and "Kill All con Cuchillo (Aura): ON" or "Kill All con Cuchillo (Aura): OFF"
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
            radarFrame = Instance.new("Frame")
            radarFrame.Size = UDim2.new(0, 120, 0, 120)
            radarFrame.Position = UDim2.new(0, 10, 0, 150)
            radarFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            radarFrame.BackgroundTransparency = 0.3
            radarFrame.Parent = ScreenGui
            Instance.new("UICorner", radarFrame).CornerRadius = UDim.new(0, 8)
        else
            if radarFrame then radarFrame:Destroy(); radarFrame = nil end
        end
    elseif btn == OverlayButton then
        overlayEnabled = not overlayEnabled
        OverlayButton.BackgroundColor3 = overlayEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(140, 140, 0)
        OverlayButton.Text = overlayEnabled and "Nivel Info sobre Cabeza: ON" or "Nivel Info sobre Cabeza: OFF"
    elseif btn == CoinButton then
        coinFarmEnabled = not coinFarmEnabled
        CoinButton.BackgroundColor3 = coinFarmEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(160, 120, 0)
        CoinButton.Text = coinFarmEnabled and "Farmear Monedas (Seguro): ON" or "Farmear Monedas (Seguro): OFF"
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
        SpeedButton.Text = speedEnabled and "Velocidad Humana: ON" or "Velocidad Humana (+50%): OFF"
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
                
                local skyPlatform = Instance.new("Part")
                skyPlatform.Name = "SkyAnchor_Delta"
                skyPlatform.Size = Vector3.new(12, 1, 12)
                skyPlatform.CFrame = CFrame.new(originalPosition.Position.X, 1000, originalPosition.Position.Z)
                skyPlatform.Anchored = true
                skyPlatform.Transparency = 1
                skyPlatform.Parent = workspace
                
                ghostCharacter = char:Clone()
                ghostCharacter.Name = "Ghost_Ghost"
                
                for _, part in pairs(ghostCharacter:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Transparency = 0.5; part.CanCollide = false
                    elseif part:IsA("Decal") then
                        part.Transparency = 0.5
                    end
                end
                
                ghostCharacter.Parent = workspace
                workspace.CurrentCamera.CameraSubject = ghostCharacter:FindFirstChild("Humanoid")
                root.CFrame = skyPlatform.CFrame + Vector3.new(0, 3, 0)
                task.wait(0.04)
                
                invisibleLoop = RunService.Heartbeat:Connect(function()
                    if ghostCharacter and char and root and workspace:FindFirstChild("SkyAnchor_Delta") then
                        local moveDirection = char.Humanoid.MoveDirection
                        ghostCharacter.Humanoid:Move(moveDirection, false)
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
            local skyPlatform = workspace:FindFirstChild("SkyAnchor_Delta")
            if skyPlatform then skyPlatform:Destroy() end
            
            if ghostCharacter then
                if root and ghostCharacter:FindFirstChild("HumanoidRootPart") then
                    root.CFrame = ghostCharacter.HumanoidRootPart.CFrame
                elseif originalPosition then
                    root.CFrame = originalPosition
                end
                ghostCharacter:Destroy(); ghostCharacter = nil
            end
            if char and char:FindFirstChild("Humanoid") then workspace.CurrentCamera.CameraSubject = char.Humanoid end
        end
    elseif btn == AnimToggleButton then
        local state = not animationEnabled
        toggleNetworkAnimation(state)
        AnimToggleButton.BackgroundColor3 = state and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(0, 100, 200)
        AnimToggleButton.Text = state and "Animación de Red: ON" or "Animación de Red: OFF"
    elseif btn == TeleportButton then
        local localChar = LP.Character
        local localRoot = localChar and localChar:FindFirstChild("HumanoidRootPart")
        if not localRoot then return end
        local gunDrop = workspace:FindFirstChild("GunDrop") or workspace:FindFirstChild("Gun")
        if gunDrop and gunDrop:IsA("BasePart") then
            local posicionSegura = localRoot.CFrame
            localRoot.CFrame = gunDrop.CFrame
            task.wait(0.12)
            if localRoot and localChar:FindFirstChildOfClass("Humanoid").Health > 0 then localRoot.CFrame = posicionSegura end
        else
            local sheriff = getSheriff()
            if sheriff and sheriff.Character and sheriff.Character:FindFirstChild("HumanoidRootPart") then localRoot.CFrame = sheriff.Character.HumanoidRootPart.CFrame + Vector3.new(0, 4, 0) end
        end
    elseif btn == ResetButton then
        local h = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        if h then h.Health = 0 end
    end
end

-- BUCLE KILL ALL
RunService.Heartbeat:Connect(function()
    if killAllKnifeEnabled and LP.Character then
        local myRoot = LP.Character:FindFirstChild("HumanoidRootPart")
        local knife = LP.Character:FindFirstChild("Knife")
        
        if myRoot and knife then
            for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                if player ~= LP and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local targetHumanoid = player.Character:FindFirstChildOfClass("Humanoid")
                    if targetHumanoid and targetHumanoid.Health > 0 then
                        myRoot.CFrame = player.Character.HumanoidRootPart.CFrame
                        knife:Activate()
                        task.wait(0.02)
                    end
                end
            end
        end
    end
end)

-- SISTEMA FLOTANTE
local function setupFloatingSystem(mainButton)
    local isHolding = false
    local holdingTime = 0.8

    mainButton.MouseButton1Down:Connect(function()
        isHolding = true
        task.wait(holdingTime)
        if isHolding then
            local existingFloater = activeFloaters[mainButton]
            if existingFloater and existingFloater.Parent then
                local currentPos = existingFloater.Position
                local targetX = currentPos.X.Offset + (existingFloater.Size.X.Offset / 2)
                local targetY = currentPos.Y.Offset + (existingFloater.Size.Y.Offset / 2)
                
                local tweenOut = TweenService:Create(existingFloater, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                    Size = UDim2.new(0, 0, 0, 0),
                    Position = UDim2.new(currentPos.X.Scale, targetX, currentPos.Y.Scale, targetY)
                })
                tweenOut:Play()
                tweenOut.Completed:Connect(function() existingFloater:Destroy() end)
                activeFloaters[mainButton] = nil
            else
                local floatBtn = Instance.new("TextButton")
                floatBtn.Parent = ScreenGui
                floatBtn.BackgroundColor3 = mainButton.BackgroundColor3
                floatBtn.Text = mainButton.Text
                floatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                floatBtn.TextSize = 11
                floatBtn.Active = true
                floatBtn.Draggable = true
                Instance.new("UICorner", floatBtn).CornerRadius = UDim.new(0, 6)
                
                floatBtn.Size = UDim2.new(0, 0, 0, 0)
                floatBtn.Position = UDim2.new(0.5, 0, 0.5, 0)
                
                TweenService:Create(floatBtn, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Size = UDim2.new(0, 200, 0, 32),
                    Position = UDim2.new(0.45, 0, 0.45, 0)
                }):Play()
                
                local connection
                connection = mainButton:GetPropertyChangedSignal("Text"):Connect(function()
                    if floatBtn and floatBtn.Parent then
                        floatBtn.Text = mainButton.Text
                        floatBtn.BackgroundColor3 = mainButton.BackgroundColor3
                    else
                        connection:Disconnect()
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
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
    btn.TextWrapped = true
    btn.ZIndex = 4
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 7)
    setupFloatingSystem(btn)
end

-- DISTRIBUCIÓN BOTONES
styleHackBtn(ClickShootButton, CombatFrame, "Clic para Disparar Asesino: OFF", 10, Color3.fromRGB(150, 40, 40))
styleHackBtn(KillAllKnifeButton, CombatFrame, "Kill All con Cuchillo (Aura): OFF", 50, Color3.fromRGB(180, 0, 50))
styleHackBtn(TeleportButton, CombatFrame, "Teleport a Sheriff / Pistola", 90, Color3.fromRGB(0, 80, 160))
styleHackBtn(HitboxButton, CombatFrame, "Agrandar Hitbox Cuchillo: OFF", 130, Color3.fromRGB(130, 40, 130))
styleHackBtn(AutoHoldButton, CombatFrame, "Auto-Equipar Armas: OFF", 170, Color3.fromRGB(50, 50, 50))
styleHackBtn(SheathButton, CombatFrame, "Auto-Esconder Cuchillo: OFF", 210, Color3.fromRGB(70, 40, 20))
styleHackBtn(FakeLagButton, CombatFrame, "Lag Táctico (FakeLag): OFF", 250, Color3.fromRGB(100, 100, 100))
styleHackBtn(SheriffAimbotButton, CombatFrame, "Safe Aimbot Sheriff: OFF", 290, Color3.fromRGB(0, 140, 150))

styleHackBtn(EspButton, VisualsFrame, "Ver Roles (ESP): DESACTIVADO", 10, Color3.fromRGB(80, 40, 120))
styleHackBtn(TracerButton, VisualsFrame, "Líneas de Rastreo (Tracers): OFF", 50, Color3.fromRGB(120, 60, 20))
styleHackBtn(RadarButton, VisualsFrame, "Radar 2D Portátil: DESACTIVADO", 90, Color3.fromRGB(20, 100, 60))
styleHackBtn(AmmoButton, VisualsFrame, "Rastreador de Balas Sheriff: OFF", 130, Color3.fromRGB(0, 100, 150))
styleHackBtn(OverlayButton, VisualsFrame, "Nivel Info sobre Cabeza: OFF", 170, Color3.fromRGB(140, 140, 0))

styleHackBtn(CoinButton, MiscFrame, "Farmear Monedas (Seguro): OFF", 10, Color3.fromRGB(160, 120, 0))
styleHackBtn(NoclipButton, MiscFrame, "Noclip (Paredes): OFF", 50, Color3.fromRGB(70, 70, 70))
styleHackBtn(JumpButton, MiscFrame, "Salto Infinito: DESACTIVADO", 90, Color3.fromRGB(0, 120, 120))
styleHackBtn(SpeedButton, MiscFrame, "Velocidad Humana (+50%): OFF", 130, Color3.fromRGB(40, 140, 100))
styleHackBtn(BrightButton, MiscFrame, "Brillo Total (FullBright): OFF", 170, Color3.fromRGB(180, 140, 40))
styleHackBtn(FreecamButton, MiscFrame, "Cámara Libre Invisible: OFF", 210, Color3.fromRGB(120, 0, 120))
styleHackBtn(InvisibleButton, MiscFrame, "Modo Invisible (Fantasma): OFF", 250, Color3.fromRGB(0, 150, 150))
styleHackBtn(AnimToggleButton, MiscFrame, "Animación de Red: ON", 290, Color3.fromRGB(0, 100, 200)) 
styleHackBtn(ResetButton, MiscFrame, "Suicidio de Emergencia (Reset)", 330, Color3.fromRGB(180, 0, 0))

-- SLIDER DE COLORES SINCRO
SliderLabel.Parent = MiscFrame; SliderLabel.Size = UDim2.new(0, 280, 0, 15); SliderLabel.Position = UDim2.new(0, 12, 0, 375); SliderLabel.ZIndex = 4
SliderLabel.BackgroundTransparency = 1; SliderLabel.Text = "Desliza para cambiar el color del panel e intensificar la red:"; SliderLabel.TextColor3 = Color3.fromRGB(200, 200, 200); SliderLabel.TextSize = 10

SliderFrame.Parent = MiscFrame; SliderFrame.Size = UDim2.new(0, 280, 0, 12); SliderFrame.Position = UDim2.new(0, 12, 0, 395); SliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50); SliderFrame.ZIndex = 4
Instance.new("UICorner", SliderFrame).CornerRadius = UDim.new(0, 4)

SliderButton.Parent = SliderFrame; SliderButton.Size = UDim2.new(0, 20, 1, 0); SliderButton.Position = UDim2.new(0, 0, 0, 0); SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255); SliderButton.Text = ""; SliderButton.ZIndex = 5
Instance.new("UICorner", SliderButton).CornerRadius = UDim.new(0, 4)

local draggingColor = false
local function updateSliderColor(input)
    local relativeX = input.Position.X - SliderFrame.AbsolutePosition.X
    local percentage = math.clamp(relativeX / SliderFrame.AbsoluteSize.X, 0, 1)
    SliderButton.Position = UDim2.new(percentage, -10, 0, 0)
    
    local baseColor = Color3.fromHSV(percentage, 0.95, 0.45)
    local darkerColor = Color3.fromHSV(percentage, 0.95, 0.35)
    local darkestColor = Color3.fromHSV(percentage, 0.95, 0.2)
    
    currentThemeColor = Color3.fromHSV(percentage, 1, 1)
    
    MainPanel.BackgroundColor3 = darkestColor
    TitleBar.BackgroundColor3 = darkerColor
    TabBar.BackgroundColor3 = darkerColor
    ContentFrame.BackgroundColor3 = baseColor
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

-- RENDERS DE RASTREO
RunService.Heartbeat:Connect(function()
    clearEsp()
    clearTracers()
    if radarFrame and radarEnabled then for _, c in pairs(radarFrame:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end end
    
    local Camera = workspace.CurrentCamera
    local localRoot = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    
    for _, p in pairs(game:GetService("Players"):GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local color = Color3.fromRGB(255, 255, 255)
            if p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife") then color = Color3.fromRGB(255, 0, 0)
            elseif p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun") then color = Color3.fromRGB(0, 100, 255)
                if ammoEnabled then
                    AmmoButton.Text = p.Character:FindFirstChild("Gun") and "Sheriff: ¡TIRO LISTO Y APUNTANDO!" or "Sheriff: Recargando / Guardado"
                    AmmoButton.BackgroundColor3 = p.Character:FindFirstChild("Gun") and Color3.fromRGB(180, 50, 50) or Color3.fromRGB(40, 140, 40)
                end
            end
            if espEnabled then
                local h = Instance.new("Highlight")
                h.Adornee = p.Character; h.FillColor = color; h.FillTransparency = 0.5; h.OutlineColor = color; h.OutlineTransparency = 0; h.Parent = ScreenGui
                table.insert(espHighlights, h)
            end
            if tracersEnabled then
                local vector, onScreen = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
                if onScreen then
                    local Line = Instance.new("Frame")
                    Line.Parent = ScreenGui; Line.BackgroundColor3 = color; Line.BorderSizePixel = 0
                    local startPos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    local endPos = Vector2.new(vector.X, vector.Y)
                    local distance = (endPos - startPos).Magnitude
                    Line.Size = UDim2.new(0, distance, 0, 2)
                    Line.Position = UDim2.new(0, (startPos.X + endPos.X) / 2 - distance / 2, 0, (startPos.Y + endPos.Y) / 2)
                    Line.Rotation = math.deg(math.atan2(endPos.Y - startPos.Y, endPos.X - startPos.X))
                    table.insert(tracerLines, Line)
                end
            end
            if radarFrame and radarEnabled and localRoot then
                local diff = p.Character.HumanoidRootPart.Position - localRoot.Position
                local x = (diff.X * 0.5) + 60
                local z = (diff.Z * 0.5) + 60
                if x > 0 and x < 120 and z > 0 and z < 120 then
                    local dot = Instance.new("Frame")
                    dot.Size = UDim2.new(0, 4, 0, 4); dot.Position = UDim2.new(0, x - 2, 0, z - 2); dot.BackgroundColor3 = color; dot.Parent = radarFrame
                end
            end
            if overlayEnabled and p.Character:FindFirstChild("Head") and not p.Character.Head:FindFirstChild("InfoTag") then
                local tag = Instance.new("BillboardGui")
                tag.Name = "InfoTag"; tag.Size = UDim2.new(0, 200, 0, 50); tag.AlwaysOnTop = true; tag.StudsOffset = Vector3.new(0, 2.5, 0); tag.Parent = p.Character.Head
                local txt = Instance.new("TextLabel")
                txt.Size = UDim2.new(1, 0, 1, 0); txt.BackgroundTransparency = 1; txt.TextSize = 12; txt.TextColor3 = Color3.fromRGB(255, 255, 255)
                txt.Text = p.Name .. " (Nivel: " .. tostring(p:GetAttribute("Level") or "??") .. ")"; txt.Parent = tag
            end
        end
    end
end)

-- DETECCIONES DE ACCIÓN SECUNDARIAS
RunService.RenderStepped:Connect(function()
    if aimbotEnabled and LP.Character and LP.Character:FindFirstChild("Gun") then
        local targetPart = getAimbotTarget()
        if targetPart then
            local cam = workspace.CurrentCamera
            cam.CFrame = CFrame.new(cam.CFrame.Position, targetPart.Position)
        end
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
    if not processed and clickShootEnabled and input.UserInputType == Enum.UserInputType.MouseButton1 then
        local murderer = getMurderer()
        if murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") then
            local gun = LP.Character and LP.Character:FindFirstChild("Gun")
            if gun then gun:Activate() end
        end
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if hitboxEnabled and LP.Character then
            local knife = LP.Character:FindFirstChild("Knife")
            if knife then
                for _, part in pairs(knife:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false; part.Massless = true end
                end
                local handle = knife:FindFirstChild("Handle")
                if handle then handle.Size = Vector3.new(15, 15, 15) end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.3) do
        if autoHoldEnabled and LP.Character then
            local weapon = LP.Backpack:FindFirstChild("Knife") or LP.Backpack:FindFirstChild("Gun")
            if weapon then weapon.Parent = LP.Character end
        end
    end
end)

task.spawn(function()
    while task.wait(0.2) do
        if sheathEnabled and LP.Character and LP.Character:FindFirstChild("Knife") then
            LP.Character.Knife.Parent = LP.Backpack
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if coinFarmEnabled and LP.Character then
            local root = LP.Character:FindFirstChild("HumanoidRootPart")
            if root then
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj.Name == "CoinContainer" or obj.Name == "Coin" or obj.Name == "CoinVisual" then
                        if obj:IsA("BasePart") then root.CFrame = obj.CFrame; break end
                    end
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

game:GetService("UserInputService").MakeControlledJump = game:GetService("UserInputService").JumpRequest:Connect(function()
    if jumpEnabled and LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then
        LP.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

RunService.Heartbeat:Connect(function()
    local h = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if h then h.WalkSpeed = speedEnabled and 24 or 16 end
end)

RunService.RenderStepped:Connect(function()
    if freecamEnabled then
        local camera = workspace.CurrentCamera; local uis = game:GetService("UserInputService"); local speed = 1.5
        if uis:IsKeyDown(Enum.KeyCode.W) then camera.CFrame = camera.CFrame + camera.CFrame.LookVector * speed end
        if uis:IsKeyDown(Enum.KeyCode.S) then camera.CFrame = camera.CFrame - camera.CFrame.LookVector * speed end
        if uis:IsKeyDown(Enum.KeyCode.A) then camera.CFrame = camera.CFrame - camera.CFrame.RightVector * speed end
        if uis:IsKeyDown(Enum.KeyCode.D) then camera.CFrame = camera.CFrame + camera.CFrame.RightVector * speed end
    end
end)

toggleNetworkAnimation(true)
