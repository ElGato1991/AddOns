-- Initialize addon
local addonName = "EAAutoUnshift"
local frame = CreateFrame("Frame", addonName .. "Frame")
frame:RegisterEvent("PLAYER_LOGIN")

-- Function to check if the player is a Feral or Guardian Druid
local function IsDruid()
    local _, class = UnitClass("player")
    if class == "DRUID" then
        local specID = GetSpecializationInfo(GetSpecialization())
        return specID == 103 or specID == 104 -- Feral spec ID is 103, Guardian spec ID is 104
    end
    return false
end

-- Event handler to disable autounshift in combat
local function DisableAutoUnshift()
    if IsDruid() then
        SetCVar("autoUnshift", 0) -- Disable autounshift
    end
end

-- Event handler to enable autounshift when leaving combat
local function EnableAutoUnshift()
    if IsDruid() then
        SetCVar("autoUnshift", 1) -- Enable autounshift
    end
end

-- Event handler for PLAYER_LOGIN event
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        -- Check if player is a Feral or Guardian Druid
        if IsDruid() then
            -- Hook combat start and end events
            frame:RegisterEvent("PLAYER_REGEN_DISABLED")
            frame:RegisterEvent("PLAYER_REGEN_ENABLED")
            print("EAAutoUnshift loaded. Use /eaa to check status or toggle.")
        end
    elseif event == "PLAYER_REGEN_DISABLED" then
        -- Player entered combat, disable autounshift
        DisableAutoUnshift()
    elseif event == "PLAYER_REGEN_ENABLED" then
        -- Player left combat, enable autounshift
        EnableAutoUnshift()
    end
end)

-- Slash command handler
SLASH_EAAUTO1 = "/eaa"
SlashCmdList["EAAUTO"] = function(msg)
    if msg == "toggle" then
        if frame:IsEventRegistered("PLAYER_REGEN_DISABLED") then
            frame:UnregisterEvent("PLAYER_REGEN_DISABLED")
            frame:UnregisterEvent("PLAYER_REGEN_ENABLED")
            EnableAutoUnshift() -- Ensure autounshift is enabled when turning off the addon
            print("EAAutoUnshift disabled.")
        else
            frame:RegisterEvent("PLAYER_REGEN_DISABLED")
            frame:RegisterEvent("PLAYER_REGEN_ENABLED")
            print("EAAutoUnshift enabled.")
        end
    elseif msg == "status" then
        if frame:IsEventRegistered("PLAYER_REGEN_DISABLED") then
            print("EAAutoUnshift is currently enabled.")
        else
            print("EAAutoUnshift is currently disabled.")
        end
    else
        print("Usage: /eaa toggle - Enable or disable EAAutoUnshift.")
        print("Usage: /eaa status - Check if EAAutoUnshift is enabled or disabled.")
    end
end
