local lfs = require"lfs"

local nargs = #arg

if nargs < 1 then
    print("Expected folder")
    os.exit(1)
end

require "src/environment_setup"

local current_dir = arg[1]

local test_suites = {}

local function ends_with(str, ending)
    return ending == "" or str:sub(-#ending) == ending
end

local function get_tests (path)
    for file in lfs.dir(path) do
        if file ~= "." and file ~= ".." then
            local f = path
            if not ends_with(path, "/") then
                f = f..'/'..file
            else
                f = f..file
            end
            local attr = lfs.attributes (f)
            assert (type(attr) == "table")
            if attr.mode == "directory" then
                get_tests (f)
            elseif ends_with(file, "_spec.lua") then
                local script = string.gsub(f, ".lua", "")
                print(script)
                table.insert(test_suites, script)
            end
        end
    end
end

get_tests (arg[1])

arg[1] = nil

test = require "u-test"

for _, script in pairs(test_suites) do
    require(script)
end

test.summary()