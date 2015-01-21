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
function SlashCmdList.JTEST_JT(msg, editbox)
  if msg == "pet" or msg == "pets" then
    -- battle pets
    local index = TRACKING["Track Pets"]
    local name, _, active, _ = GetTrackingInfo(index)
    SetTracking(index, not active)
    print("Track Pets " .. tostring(not active))

  elseif msg == "mail" or msg == "mailbox" then
    local index = TRACKING["Mailbox"]
    local name, _, active, _ = GetTrackingInfo(index)
    SetTracking(index, not active)
    print("Mailbox " .. tostring(not active))
  end
end
