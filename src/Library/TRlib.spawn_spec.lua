require "environment_setup"

local type = require "eaw-abstraction-layer.type"
local finders = require "eaw-abstraction-layer.finders"
local faction = require "eaw-abstraction-layer.faction"
local game_object = require "eaw-abstraction-layer.game_object"
local spawn = require "eaw-abstraction-layer.spawn"
local utilities = require "eaw-abstraction-layer.utility_functions"
local env = require "eaw-abstraction-layer.environment"

context("TRlib.spawn test suite", function()

    context("When receiving valid simple table", function()
        test("should call Spawn_Unit with correct type, location and owner", function()
            local spawn_unit_spy = spy.on(spawn, "Spawn_Unit")

            env.run(function()
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

            assert.spy(spawn_unit_spy).was_called_with(
                match.eaw_type(expected_type),
                match.game_object {
                    name = "Test_Location"
                },
                match.faction("Test_Faction")
            )
        end)
    end)

end)