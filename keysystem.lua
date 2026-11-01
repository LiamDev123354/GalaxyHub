local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

local CONFIG = {
    Key = "GH#1",
    SaveKey = true,
    KeyFile = "GalaxyHub/key.txt",

    
    GetKeyURL = "https://discord.gg/s7mWBDQYP",

    SupportedGames = {
        [10449761463] = "https://raw.githubusercontent.com/LiamDev123354/GalaxyHub/refs/heads/main/TheStrongestBattleGrounds.lua",
        
    }
}

local THEME = {
    Background = Color3.fromRGB(13, 13, 17),
    Sidebar = Color3.fromRGB(23, 17, 23),
    Surface = Color3.fromRGB(25, 24, 30),
    SurfaceHover = Color3.fromRGB(38, 34, 41),

    Red = Color3.fromRGB(225, 35, 65),
    RedDark = Color3.fromRGB(120, 20, 42),

    White = Color3.fromRGB(245, 243, 245),
    Gray = Color3.fromRGB(140, 135, 145),

    Green = Color3.fromRGB(105, 215, 145),
    Orange = Color3.fromRGB(255, 180, 100),
    Error = Color3.fromRGB(255, 95, 110)
}

local function CreateInstance(className, properties, parent)
    local instance = Instance.new(className)

    for property, value in pairs(properties) do
        instance[property] = value
    end

    instance.Parent = parent

    return instance
end

local function AddCorner(instance, radius)
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, radius)
    }, instance)
end

local function AddStroke(instance, color, thickness, transparency)
    return CreateInstance("UIStroke", {
        Color = color,
        Thickness = thickness,
        Transparency = transparency or 0
    }, instance)
end

local function Tween(instance, duration, properties)
    TweenService:Create(
        instance,
        TweenInfo.new(
            duration,
            Enum.EasingStyle.Quart,
            Enum.EasingDirection.Out
        ),
        properties
    ):Play()
end

local function GetGuiParent()
    if type(gethui) == "function" then
        local success, result = pcall(gethui)

        if success and result then
            return result
        end
    end

    return CoreGui
end

local GuiParent = GetGuiParent()

local ExistingGui = GuiParent:FindFirstChild("GalaxyHub")
if ExistingGui then
    ExistingGui:Destroy()
end

local ScreenGui = CreateInstance("ScreenGui", {
    Name = "GalaxyHub",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, GuiParent)

local UiScale = CreateInstance("UIScale", {
    Scale = 1
}, ScreenGui)

local Camera = workspace.CurrentCamera

local function UpdateUiScale()
    local screenWidth = Camera and Camera.ViewportSize.X or 900
    UiScale.Scale = math.clamp(screenWidth / 920, 0.68, 1)
end

UpdateUiScale()

if Camera then
    Camera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateUiScale)
end

local Shadow = CreateInstance("Frame", {
    Name = "WindowShadow",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(510, 326),
    BackgroundColor3 = Color3.new(0, 0, 0),
    BackgroundTransparency = 0.3,
    BorderSizePixel = 0,
    ZIndex = 0
}, ScreenGui)

AddCorner(Shadow, 24)

local MainWindow = CreateInstance("Frame", {
    Name = "MainWindow",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(490, 306),
    BackgroundColor3 = THEME.Background,
    BorderSizePixel = 0,
    ZIndex = 2
}, ScreenGui)

AddCorner(MainWindow, 21)
AddStroke(MainWindow, Color3.fromRGB(65, 43, 52), 1, 0.1)



local BrandingPanel = CreateInstance("Frame", {
    Name = "BrandingPanel",
    Size = UDim2.new(0, 155, 1, 0),
    BackgroundColor3 = THEME.Sidebar,
    BorderSizePixel = 0,
    ZIndex = 3
}, MainWindow)

AddCorner(BrandingPanel, 21)

CreateInstance("Frame", {
    Position = UDim2.new(1, -18, 0, 0),
    Size = UDim2.new(0, 18, 1, 0),
    BackgroundColor3 = THEME.Sidebar,
    BorderSizePixel = 0,
    ZIndex = 3
}, BrandingPanel)

local BrandingAccent = CreateInstance("Frame", {
    Position = UDim2.fromOffset(0, 25),
    Size = UDim2.fromOffset(3, 245),
    BackgroundColor3 = THEME.Red,
    BorderSizePixel = 0,
    ZIndex = 4
}, BrandingPanel)

AddCorner(BrandingAccent, 3)

local LogoContainer = CreateInstance("Frame", {
    Position = UDim2.fromOffset(27, 29),
    Size = UDim2.fromOffset(82, 82),
    BackgroundColor3 = Color3.fromRGB(43, 19, 28),
    BorderSizePixel = 0,
    ZIndex = 4
}, BrandingPanel)

AddCorner(LogoContainer, 23)
AddStroke(LogoContainer, THEME.RedDark, 1.2, 0.1)

local HubLogo = CreateInstance("ImageLabel", {
    Name = "HubLogo",
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(5, 5),
    Size = UDim2.new(1, -10, 1, -10),
    Image = CONFIG.LogoImage,
    ScaleType = Enum.ScaleType.Fit,
    ZIndex = 5
}, LogoContainer)

AddCorner(HubLogo, 18)

CreateInstance("TextLabel", {
    Position = UDim2.fromOffset(25, 130),
    Size = UDim2.fromOffset(115, 25),
    BackgroundTransparency = 1,
    Text = "Galaxy Hub",
    TextColor3 = THEME.White,
    TextSize = 14,
    Font = Enum.Font.GothamBlack,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 4
}, BrandingPanel)

CreateInstance("TextLabel", {
    Position = UDim2.fromOffset(26, 154),
    Size = UDim2.fromOffset(110, 18),
    BackgroundTransparency = 1,
    Text = "HUB  /  CLIENT",
    TextColor3 = THEME.Gray,
    TextSize = 8,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 4
}, BrandingPanel)

local BrandingDivider = CreateInstance("Frame", {
    Position = UDim2.fromOffset(26, 190),
    Size = UDim2.fromOffset(45, 2),
    BackgroundColor3 = THEME.Red,
    BorderSizePixel = 0,
    ZIndex = 4
}, BrandingPanel)

AddCorner(BrandingDivider, 2)

CreateInstance("TextLabel", {
    Position = UDim2.fromOffset(26, 207),
    Size = UDim2.fromOffset(112, 35),
    BackgroundTransparency = 1,
    Text = "key system  •  V2",
    TextColor3 = Color3.fromRGB(120, 110, 120),
    TextSize = 8,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    ZIndex = 4
}, BrandingPanel)



local ContentPanel = CreateInstance("Frame", {
    Name = "ContentPanel",
    Position = UDim2.fromOffset(177, 0),
    Size = UDim2.new(1, -177, 1, 0),
    BackgroundTransparency = 1,
    ZIndex = 3
}, MainWindow)

local CloseButton = CreateInstance("TextButton", {
    Position = UDim2.new(1, -43, 0, 19),
    Size = UDim2.fromOffset(25, 25),
    BackgroundColor3 = THEME.Surface,
    Text = "×",
    TextColor3 = THEME.Gray,
    TextSize = 19,
    Font = Enum.Font.GothamMedium,
    AutoButtonColor = false,
    ZIndex = 5
}, ContentPanel)

AddCorner(CloseButton, 8)

CreateInstance("TextLabel", {
    Position = UDim2.fromOffset(0, 29),
    Size = UDim2.new(1, -45, 0, 25),
    BackgroundTransparency = 1,
    Text = "Unlock your hub",
    TextColor3 = THEME.White,
    TextSize = 17,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 4
}, ContentPanel)

CreateInstance("TextLabel", {
    Position = UDim2.fromOffset(1, 56),
    Size = UDim2.new(1, -20, 0, 17),
    BackgroundTransparency = 1,
    Text = "Enter your access key to continue.",
    TextColor3 = THEME.Gray,
    TextSize = 9,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 4
}, ContentPanel)

CreateInstance("TextLabel", {
    Position = UDim2.fromOffset(1, 91),
    Size = UDim2.new(1, -20, 0, 15),
    BackgroundTransparency = 1,
    Text = "LICENSE KEY",
    TextColor3 = Color3.fromRGB(195, 187, 195),
    TextSize = 8,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 4
}, ContentPanel)

local KeyInputFrame = CreateInstance("Frame", {
    Position = UDim2.fromOffset(0, 112),
    Size = UDim2.new(1, -20, 0, 43),
    BackgroundColor3 = THEME.Surface,
    BorderSizePixel = 0,
    ZIndex = 4
}, ContentPanel)

AddCorner(KeyInputFrame, 10)
AddStroke(KeyInputFrame, THEME.RedDark, 1, 0.65)

local KeyInput = CreateInstance("TextBox", {
    Position = UDim2.fromOffset(13, 0),
    Size = UDim2.new(1, -25, 1, 0),
    BackgroundTransparency = 1,
    Text = "",
    PlaceholderText = "Paste your key here...",
    PlaceholderColor3 = Color3.fromRGB(105, 100, 109),
    TextColor3 = THEME.White,
    TextSize = 11,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    ClearTextOnFocus = false,
    ZIndex = 5
}, KeyInputFrame)

local StatusLabel = CreateInstance("TextLabel", {
    Position = UDim2.fromOffset(1, 164),
    Size = UDim2.new(1, -20, 0, 14),
    BackgroundTransparency = 1,
    Text = "●  READY FOR AUTHENTICATION",
    TextColor3 = THEME.Gray,
    TextSize = 8,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 4
}, ContentPanel)



local ButtonContainer = CreateInstance("Frame", {
    Position = UDim2.fromOffset(0, 194),
    Size = UDim2.new(1, -20, 0, 38),
    BackgroundTransparency = 1,
    ZIndex = 4
}, ContentPanel)

local GetKeyButton = CreateInstance("TextButton", {
    Position = UDim2.fromOffset(0, 0),
    Size = UDim2.new(0.43, -5, 1, 0),
    BackgroundColor3 = THEME.SurfaceHover,
    Text = "GET KEY  ↗",
    TextColor3 = THEME.White,
    TextSize = 9,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = false,
    ZIndex = 5
}, ButtonContainer)

AddCorner(GetKeyButton, 9)
AddStroke(GetKeyButton, THEME.RedDark, 1, 0.65)

local VerifyKeyButton = CreateInstance("TextButton", {
    Position = UDim2.new(0.43, 5, 0, 0),
    Size = UDim2.new(0.57, -5, 1, 0),
    BackgroundColor3 = THEME.Red,
    Text = "VERIFY  →",
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 9,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = false,
    ZIndex = 5
}, ButtonContainer)

AddCorner(VerifyKeyButton, 9)

CreateInstance("UIGradient", {
    Rotation = 0,
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(242, 49, 78)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(174, 24, 52))
    })
}, VerifyKeyButton)

CreateInstance("TextLabel", {
    Position = UDim2.fromOffset(0, 249),
    Size = UDim2.new(1, -20, 0, 12),
    BackgroundTransparency = 1,
    Text = "ENCHANTED HUB  •  SECURE SESSION",
    TextColor3 = Color3.fromRGB(85, 80, 88),
    TextSize = 7,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 4
}, ContentPanel)



local function SetStatus(message, color)
    StatusLabel.Text = "●  " .. message
    StatusLabel.TextColor3 = color
end

local function SaveKey(key)
    if not CONFIG.SaveKey or type(writefile) ~= "function" then
        return
    end

    pcall(function()
        if type(isfolder) == "function"
            and type(makefolder) == "function"
            and not isfolder("EnchantedHub") then

            makefolder("EnchantedHub")
        end

        writefile(CONFIG.KeyFile, key)
    end)
end

local function LoadCurrentGame()
    local scriptUrl = CONFIG.SupportedGames[game.PlaceId]

    if type(scriptUrl) ~= "string" or scriptUrl == "" then
        SetStatus("GAME NOT FOUND IN CONFIG", THEME.Orange)
        return false
    end

    local success = pcall(function()
        local source = game:HttpGet(scriptUrl)
        local gameScript = loadstring(source)

        if not gameScript then
            error("Invalid game script")
        end

        gameScript()
    end)

    if not success then
        SetStatus("GAME SCRIPT FAILED TO LOAD", THEME.Error)
        return false
    end

    return true
end

local IsVerifying = false

local function VerifyKey()
    if IsVerifying then
        return
    end

    IsVerifying = true
    VerifyKeyButton.Text = "CHECKING..."

    local enteredKey = string.gsub(KeyInput.Text, "^%s*(.-)%s*$", "%1")

    if string.lower(enteredKey) ~= string.lower(CONFIG.Key) then
        SetStatus("INVALID KEY  •  ACCESS DENIED", THEME.Error)

        Tween(KeyInputFrame, 0.07, {
            Position = UDim2.fromOffset(4, 112)
        })

        task.wait(0.08)

        Tween(KeyInputFrame, 0.09, {
            Position = UDim2.fromOffset(0, 112)
        })

        VerifyKeyButton.Text = "VERIFY  →"
        IsVerifying = false
        return
    end

    SaveKey(enteredKey)

    SetStatus("KEY ACCEPTED  •  LOADING", THEME.Green)
    VerifyKeyButton.Text = "LOADING..."

    if LoadCurrentGame() then
        SetStatus("ACCESS GRANTED", THEME.Green)
        task.wait(0.4)
        ScreenGui:Destroy()
    else
        VerifyKeyButton.Text = "VERIFY  →"
    end

    IsVerifying = false
end



GetKeyButton.Activated:Connect(function()
    if CONFIG.GetKeyURL == ""
        or string.find(CONFIG.GetKeyURL, "DEIN-INVITE", 1, true) then

        SetStatus("ADD YOUR GET KEY LINK IN CONFIG", THEME.Orange)
        return
    end

    if type(setclipboard) == "function" then
        local copied = pcall(setclipboard, CONFIG.GetKeyURL)

        if copied then
            SetStatus("GET KEY LINK COPIED", THEME.Green)
        else
            SetStatus("COULD NOT COPY KEY LINK", THEME.Error)
        end
    else
        SetStatus("COPY YOUR GET KEY LINK FROM CONFIG", THEME.Orange)
    end
end)

VerifyKeyButton.Activated:Connect(VerifyKey)

KeyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        VerifyKey()
    end
end)

CloseButton.Activated:Connect(function()
    Tween(MainWindow, 0.18, {
        Size = UDim2.fromOffset(440, 275),
        BackgroundTransparency = 1
    })

    Tween(Shadow, 0.18, {
        BackgroundTransparency = 1
    })

    task.wait(0.2)
    ScreenGui:Destroy()
end)



local SavedKey

if CONFIG.SaveKey
    and type(isfile) == "function"
    and type(readfile) == "function" then

    pcall(function()
        if isfile(CONFIG.KeyFile) then
            SavedKey = readfile(CONFIG.KeyFile)
        end
    end)
end

if SavedKey and string.lower(SavedKey) == string.lower(CONFIG.Key) then
    KeyInput.Text = SavedKey
    task.defer(VerifyKey)
end



local IsDragging = false
local DragStartPosition
local WindowStartPosition

MainWindow.InputBegan:Connect(function(inputObject)
    if inputObject.UserInputType == Enum.UserInputType.MouseButton1
        or inputObject.UserInputType == Enum.UserInputType.Touch then

        local relativeY = inputObject.Position.Y - MainWindow.AbsolutePosition.Y

        if relativeY <= 78 then
            IsDragging = true
            DragStartPosition = inputObject.Position
            WindowStartPosition = MainWindow.Position
        end
    end
end)

UserInputService.InputChanged:Connect(function(inputObject)
    if IsDragging
        and (
            inputObject.UserInputType == Enum.UserInputType.MouseMovement
            or inputObject.UserInputType == Enum.UserInputType.Touch
        ) then

        local delta = inputObject.Position - DragStartPosition

        MainWindow.Position = UDim2.new(
            WindowStartPosition.X.Scale,
            WindowStartPosition.X.Offset + delta.X,
            WindowStartPosition.Y.Scale,
            WindowStartPosition.Y.Offset + delta.Y
        )

        Shadow.Position = MainWindow.Position
    end
end)

UserInputService.InputEnded:Connect(function(inputObject)
    if inputObject.UserInputType == Enum.UserInputType.MouseButton1
        or inputObject.UserInputType == Enum.UserInputType.Touch then

        IsDragging = false
    end
end)



MainWindow.Size = UDim2.fromOffset(0, 0)
Shadow.Size = UDim2.fromOffset(0, 0)

Tween(MainWindow, 0.4, {
    Size = UDim2.fromOffset(490, 306)
})

Tween(Shadow, 0.4, {
    Size = UDim2.fromOffset(510, 326)
})
