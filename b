local httpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LP = game.Players.LocalPlayer
local token = 'V3R~1cab9d8f6ece85c2a56408b046a6e5979d7ef0eadcaf284e1610be72cc479ad0a355847d24ceaf313ad78c563cb15abcfada33f8e22fcb331debf1f7c1f01663'

local API_URL = "https://ff-api.glitch.me/api/kick"

local function handleKickCommand()
    for _, player in ipairs(Players:GetPlayers()) do
        LP:Kick("player:Kick()")
    end
end

local function checkForKickCommand()
    local success, response = pcall(function()
        return httpService:PostAsync(API_URL, "", Enum.HttpContentType.ApplicationJson, false, {
            ["token_access"] = token
        })
    end)

    if success then
        local responseData = httpService:JSONDecode(response)
        if responseData.message == "Kick command received" then
            handleKickCommand()
        end
    else
        LP:Kick('Failed to load the script')
    end
end

while true do
    checkForKickCommand()
    wait(1.5)
end
