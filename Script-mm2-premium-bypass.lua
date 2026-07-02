-- 1. MEGA MENU MM2 - INTERFAZ PREMIUM DE 3 CAPAS
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

-- Elementos de la Barra del Buscador de Color
local SliderLabel = Instance.new("TextLabel")
local SliderFrame = Instance.new("Frame")
local SliderButton = Instance.new("TextButton")
local RestoreButton = Instance.new("TextButton")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

MainPanel.Name = "DeltaMM2UltraPremium"
MainPanel.Parent = ScreenGui
MainPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainPanel.Position = UDim2.new(0.25, 0, 0.15, 0)
MainPanel.Size = UDim2.new(0, 360, 0, 280)
MainPanel.Active = true
MainPanel.Draggable = true

TitleBar.Name = "TitleBar"
TitleBar.Parent = MainPanel
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBar.Size = UDim2.new(1, 0, 0, 35)

TitleText.Parent = TitleBar
TitleText.Size = UDim2.new(0.5, 0, 1, 0)
TitleText.Text = "  Delta MM2 - Mega God Mode"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 13
TitleText.TextXAlignment = Enum.TextXAlignment.Left

MinimizeButton.Parent = TitleBar
MinimizeButton.Position = UDim2.new(0.74, 0, 0.1, 0)
MinimizeButton.Size = UDim2.new(0, 30, 0, 28)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 16

CloseButton.Parent = TitleBar
CloseButton.Position = UDim2.new(0.87, 0, 0.1, 0)
CloseButton.Size = UDim2.new(0, 35, 0, 28)
CloseButton.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14

TabBar.Name = "TabBar"
TabBar.Parent = MainPanel
TabBar.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
TabBar.Position = UDim2.new(0, 0, 0, 35)
TabBar.Size = UDim2.new(0, 95, 1, -35)

ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainPanel
ContentFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
ContentFrame.Position = UDim2.new(0, 95, 0, 35)
ContentFrame.Size = UDim2.new(1, -95, 1, -35)
local function styleTabBtn(btn, text, yPos)
    btn.Parent = TabBar
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Position = UDim2.new(0, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextSize = 13
end

styleTabBtn(TabCombat, "Combat", 5)
styleTabBtn(TabVisuals, "Visuals", 50)
styleTabBtn(TabMisc, "Misc", 95)

local function setupSubFrame(frm)
    frm.Parent = ContentFrame
    frm.Size = UDim2.new(1, 0, 1, 0)
    frm.BackgroundTransparency = 1
    frm.ScrollBarThickness = 5
    frm.CanvasSize = UDim2.new(0, 0, 2, 0) -- Permite hacer scroll si hay muchas funciones
    frm.Visible = false
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
RestoreButton.Size = UDim2.new(0, 50, 0, 50)
RestoreButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
RestoreButton.Text = "MM2"
RestoreButton.TextColor3 = Color3.fromRGB(0, 255, 150)
RestoreButton.TextSize = 14
RestoreButton.Visible = false
RestoreButton.Draggable = true

MinimizeButton.MouseButton1Click:Connect(function() MainPanel.Visible = false; RestoreButton.Visible = true end)
RestoreButton.MouseButton1Click:Connect(function() MainPanel.Visible = true; RestoreButton.Visible = false end)
CloseButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local function styleHackBtn(btn, parent, text, yPos, color)
    btn.Parent = parent
    btn.Size = UDim2.new(0, 230, 0, 30)
    btn.Position = UDim2.new(0.04, 0, 0, yPos)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 11
end
-- Declaración de Botones (Pestaña Combat)
local ClickShootButton = Instance.new("TextButton")
local TeleportButton = Instance.new("TextButton")
local HitboxButton = Instance.new("TextButton")
local AutoHoldButton = Instance.new("TextButton")
local SheathButton = Instance.new("TextButton")
local FakeLagButton = Instance.new("TextButton")

-- Declaración de Botones (Pestaña Visuals)
local EspButton = Instance.new("TextButton")
local TracerButton = Instance.new("TextButton")
local RadarButton = Instance.new("TextButton")
local AmmoButton = Instance.new("TextButton")
local OverlayButton = Instance.new("TextButton")

-- Declaración de Botones (Pestaña Misc)
local CoinButton = Instance.new("TextButton")
local NoclipButton = Instance.new("TextButton")
local JumpButton = Instance.new("TextButton")
local SpeedButton = Instance.new("TextButton")
local BrightButton = Instance.new("TextButton")
local FreecamButton = Instance.new("TextButton")
local ResetButton = Instance.new("TextButton")

-- Ubicar Botones de la Pestaña Combat
styleHackBtn(ClickShootButton, CombatFrame, "Clic para Disparar Asesino: OFF", 10, Color3.fromRGB(150, 40, 40))
styleHackBtn(TeleportButton, CombatFrame, "Teleport a Sheriff / Pistola", 45, Color3.fromRGB(0, 80, 160))
styleHackBtn(HitboxButton, CombatFrame, "Agrandar Hitbox del Cuchillo: OFF", 80, Color3.fromRGB(130, 40, 130))
styleHackBtn(AutoHoldButton, CombatFrame, "Auto-Equipar Armas: OFF", 115, Color3.fromRGB(50, 50, 50))
styleHackBtn(SheathButton, CombatFrame, "Auto-Esconder Cuchillo Sigiloso: OFF", 150, Color3.fromRGB(70, 40, 20))
styleHackBtn(FakeLagButton, CombatFrame, "Simular Lag Táctico (FakeLag): OFF", 185, Color3.fromRGB(100, 100, 100))

-- Ubicar Botones de la Pestaña Visuals
styleHackBtn(EspButton, VisualsFrame, "Ver Roles (ESP): DESACTIVADO", 10, Color3.fromRGB(80, 40, 120))
styleHackBtn(TracerButton, VisualsFrame, "Líneas de Rastreo (Tracers): OFF", 45, Color3.fromRGB(120, 60, 20))
styleHackBtn(RadarButton, VisualsFrame, "Radar 2D Portátil: DESACTIVADO", 80, Color3.fromRGB(20, 100, 60))
styleHackBtn(AmmoButton, VisualsFrame, "Rastreador de Balas del Sheriff: OFF", 115, Color3.fromRGB(0, 100, 150))
styleHackBtn(OverlayButton, VisualsFrame, "Nivel e Info sobre Cabeza: OFF", 150, Color3.fromRGB(140, 140, 0))

-- Ubicar Botones de la Pestaña Misc
styleHackBtn(CoinButton, MiscFrame, "Farmear Monedas (Seguro): OFF", 10, Color3.fromRGB(160, 120, 0))
styleHackBtn(NoclipButton, MiscFrame, "Noclip (Paredes): OFF", 45, Color3.fromRGB(70, 70, 70))
styleHackBtn(JumpButton, MiscFrame, "Salto Infinito: DESACTIVADO", 80, Color3.fromRGB(0, 120, 120))
styleHackBtn(SpeedButton, MiscFrame, "Velocidad Humana (+50% WalkSpeed): OFF", 115, Color3.fromRGB(40, 140, 100))
styleHackBtn(BrightButton, MiscFrame, "Brillo Total (FullBright): OFF", 150, Color3.fromRGB(180, 140, 40))
styleHackBtn(FreecamButton, MiscFrame, "Cámara Libre Invisible: OFF", 185, Color3.fromRGB(120, 0, 120))
styleHackBtn(ResetButton, MiscFrame, "Suicidio de Emergencia (Reset)", 220, Color3.fromRGB(180, 0, 0))

-- Barra Deslizante de Color Coordinada al Final de Misc
SliderLabel.Parent = MiscFrame; SliderLabel.Size = UDim2.new(0, 230, 0, 15); SliderLabel.Position = UDim2.new(0.04, 0, 0, 260)
SliderLabel.BackgroundTransparency = 1; SliderLabel.Text = "Desliza para cambiar el color del panel:"; SliderLabel.TextColor3 = Color3.fromRGB(200, 200, 200); SliderLabel.TextSize = 10

SliderFrame.Parent = MiscFrame; SliderFrame.Size = UDim2.new(0, 230, 0, 12); SliderFrame.Position = UDim2.new(0.04, 0, 0, 280)
SliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

SliderButton.Parent = SliderFrame; SliderButton.Size = UDim2.new(0, 20, 1, 0); SliderButton.Position = UDim2.new(0, 0, 0, 0)
SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255); SliderButton.Text = ""

local draggingColor = false
local function updateSliderColor(input)
    local relativeX = input.Position.X - SliderFrame.AbsolutePosition.X
    local percentage = math.clamp(relativeX / SliderFrame.AbsoluteSize.X, 0, 1)
    SliderButton.Position = UDim2.new(percentage, -10, 0, 0)
    local baseColor = Color3.fromHSV(percentage, 0.8, 0.4)
    local darkerColor = Color3.fromHSV(percentage, 0.8, 0.3)
    local darkestColor = Color3.fromHSV(percentage, 0.8, 0.2)
    MainPanel.BackgroundColor3 = darkestColor; TitleBar.BackgroundColor3 = darkerColor
    TabBar.BackgroundColor3 = darkerColor; ContentFrame.BackgroundColor3 = baseColor
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
-- Agrandar Hitbox del Cuchillo
HitboxButton.MouseButton1Click:Connect(function()
    hitboxEnabled = not hitboxEnabled
    HitboxButton.BackgroundColor3 = hitboxEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(130, 40, 130)
    HitboxButton.Text = hitboxEnabled and "Agrandar Hitbox del Cuchillo: ON" or "Agrandar Hitbox del Cuchillo: OFF"
end)

task.spawn(function()
    while task.wait(0.5) do
        if hitboxEnabled then
            local p = game:GetService("Players").LocalPlayer
            local knife = p.Character and p.Character:FindFirstChild("Knife")
            if knife and knife:FindFirstChild("Handle") then
                knife.Handle.Size = Vector3.new(15, 15, 15)
                knife.Handle.CanCollide = false
            end
        end
    end
end)

-- Auto-Equipar Armas
AutoHoldButton.MouseButton1Click:Connect(function()
    autoHoldEnabled = not autoHoldEnabled
    AutoHoldButton.BackgroundColor3 = autoHoldEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(50, 50, 50)
    AutoHoldButton.Text = autoHoldEnabled and "Auto-Equipar Armas: ON" or "Auto-Equipar Armas: OFF"
end)

task.spawn(function()
    while task.wait(0.3) do
        if autoHoldEnabled then
            local p = game:GetService("Players").LocalPlayer
            if p.Character then
                local weapon = p.Backpack:FindFirstChild("Knife") or p.Backpack:FindFirstChild("Gun")
                if weapon then weapon.Parent = p.Character end
            end
        end
    end
end)

-- Auto-Esconder Cuchillo Sigiloso
SheathButton.MouseButton1Click:Connect(function()
    sheathEnabled = not sheathEnabled
    SheathButton.BackgroundColor3 = sheathEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(70, 40, 20)
    SheathButton.Text = sheathEnabled and "Auto-Esconder Cuchillo Sigiloso: ON" or "Auto-Esconder Cuchillo Sigiloso: OFF"
end)

task.spawn(function()
    while task.wait(0.2) do
        if sheathEnabled then
            local p = game:GetService("Players").LocalPlayer
            local murderer = getMurderer()
            if murderer and p.Character and p.Character:FindFirstChild("Knife") then
                p.Character.Knife.Parent = p.Backpack
            end
        end
    end
end)

-- Simular Lag Táctico (FakeLag)
FakeLagButton.MouseButton1Click:Connect(function()
    fakeLagEnabled = not fakeLagEnabled
    FakeLagButton.BackgroundColor3 = fakeLagEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(100, 100, 100)
    FakeLagButton.Text = fakeLagEnabled and "Simular Lag Táctico (FakeLag): ON" or "Simular Lag Táctico (FakeLag): OFF"
    if fakeLagEnabled then
        settings().Network.IncomingReplicationLag = 1
    else
        settings().Network.IncomingReplicationLag = 0
    end
end)
-- Activar y Desactivar Ver Roles (ESP)
local function clearEsp()
    for _, h in pairs(espHighlights) do if h then h:Destroy() end end
    espHighlights = {}
end

EspButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    EspButton.BackgroundColor3 = espEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(80, 40, 120)
    EspButton.Text = espEnabled and "Ver Roles (ESP): ACTIVADO" or "Ver Roles (ESP): DESACTIVADO"
    if not espEnabled then clearEsp() end
end)

-- Activar y Desactivar Líneas de Rastreo (Tracers)
local function clearTracers()
    for _, line in pairs(tracerLines) do if line then line:Destroy() end end
    tracerLines = {}
end

TracerButton.MouseButton1Click:Connect(function()
    tracersEnabled = not tracersEnabled
    TracerButton.BackgroundColor3 = tracersEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(120, 60, 20)
    TracerButton.Text = tracersEnabled and "Líneas de Rastreo (Tracers): ON" or "Líneas de Rastreo (Tracers): OFF"
    if not tracersEnabled then clearTracers() end
end)

-- Activar e Interceptar el Rastreador de Balas del Sheriff
AmmoButton.MouseButton1Click:Connect(function()
    ammoEnabled = not ammoEnabled
    AmmoButton.BackgroundColor3 = ammoEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(0, 100, 150)
    AmmoButton.Text = ammoEnabled and "Rastreador de Balas del Sheriff: ON" or "Rastreador de Balas del Sheriff: OFF"
end)

-- Bucle Unificado para Sincronizar ESP, Tracers y Estado de Munición
game:GetService("RunService").Heartbeat:Connect(function()
    if not espEnabled and not tracersEnabled then return end
    clearEsp()
    clearTracers()
    
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local Camera = game:GetService("Workspace").CurrentCamera
    
    for _, p in pairs(game:GetService("Players"):GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local color = Color3.fromRGB(255, 255, 255) -- Ciudadano (Blanco)
            local isSpecial = false
            
            -- Detectar Roles por Equipamiento
            if p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife") then
                color = Color3.fromRGB(255, 0, 0) -- Asesino (Rojo)
                isSpecial = true
            elseif p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun") then
                color = Color3.fromRGB(0, 100, 255) -- Sheriff (Azul)
                isSpecial = true
                
                -- Si el rastreador de balas está activo y el Sheriff tiene la pistola en mano
                if ammoEnabled and p.Character:FindFirstChild("Gun") then
                    AmmoButton.Text = "Sheriff: ¡TIRO LISTO Y APUNTANDO!"
                    AmmoButton.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
                elseif ammoEnabled then
                    AmmoButton.Text = "Sheriff: Recargando / Arma Guardada"
                    AmmoButton.BackgroundColor3 = Color3.fromRGB(40, 140, 40)
                end
            end
            
            -- Dibujar el ESP (Silueta)
            if espEnabled then
                local h = Instance.new("Highlight")
                h.Adornee = p.Character
                h.FillColor = color
                h.FillTransparency = 0.5
                h.OutlineColor = color
                h.OutlineTransparency = 0
                h.Parent = ScreenGui
                table.insert(espHighlights, h)
            end
            
            -- Dibujar las Líneas Teledirigidas (Tracers)
            if tracersEnabled then
                local vector, onScreen = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
                if onScreen then
                    local Line = Instance.new("Frame")
                    Line.Parent = ScreenGui
                    Line.BackgroundColor3 = color
                    Line.BorderSizePixel = 0
                    
                    -- Punto de inicio: Centro inferior de la pantalla táctil
                    local startPos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    local endPos = Vector2.new(vector.X, vector.Y)
                    local distance = (endPos - startPos).Magnitude
                    
                    Line.Size = UDim2.new(0, distance, 0, 2)
                    Line.Position = UDim2.new(0, (startPos.X + endPos.X) / 2 - distance / 2, 0, (startPos.Y + endPos.Y) / 2)
                    Line.Rotation = math.deg(math.atan2(endPos.Y - startPos.Y, endPos.X - startPos.X))
                    table.insert(tracerLines, Line)
                end
            end
        end
    end
end)
