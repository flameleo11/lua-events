local em = require('emitter')()

local Listener = {}

setmetatable(Listener, {
    __call = function (_) 
        return Listener:new() 
    end
})

local meta_obj = {
    __index = Listener
}

function Listener:new()
    local obj = {}
    setmetatable(obj, meta_obj)
    obj:init()
    return obj
end

function Listener:init()
    self._event_fn = {}
end
