local name, Plugin = ...;

function Plugin:Init()
    local compatible = false;
    if(BlizzMoveAPI and BlizzMoveAPI.GetVersion and BlizzMoveAPI.RegisterAddOnFrames) then
        local _, _, _, _, versionInt = BlizzMoveAPI:GetVersion();
        if (versionInt == nil or versionInt >= 30200) then
            compatible = true;
        end
    end

    if(not compatible) then
        print(name .. ' is not compatible with the current version of BlizzMove, please update.');
        return;
    end

    local frameTable = {
        ['Blizzard_Collections'] =
        {
            ['CollectionsJournal'] =
            {
                MinVersion = 0,
                SubFrames = {},
            },
        },
    };
    for i, journalFrame in ipairs(ManuscriptsJournal:GetAllPanels()) do
        frameTable.Blizzard_Collections.CollectionsJournal.SubFrames['ManuscriptsJournalSubFrame' .. i] = {
            MinVersion = 0,
            FrameReference = journalFrame,
        }
    end
    BlizzMoveAPI:RegisterAddOnFrames(frameTable);
end

Plugin:Init();
