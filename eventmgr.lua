local em = require('emitter')()

local _emitter_list = {}

setmetatable(eventmgr, {
    __call = function (_) 
        return eventmgr:new() 
    end
})

local meta_obj = {
    __index = eventmgr
}

function eventmgr:new()
    local obj = {}
    setmetatable(obj, meta_obj)
    obj:init()
    return obj
end

function eventmgr:init()
    self._event_fn = {}
end
