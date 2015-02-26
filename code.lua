-- hide 'N' on the minimap
MinimapNorthTag:Hide()


-- hide the minimap blob ring (so that's what it's called!)
Minimap:SetArchBlobRingScalar(0)
Minimap:SetQuestBlobRingScalar(0)


-- slash commands to toggle various tracking
-- jt = j track
local TRACKING  = { }
for index = 1, GetNumTrackingTypes() do
  local name, _ = GetTrackingInfo(index)
  TRACKING[name] = index
  --print(index.." "..name)
end
SLASH_JTEST_JT1 = "/jt"
-- TODO DRY
function SlashCmdList.JTEST_JT(msg, editbox)
  if msg == "pet" or msg == "pets" then
    -- battle pets
    local index = TRACKING["Track Pets"]
    local name, _, active, _ = GetTrackingInfo(index)
    SetTracking(index, not active)
    print(name .. " " .. tostring(not active))

  elseif msg == "mail" or msg == "mailbox" then
    local index = TRACKING["Mailbox"]
    local name, _, active, _ = GetTrackingInfo(index)
    SetTracking(index, not active)
    print(name .. " " .. tostring(not active))

  elseif msg == "repair" then
    local index = TRACKING["Repair"]
    local name, _, active, _ = GetTrackingInfo(index)
    SetTracking(index, not active)
    print(name .. " " .. tostring(not active))

  elseif msg == "inn" then
    local index = TRACKING["Innkeeper"]
    local name, _, active, _ = GetTrackingInfo(index)
    SetTracking(index, not active)
    print(name .. " " .. tostring(not active))

  elseif msg == "target" then
    local index = TRACKING["Target"]
    local name, _, active, _ = GetTrackingInfo(index)
    SetTracking(index, not active)
    print(name .. " " .. tostring(not active))

  elseif msg == "bank" then
    local index = TRACKING["Banker"]
    local name, _, active, _ = GetTrackingInfo(index)
    SetTracking(index, not active)
    print(name .. " " .. tostring(not active))
  end
end


-- move and style lfg and pvp icon (now merged)
local function styleLfgButton(...)
  QueueStatusMinimapButtonBorder:Hide()
  QueueStatusFrame:SetClampedToScreen(true)
  QueueStatusMinimapButton:ClearAllPoints()
  QueueStatusMinimapButton:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMLEFT", -5, -5)
end
hooksecurefunc("QueueStatusMinimapButton_OnShow", styleLfgButton)
styleLfgButton()


-- same for mail icon
-- TODO better icon available? w/o black background
MiniMapMailBorder:Hide()
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 10, 8)
MiniMapMailIcon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
