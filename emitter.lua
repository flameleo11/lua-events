local push = table.insert
local pfx_once = '_once_'
local Emitter = {}

setmetatable(Emitter, {
  __call = function (_) 
    return Emitter:new() 
  end
})

local meta_obj = {
  __index = Emitter
}

function Emitter:new()
  local obj = {}
  setmetatable(obj, meta_obj)
  obj:init()
  return obj
end

function Emitter:init()
  self._event_fn = {}
end

-- there is no need to add same
-- listener twice for same event
function Emitter:addListener(event, fn)
  self._event_fn[event] = self._event_fn[event] or {}
  self._event_fn[event][fn] = true
end

function Emitter:enable(event, fn, enable)
  if (  self._event_fn[event] 
    and self._event_fn[event][fn] ~= nil) then
    self._event_fn[event][fn] = enable 
  end
end

function Emitter:_once_name(event)
  return pfx_once..event;
end

function Emitter:once(event, fn)
  self:addListener(self:_once_name(event), fn)
end

function Emitter:_dispatch(event, ...)
  local fn_dict = self._event_fn[event];
  if not (fn_dict) then
    return 
  end

  -- one of fns throw error 
  -- do not stop other emit
  local params = {...}
  for fn, enable in pairs(fn_dict) do
    if (enable) then
      xpcall(function ()
        fn(unpack(params))
      end, print)
    end
  end
end

function Emitter:emit(event, ...)
  self:_dispatch(event, ...)

  local once_event = self:_once_name(event)
  self:_dispatch(once_event, ...)
  self._event_fn[once_event] = nil;
end

function Emitter:removeAllListeners(event)
  self._event_fn[event] = nil
  self._event_fn[self:_once_name(event)] = nil
end

function Emitter:_clear(event, fn)
  if (fn and self._event_fn[event]) then
    self._event_fn[event][fn] = nil 
  end
end

function Emitter:removeListener(event, fn)
  self:_clear(event, fn)
  self:_clear(self:_once_name(event), fn)
end

Emitter.on = Emitter.addListener
Emitter.off = Emitter.removeListener

return Emitter
