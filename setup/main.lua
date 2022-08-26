fs.delete("tmp/GUIAPI")
print("Packaging directories...")

fs.delete("GUIAPI_programs")
fs.makeDir("GUIAPI_programs")

fs.move("GUIAPI_programs/test.lua", "GUIAPI_programs/test.lua")

fs.delete("GUIAPI/setup")
fs.move("GUIAPI/GUIAPI", "tmp/GUIAPI")
fs.delete("GUIAPI")
fs.move("tmp/GUIAPI", "GUIAPI")
fs.delete("tmp/GUIAPI")

print("Finished installing GUIAPI")