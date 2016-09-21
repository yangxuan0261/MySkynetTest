local skynet = require "skynet"
local redis  = require "redis"

local db

function add1(key, count)
    local t = {}
    local t2 = {}
    for i = 1, count do
        t[2*i -1] = "key" ..i
        t[2*i] = "value" .. i
        table.insert(t2, "value"..i)
    end

    local tmpKey = "testSet"
    -- db:sadd(tmpKey, table.unpack(t2))
    local num = db:srem(tmpKey, "value1", "value3", "value3")
    print("--- num", num)

    local values = db:smembers(tmpKey)
    for k,v in pairs(values) do
        print(k,v)
    end


    -- db:hmset(key, table.unpack(t))
--[[
    -- db:hdel(key, "key23")
    local keys = db:hkeys(key)
    for k,v in pairs(keys) do
        print("--- keys", k,v)
    end

    -- local values = db:hvals(key)
    local values = db:hgetall(key)
    for k,v in pairs(values) do
        print("--- values:", k,v)
    end
]]

--[[
    local b = db:hexists(key, "key1")
    local msg = b and "exist" or "not exist"
    print("--- msg:", msg)
]]

--[[
    local num = db:hlen(key)
    print("--- num:", num)
]]
end



function add2(key, count)
    local t = {}
    for i = 1, count do
        t[2*i -1] = "key" ..i
        t[2*i] = "value" .. i
    end
    table.insert(t, 1, key)
    -- db:hmset(t)
end

function __init__()

    db = redis.connect {
        host = "127.0.0.1",
        port = 6379,
        db   = 0,
<<<<<<< HEAD
        -- auth = "foobared"
    }
    print("dbsize:", db:dbsize())
    local ok, msg = xpcall(add1, debug.traceback, "test1", 25)
=======
        auth = "yangx"
    }
    print("dbsize:", db:dbsize())
    local ok, msg = xpcall(add1, debug.traceback, "test1", 250)
>>>>>>> c38fb7888b84aa960f0f025e6183c58d85397f27
    if not ok then
        print("add1 failed", msg)
    else
        print("add1 succeed")
    end

<<<<<<< HEAD
    local ok, msg = xpcall(add2, debug.traceback, "test2", 25)
=======
    local ok, msg = xpcall(add2, debug.traceback, "test2", 250)
>>>>>>> c38fb7888b84aa960f0f025e6183c58d85397f27
    if not ok then
        print("add2 failed", msg)
    else
        print("add2 succeed")
    end
    print("dbsize:", db:dbsize())

    print("redistest launched")
end

skynet.start(__init__)

