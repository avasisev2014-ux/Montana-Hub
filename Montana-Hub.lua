-- Montano Hub | Cinematic Loader & Full Hub Integration
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Кастомная заставка
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MontanoLoader"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(1, 0, 1, 0)
Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 400, 0, 50)
Title.Position = UDim2.new(0.5, -200, 0.4, -40)
Title.Text = "Montano Hub Loading..."
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24
Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1
Title.Parent = Frame

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(0, 400, 0, 30)
Subtitle.Position = UDim2.new(0.5, -200, 0.4, 10)
Subtitle.Text = "Welcome, " .. LocalPlayer.Name .. "!"
Subtitle.TextColor3 = Color3.fromRGB(0, 255, 128)
Subtitle.TextSize = 18
Subtitle.Font = Enum.Font.Gotham
Subtitle.BackgroundTransparency = 1
Subtitle.Parent = Frame

local ConfirmBtn = Instance.new("TextButton")
ConfirmBtn.Size = UDim2.new(0, 220, 0, 50)
ConfirmBtn.Position = UDim2.new(0.5, -110, 0.55, 0)
ConfirmBtn.BackgroundColor3 = Color3.fromRGB(50, 205, 50)
ConfirmBtn.Text = "ПРОДОЛЖИТЬ"
ConfirmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmBtn.TextSize = 18
ConfirmBtn.Font = Enum.Font.GothamBold
ConfirmBtn.Parent = Frame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = ConfirmBtn

-- Проигрывание звука
local Sound = Instance.new("Sound")
Sound.SoundId = "rbxassetid://111646190557344"
Sound.Volume = 2
Sound.Parent = SoundService
Sound:Play()

local function LoadHub()
    ScreenGui:Destroy()
    Sound:Destroy()
    
    -- Инициализация самого хаба
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

    if not _G.MontanoSettings then
        _G.MontanoSettings = {
            CurrentLang = "RU",
            CurrentTheme = "Default",
            AimbotEnabled = false,
            AimMode = "Аимбот",
            Wallhack = true,
            WallCheck = false,
            FOV = 150,
            ShowFOV = true,
            FOVColor = Color3.fromRGB(255, 255, 255),
            TargetPart = "Head",
            AimType = "Smooth",
            Smoothness = 5,
            WalkSpeed = 16,
            SpeedHackEnabled = false,
            JumpPower = 50,
            JumpHackEnabled = false,
            InfJump = false,
            Noclip = false,
            AntiAFK = true,
            SelectedTrollTarget = nil,
            TrollingActive = false
        }
    end

    local Settings = _G.MontanoSettings

    local Locales = {
        RU = {
            WindowTitle = "Montano Hub",
            Loading = "Загрузка Montano Hub...",
            TabCombat = "Бой",
            TabVisuals = "Визуал",
            TabMovement = "Движение",
            TabTroll = "Троллинг",
            TabRadio = "Радио",
            TabSettings = "Настройки",
            ToggleAimbot = "Включить Аимбот",
            WallCheck = "Проверка стен (Игнорить за стеной)",
            ModeLabel = "Режим работы",
            ModeAimbot = "Аимбот",
            ModeSilent = "Сайлент Аим (Временно не работает)",
            TargetPart = "Часть тела для прицела",
            AimType = "Тип наводки",
            AimSmooth = "Плавный",
            AimSnap = "Резкий (Моментальный)",
            Smoothness = "Плавность наводки",
            FOVSize = "Размер круга FOV",
            ShowFOVToggle = "Отображать круг FOV",
            FOVColorLabel = "Цвет круга FOV",
            Wallhack = "Валхак (Подсветка через стены)",
            SpeedToggle = "Включить Speedhack",
            SpeedSlider = "Скорость бега",
            JumpToggle = "Включить высокий прыжок",
            JumpSlider = "Сила прыжка",
            InfJumpToggle = "Бесконечный прыжок",
            NoclipToggle = "Проход сквозь стены (Noclip)",
            TrollSelect = "Выбрать игрока для троллинга",
            TrollToggle = "Флинг (С возвратом на место)",
            RadioID = "Код музыки (Audio ID)",
            RadioPlay = "Воспроизведение музыки",
            RadioVol = "Громкость музыки",
            LangLabel = "Выбор языка",
            ThemeLabel = "Выбор темы",
            ApplyBtn = "Применить изменения (Перезапуск UI)"
        },
        UA = {
            WindowTitle = "Montano Hub",
            Loading = "Завантаження Montano Hub...",
            TabCombat = "Бій",
            TabVisuals = "Візуал",
            TabMovement = "Рух",
            TabTroll = "Тролінг",
            TabRadio = "Радіо",
            TabSettings = "Налаштування",
            ToggleAimbot = "Увімкнути Аімбот",
            WallCheck = "Перевірка стін (Ігнорувати за стіною)",
            ModeLabel = "Режим роботи",
            ModeAimbot = "Аімбот",
            ModeSilent = "Сайлент Аім (Тимчасово не працює)",
            TargetPart = "Частина тіла для прицілу",
            AimType = "Тип наведення",
            AimSmooth = "Плавний",
            AimSnap = "Різкий (Моментальний)",
            Smoothness = "Плавність наведення",
            FOVSize = "Розмір кола FOV",
            ShowFOVToggle = "Відображати коло FOV",
            FOVColorLabel = "Колір кола FOV",
            Wallhack = "Валхак (Підсвічування крізь стіни)",
            SpeedToggle = "Увімкнути Speedhack",
            SpeedSlider = "Швидкість бігу",
            JumpToggle = "Увімкнути високий стрибок",
            JumpSlider = "Сила стрибка",
            InfJumpToggle = "Нескінченний стрибок",
            NoclipToggle = "Прохід крізь стіни (Noclip)",
            TrollSelect = "Вибрати гравця для тролінгу",
            TrollToggle = "Флінг (З поверненням на місце)",
            RadioID = "Код музики (Audio ID)",
            RadioPlay = "Відтворення музики",
            RadioVol = "Гучність музики",
            LangLabel = "Вибір мови",
            ThemeLabel = "Вибір теми",
            ApplyBtn = "Застосувати зміни (Перезапуск UI)"
        },
        EN = {
            WindowTitle = "Montano Hub",
            Loading = "Loading Montano Hub...",
            TabCombat = "Combat",
            TabVisuals = "Visuals",
            TabMovement = "Movement",
            TabTroll = "Trolling",
            TabRadio = "Radio",
            TabSettings = "Settings",
            ToggleAimbot = "Enable Aimbot",
            WallCheck = "Wall Check (Ignore behind wall)",
            ModeLabel = "Mode",
            ModeAimbot = "Aimbot",
            ModeSilent = "Silent Aim (Temporarily broken)",
            TargetPart = "Target Bone",
            AimType = "Aim Type",
            AimSmooth = "Smooth",
            AimSnap = "Snap",
            Smoothness = "Aim Smoothness",
            FOVSize = "FOV Circle Size",
            ShowFOVToggle = "Show FOV Circle",
            FOVColorLabel = "FOV Circle Color",
            Wallhack = "Wallhack (Chams)",
            SpeedToggle = "Enable Speedhack",
            SpeedSlider = "Walk Speed",
            JumpToggle = "Enable High Jump",
            JumpSlider = "Jump Power",
            InfJumpToggle = "Infinite Jump",
            NoclipToggle = "Noclip (Through Walls)",
            TrollSelect = "Select Player to Troll",
            TrollToggle = "Fling (With return position)",
            RadioID = "Music ID (Audio ID)",
            RadioPlay = "Play Music",
            RadioVol = "Music Volume",
            LangLabel = "Language Selection",
            ThemeLabel = "Theme Selection",
            ApplyBtn = "Apply Changes (Reload UI)"
        }
    }

    local T = Locales[Settings.CurrentLang]

    local Window = Rayfield:CreateWindow({
       Name = T.WindowTitle,
       LoadingTitle = T.Loading,
       ConfigurationSaving = { Enabled = false },
       KeySystem = false,
       Theme = Settings.CurrentTheme
    })

    local RadioSound = SoundService:FindFirstChild("MontanoRadio") or Instance.new("Sound")
    RadioSound.Name = "MontanoRadio"
    RadioSound.Volume = 1
    RadioSound.Looped = true
    RadioSound.Parent = SoundService

    local FOVCircle = _G.MontanoFOV or Drawing.new("Circle")
    _G.MontanoFOV = FOVCircle
    FOVCircle.Thickness = 1.5
    FOVCircle.Color = Settings.FOVColor
    FOVCircle.Filled = false
    FOVCircle.Transparency = 0.7
    FOVCircle.NumSides = 32

    local CombatTab = Window:CreateTab(T.TabCombat, 4483362458)
    CombatTab:CreateToggle({Name = T.ToggleAimbot, CurrentValue = Settings.AimbotEnabled, Callback = function(Value) Settings.AimbotEnabled = Value end})
    CombatTab:CreateToggle({Name = T.WallCheck, CurrentValue = Settings.WallCheck, Callback = function(Value) Settings.WallCheck = Value end})

    CombatTab:CreateDropdown({Name = T.ModeLabel, Options = {T.ModeAimbot, T.ModeSilent}, CurrentOption = {T.ModeAimbot}, Callback = function(Option)
        if Option[1]:find("Сайлент") or Option[1]:find("Silent") then Settings.AimMode = "Сайлент Аим" else Settings.AimMode = "Аимбот" end
    end})
    CombatTab:CreateDropdown({Name = T.TargetPart, Options = {"Голова", "Торс (Грудь)", "Левая нога", "Правая нога"}, CurrentOption = {"Голова"}, Callback = function(Option)
        local selected = Option[1]
        if selected == "Голова" then Settings.TargetPart = "Head"
        elseif selected == "Торс (Грудь)" then Settings.TargetPart = "HumanoidRootPart"
        elseif selected == "Левая нога" then Settings.TargetPart = "Left Leg"
        elseif selected == "Правая нога" then Settings.TargetPart = "Right Leg" end
    end})
    CombatTab:CreateDropdown({Name = T.AimType, Options = {T.AimSmooth, T.AimSnap}, CurrentOption = {Settings.AimType == "Snap" and T.AimSnap or T.AimSmooth}, Callback = function(Option)
        if Option[1]:find("Резкий") or Option[1]:find("Snap") or Option[1]:find("Різкий") then Settings.AimType = "Snap" else Settings.AimType = "Smooth" end
    end})
    CombatTab:CreateSlider({Name = T.Smoothness, Range = {1, 20}, Increment = 1, Suffix = " шаг", CurrentValue = Settings.Smoothness, Callback = function(Value) Settings.Smoothness = Value end})
    CombatTab:CreateSlider({Name = T.FOVSize, Range = {50, 400}, Increment = 10, Suffix = " px", CurrentValue = Settings.FOV, Callback = function(Value) Settings.FOV = Value; FOVCircle.Radius = Value end})

    local VisualsTab = Window:CreateTab(T.TabVisuals, 4483362458)
    VisualsTab:CreateToggle({Name = T.Wallhack, CurrentValue = Settings.Wallhack, Callback = function(Value) Settings.Wallhack = Value end})
    VisualsTab:CreateToggle({Name = T.ShowFOVToggle, CurrentValue = Settings.ShowFOV, Callback = function(Value) Settings.ShowFOV = Value end})
    VisualsTab:CreateDropdown({Name = T.FOVColorLabel, Options = {"Белый", "Красный", "Зеленый", "Голубой", "Желтый"}, CurrentOption = {"Белый"}, Callback = function(Option)
        local c = Option[1]
        if c == "Красный" then Settings.FOVColor = Color3.fromRGB(255, 0, 0)
        elseif c == "Зеленый" then Settings.FOVColor = Color3.fromRGB(0, 255, 0)
        elseif c == "Голубой" then Settings.FOVColor = Color3.fromRGB(0, 200, 255)
        elseif c == "Желтый" then Settings.FOVColor = Color3.fromRGB(255, 255, 0)
        else Settings.FOVColor = Color3.fromRGB(255, 255, 255) end
        FOVCircle.Color = Settings.FOVColor
    end})

    local MovementTab = Window:CreateTab(T.TabMovement, 4483362458)
    MovementTab:CreateToggle({Name = T.SpeedToggle, CurrentValue = Settings.SpeedHackEnabled, Callback = function(Value) Settings.SpeedHackEnabled = Value end})
    MovementTab:CreateSlider({Name = T.SpeedSlider, Range = {16, 200}, Increment = 2, Suffix = " speed", CurrentValue = Settings.WalkSpeed, Callback = function(Value) Settings.WalkSpeed = Value end})
    MovementTab:CreateToggle({Name = T.JumpToggle, CurrentValue = Settings.JumpHackEnabled, Callback = function(Value) Settings.JumpHackEnabled = Value end})
    MovementTab:CreateSlider({Name = T.JumpSlider, Range = {50, 300}, Increment = 5, Suffix = " power", CurrentValue = Settings.JumpPower, Callback = function(Value) Settings.JumpPower = Value end})
    MovementTab:CreateToggle({Name = T.InfJumpToggle, CurrentValue = Settings.InfJump, Callback = function(Value) Settings.InfJump = Value end})
    MovementTab:CreateToggle({Name = T.NoclipToggle, CurrentValue = Settings.Noclip, Callback = function(Value) Settings.Noclip = Value end})

    local MusicTab = Window:CreateTab(T.TabRadio, 4483362458)
    MusicTab:CreateInput({Name = T.RadioID, PlaceholderText = "Введите ID трека...", RemoveTextAfterFocusLost = false, Callback = function(Text)
        local MusicID = tonumber(Text)
        if MusicID then RadioSound.SoundId = "rbxassetid://" .. tostring(MusicID); RadioSound:Play() end
    end})
    MusicTab:CreateToggle({Name = T.RadioPlay, CurrentValue = RadioSound.IsPlaying, Callback = function(Value)
        if Value then RadioSound:Resume() else RadioSound:Pause() end
    end})
    MusicTab:CreateSlider({Name = T.RadioVol, Range = {0, 10}, Increment = 1, Suffix = "", CurrentValue = math.floor(RadioSound.Volume * 5), Callback = function(Value) RadioSound.Volume = Value / 5 end})

    local SettingsTab = Window:CreateTab(T.TabSettings, 4483362458)
    SettingsTab:CreateDropdown({Name = T.LangLabel, Options = {"Русский", "Українська", "English"}, CurrentOption = {Settings.CurrentLang == "UA" and "Українська" or (Settings.CurrentLang == "EN" and "English" or "Русский")}, Callback = function(Option)
        if Option[1] == "Українська" then Settings.CurrentLang = "UA" elseif Option[1] == "English" then Settings.CurrentLang = "EN" else Settings.CurrentLang = "RU" end
    end})
    SettingsTab:CreateDropdown({Name = T.ThemeLabel, Options = {"Темная (Default)", "Светлая (Light)", "Серая (Serenity)", "Синяя (DarkBlue)", "Фиолетовая (Amethyst)"}, CurrentOption = {"Темная (Default)"}, Callback = function(Option)
        local themeName = Option[1]
        if themeName:find("Светлая") or themeName:find("Light") then Settings.CurrentTheme = "Light"
        elseif themeName:find("Серая") or themeName:find("Serenity") then Settings.CurrentTheme = "Serenity"
        elseif themeName:find("Синяя") or themeName:find("DarkBlue") then Settings.CurrentTheme = "DarkBlue"
        elseif themeName:find("Фиолетовая") or themeName:find("Amethyst") then Settings.CurrentTheme = "Amethyst"
        else Settings.CurrentTheme = "Default" end
    end})
    SettingsTab:CreateButton({Name = T.ApplyBtn, Callback = function()
        Rayfield:Destroy()
    end})

    UserInputService.JumpRequest:Connect(function()
        if Settings.InfJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
    end)

    local VirtualUser = game:GetService("VirtualUser")
    LocalPlayer.Idled:Connect(function()
        if Settings.AntiAFK then
            VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end
    end)

    local function IsVisible(part)
        if not Settings.WallCheck then return true end
        local parts = Camera:GetPartsObscuringTarget({part.Position}, {LocalPlayer.Character, part.Parent})
        return #parts == 0
    end

    local function GetClosestTarget()
        local Closest = nil
        local MaxDist = Settings.FOV
        local ScreenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                local Part = v.Character:FindFirstChild(Settings.TargetPart) or v.Character:FindFirstChild("HumanoidRootPart")
                if Part then
                    local ScreenPos, OnScreen = Camera:WorldToViewportPoint(Part.Position)
                    if OnScreen and IsVisible(Part) then
                        local Dist = (Vector2.new(ScreenPos.X, ScreenPos.Y) - ScreenCenter).Magnitude
                        if Dist < MaxDist then MaxDist = Dist; Closest = Part end
                    end
                end
            end
        end
        return Closest
    end

    if _G.MontanoConnection then _G.MontanoConnection:Disconnect() end

    _G.MontanoConnection = RunService.RenderStepped:Connect(function()
        FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        FOVCircle.Visible = Settings.AimbotEnabled and Settings.ShowFOV

        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if Settings.SpeedHackEnabled then hum.WalkSpeed = Settings.WalkSpeed end
            if Settings.JumpHackEnabled then hum.UseJumpPower = true; hum.JumpPower = Settings.JumpPower end
        end

        if Settings.Noclip then
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end

        if Settings.AimbotEnabled and Settings.AimMode == "Аимбот" then
            local Target = GetClosestTarget()
            if Target then
                local TargetCFrame = CFrame.new(Camera.CFrame.Position, Target.Position)
                if Settings.AimType == "Snap" then Camera.CFrame = TargetCFrame else Camera.CFrame = Camera.CFrame:Lerp(TargetCFrame, 1 / Settings.Smoothness) end
            end
        end

        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character then
                local Highlight = v.Character:FindFirstChild("HubHighlight")
                if Settings.Wallhack then
                    if not Highlight then
                        Highlight = Instance.new("Highlight")
                        Highlight.Name = "HubHighlight"
                        Highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        Highlight.FillTransparency = 0.5
                        Highlight.OutlineTransparency = 0
                        Highlight.Parent = v.Character
                    end
                else
                    if Highlight then Highlight:Destroy() end
                end
            end
        end
    end)
end

ConfirmBtn.MouseButton1Click:Connect(function()
    LoadHub()
end)
