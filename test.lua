package.path = "/?/init.lua;/?.lua;" .. package.path
GUIAPI = require("GUIAPI")

GUIAPI.Button:new(5, 5, 7, 3, function ()
end, "Hello!")

GUIAPI.execute()