local function matches_eaw_type(expected, actual)
    if type(expected) == "table" and expected.Get_Name then
        return expected.Get_Name() == actual.Get_Name()
    end

    return string.upper(expected) == actual.Get_Name()
end

local function matches_faction(expected, actual)
    if type(expected) == "table" and expected.Get_Faction_Name then
        return expected.Get_Faction_Name() == actual.Get_Faction_Name()
    end

    return string.upper(expected) == actual.Get_Faction_Name()
end

local function matches_game_object(expected, actual)
    local matches = true
    if expected.Get_Type then
        local expected_eaw_type = expected.Get_Type()
        local expected_owner = expected.Get_Owner()

        matches = matches and matches_eaw_type(expected_eaw_type, actual.Get_Type())
        matches = matches and matches_faction(expected_owner, actual.Get_Owner())
        return matches
    end

    if expected.name then
        matches = matches and matches_eaw_type(expected.name, actual.Get_Type())
    end

    if expected.owner then
        matches = matches and matches_faction(expected.owner, actual.Get_Owner())
    end

    return matches
end

return {
    matches_eaw_type = matches_eaw_type,
    matches_faction = matches_faction,
    matches_game_object = matches_game_object
}