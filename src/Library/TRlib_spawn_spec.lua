local eaw = require "eaw-abstraction-layer"
local types = eaw.types
local env = eaw.environment
local faction = types.faction
local game_object = types.game_object
local type = types.type

local matchers = require "src/matchers"
local matches_eaw_type = matchers.matches_eaw_type
local matches_faction = matchers.matches_faction
local matches_game_object = matchers.matches_game_object


test["TRlib.spawn Test Suite"]["When receiving valid simple table -> should call Spawn_Unit with correct type, location and owner"] = function()
    local actual_type, actual_location, actual_owner

    function env.Spawn_Unit.callback(object_type, location, owner)
        actual_type, actual_location, actual_owner = object_type, location, owner
    end

    eaw.run(function()
        require "TRlib"
        TRlib.init()
        TRlib.spawn {
            objects = {
                ["Test_Type"] = 1
            },
            location = "Test_Location",
            owner = "Test_Faction"
        }
    end)

    local expected_type = "Test_Type"
    local expected_object = { name = "Test_Location" }
    local expected_faction = "Test_Faction"

    test.is_true(matches_eaw_type(expected_type, actual_type))
    test.is_true(matches_game_object(expected_object, actual_location))
    test.is_true(matches_faction(expected_faction, actual_owner))
end
