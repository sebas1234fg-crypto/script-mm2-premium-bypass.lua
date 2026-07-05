-- ============================================================================= --
-- CONFIGURACIÓN DE LA INTERFAZ: ⚡ SΞBΛS | ΞXPLØITS ⚡                         --
-- ============================================================================= --

local ScreenGui = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
ScreenGui.Name = "SebasExploitsPanel"
ScreenGui.ResetOnSpawn = false

-- Contenedor Principal (Más oscuro para que resalten las letras y el neón)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 240, 0, 270) -- Ajustado un poco el ancho por el nombre largo
MainFrame.Position = UDim2.new(0.02, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 10)

-- Borde de Neón alrededor del Panel
local PanelStroke = Instance.new("UIStroke", MainFrame)
PanelStroke.Thickness = 1.5
PanelStroke.Color = Color3.fromRGB(0, 170, 255) -- Azul Eléctrico
PanelStroke.Transparency = 0.3

-- ============================================================================= --
-- TÍTULO DECORADO CON TU MARCA
-- ============================================================================= --
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Text = "⚡ SΞBΛS | ΞXPLØITS ⚡"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16 -- Ajustado para que quepa perfectamente sin cortarse
Title.TextXAlignment = Enum.TextXAlignment.Center

-- Efecto Glow/Sombra para las letras especiales
Title.TextStrokeTransparency = 0.5
Title.TextStrokeColor3 = Color3.fromRGB(0, 130, 255)

-- Línea divisoria estilo Cyber
local Line = Instance.new("Frame", MainFrame)
Line.Size = UDim2.new(0.85, 0, 0, 1)
Line.Position = UDim2.new(0.075, 0, 0, 45)
Line.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Line.BorderSizePixel = 0
Line.BackgroundTransparency = 0.4
