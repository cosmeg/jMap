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
local function toggle(tracking)
  local index = TRACKING[tracking]
  local name, _, active, _ = GetTrackingInfo(index)
  SetTracking(index, not active)
  print(name .. " " .. tostring(not active))
end

SLASH_JMAP_JT1 = "/jt"
function SlashCmdList.JMAP_JT(msg, editbox)
  if msg == "pet" or msg == "pets" then
    toggle("Track Pets")
  elseif msg == "mail" or msg == "mailbox" then
    toggle("Mailbox")
  elseif msg == "repair" then
    toggle("Repair")
  elseif msg == "inn" then
    toggle("Innkeeper")
  elseif msg == "target" or msg == "tar" then
    toggle("Target")
  elseif msg == "bank" then
    toggle("Banker")
  elseif msg == "stable" then
    toggle("Stable Master")
  end
end


-- move and style lfg and pvp icon (now merged)
local function styleLfgButton(...)
  QueueStatusMinimapButtonBorder:Hide()
  QueueStatusFrame:SetClampedToScreen(true)
  QueueStatusMinimapButton:ClearAllPoints()
  QueueStatusMinimapButton:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMLEFT", -5, -5)
  -- legion bug - tooltip is behind bars, because it is constrained to the
  -- strata of the parent
  QueueStatusFrame:SetParent(nil)
  QueueStatusFrame:SetFrameStrata("TOOLTIP")
end
hooksecurefunc("QueueStatusMinimapButton_OnShow", styleLfgButton)
styleLfgButton()


-- same for mail icon
-- TODO better icon available? w/o black background
MiniMapMailBorder:Hide()
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 10, 8)
MiniMapMailIcon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
MiniMapMailIcon:SetBlendMode("ADD")


-- can't check mail on a starter account
if IsRestrictedAccount() then
  MiniMapMailFrame:Hide()
end


-- this doesn't get moved properly by squeenix and will block buff tooltips
MinimapCluster:EnableMouse(false)


-- we don't move MinimapCluster because other things may be anchored from it
Minimap:ClearAllPoints()
Minimap:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -5, 5)
Minimap:SetScale(1.225)

-- make square
Minimap:SetMaskTexture("Interface\\Buttons\\WHITE8X8")

GameTimeFrame:Hide()
TimeManagerClockButton:Hide()
MinimapBackdrop:Hide()
MinimapBorderTop:Hide()
MinimapZoneText:Hide()

-- support scrolling for zoom
local f = CreateFrame("Frame", nil, Minimap)
f:SetFrameStrata("LOW")
f:EnableMouse(false)
f:SetPoint("TOPLEFT", Minimap, "TOPLEFT")
f:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT")
f:EnableMouseWheel(true)
f:SetScript("OnMouseWheel", function(frame, delta)
  if delta > 0 then
    MinimapZoomIn:Click()
  elseif delta < 0 then
    MinimapZoomOut:Click()
  end
end)


-- fade quest markers on world map
hooksecurefunc(QuestPinMixin, "OnLoad", function(self)
  self:SetAlpha(0.7)
end)
