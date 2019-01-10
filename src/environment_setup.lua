local eal = require "eaw-abstraction-layer"
local environment = eal.environment

environment.register_busted_matchers()

local mod_path = require "icw_path"
environment.init(mod_path)