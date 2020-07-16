
------------------------------------------------------------
-- normal
------------------------------------------------------------

local em = require('emitter')()

em:on('player', function (inst)
	print("login", inst.prefab)
end)

em:on('world', function (inst)
	print("world seed is ", inst.seed)
end)


em:emit('player', { prefab = "willow" })
em:emit('world', { seed = os.time() })


------------------------------------------------------------
-- reload
------------------------------------------------------------

local em = require('emitter')()

em:off('player', onPlayerLogin)
function onPlayerLogin(inst)
	print("login", inst.prefab)
end
em:on('player', onPlayerLogin)

em:off('world', onWorldInit)
function onWorldInit(inst)
	print("world seed is ", inst.seed)
end
em:on('world', onWorldInit)


em:emit('player', { prefab = "willow" })
em:emit('world', { seed = os.time() })


------------------------------------------------------------
-- test remove
------------------------------------------------------------

local em = require('emitter')()

em:on('A', print)
em:on('a', print)

em:emit('A', 1)
em:emit('a', 2, 21)

em:off('a', print)
em:off('A', print)

em:emit('A', 3, 31, 32)
em:emit('a', 4, 41, 42, 43)

em:on('A', print)

em:emit('A', 5, 51, 52)

------------------------------------------------------------
-- test exception
------------------------------------------------------------

local em = require('emitter')()

em:on('mouse_click', function (x, y)
	error("x="..x)
end)

em:on('mouse_click', function (x, y)
	error("y="..y)
end)

em:emit('mouse_click', 100, 200)

print("running here")


--[[

```lua

```
]]


