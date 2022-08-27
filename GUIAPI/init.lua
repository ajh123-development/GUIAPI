GUIAPI = {}

GUIAPI.Class = require "IPvCC.class"
local running = false
local event
local buttons = {}

function GUIAPI.is_instance(o, class)
    while o do
        o = o.metatable
        if class.metatable == o then return true end
    end
    return false
end

function GUIAPI.tick()
    for index, value in ipairs(buttons) do
        if GUIAPI.is_instance(value, GUIAPI.Button) then
            value:check()
            value:draw()
        end
    end
end

function GUIAPI.stop()
    running = true
end

function GUIAPI.execute()
    running = true
    local w, h = term.getSize()

    local currTerm = term.current()
    term.setCursorPos(1, 1)
    term.setBackgroundColor(colors.black)
    term.clear()
    local window = window.create(currTerm, 1, 1, w, h, false)

    while running do
        GUIAPI.tick()
        event = table.pack(os.pullEvent())
    end

    term.redirect(currTerm)
    window.setVisible(true)
    window.setVisible(false)
end

GUIAPI.Button = GUIAPI.Class:new()
function GUIAPI.Button:__new(x, y, width, height, func, text)
    assert(type(x) == "number", "x is not a number")
    assert(type(y) == "number", "y is not a number")
    assert(type(width) == "number", "width is not a number")
    assert(type(height) == "number", "height is not a number")
    assert(type(func) == "function", "func is not a function")
    assert(type(text) == "string", "text is not a string")
    self.colors = {}
    self.colors.bg = colors.gray
    self.colors.click = colors.blue
    self.colors.text = colors.white
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.isClicked = false
    self.text = text
    buttons[#buttons+1] = self
end

function GUIAPI.Button:draw()
    local bg = self.colors.bg
    if self.isClicked then
        bg = self.colors.click
    end

    paintutils.drawFilledBox(
        self.x,
        self.y,
        self.x+self.width,
        self.y+self.height,
        bg
    )
    local oldColor = term.getTextColor()
    local x = (self.width/2) + self.x - (#self.text/2) + 1
    local y = (self.height/2) + self.y
    term.setCursorPos(x, y)
    term.setTextColor(self.colors.text)
    term.write(self.text)
    term.setTextColor(oldColor)
end

function GUIAPI.Button:check()
    if event ~= nil then
        if #event >= 4 then
            local e, button, x, y = table.unpack(event)
            if e == "mouse_click"  then
                if x > self.x-1 and x < self.x-1 + self.width+2 then
                    if y > self.y-1 and y < self.y-1 + self.height+2 then
                        self.isClicked = true
                    end
                end
            end
            if e == "mouse_up"  then
                if x > self.x-1 and x < self.x-1 + self.width+2 then
                    if y > self.y-1 and y < self.y-1 + self.height+2 then
                        self.isClicked = false
                    end
                end
            end
        end
    end
end


return GUIAPI