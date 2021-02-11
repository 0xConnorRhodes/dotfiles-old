-- cutitout: automatically cut silence from videos
-- Copyright (C) 2020 Wolf Clement

-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU Affero General Public License as published
-- by the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Affero General Public License for more details.

-- You should have received a copy of the GNU Affero General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.


local enabled = false
local skips = {}

-- Whenever time updates, we check if we should skip
mp.observe_property("time-pos", "native", function (_, pos)
    if pos == nil then return end
    if not enabled then return end

    for _, t in pairs(skips) do
        -- t[1] == start time of the skip
        -- t[2] == end time of the skip
        if t[1] <= pos and t[2] > pos then
            mp.set_property("time-pos", t[2])
            return
        end
    end
end)

function reload_skips()
    if not enabled then return end

    local utils = require("mp.utils")
    local scripts_dir = mp.find_config_file("scripts")
    local cutitoutpy = utils.join_path(scripts_dir, "cutitout_shared/cutitout.py")

    -- Reset global skips table
    skips = {}

    local video_path = mp.get_property("path")
    mp.command_native_async({
        name = "subprocess",
        capture_stdout = true,
        playback_only = false,
        args = { "python3", cutitoutpy, video_path }
    }, function(res, val, err)
        -- The string sets the "skips" table
        skips = loadstring(val.stdout)()
        print(tostring(#skips) .. " skips loaded")

        local time_saved = 0.0
        for _, t in pairs(skips) do
            time_saved = time_saved + (t[2] - t[1])
        end
        print("Time saved: " .. tostring(time_saved) .. " seconds")

        mp.osd_message("Silence skipping enabled.")
    end)
end

-- F12 toggles silence skipping (off by default)
mp.add_key_binding("F12", "toggle_silence_skip", function ()
    enabled = not enabled
    if enabled then
        if next(skips) == nil then
            mp.osd_message("Enabling silence skipping...")
            reload_skips()
        else
            mp.osd_message("Silence skipping enabled.")
        end
    else
        mp.osd_message("Silence skipping disabled.")
    end
end)

-- Whenever we load another file, we reload skips
mp.register_event("file-loaded", reload_skips)
