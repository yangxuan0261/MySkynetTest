local skynet    = require "skynet"

local svc   = {}

svc.handler = function(session, address, ...)
    skynet.error("--- slave, ["..skynet.address(address).."]", ...)
end

--初始化
skynet.init(function()
    --方式一，获取全局MASTER服务句柄
    svc.master  = assert(skynet.queryservice(true, "master-service"))
end)

--服务入口
skynet.start(function()
    -- 设置 lua 协议处理函数
	skynet.dispatch("lua", svc.handler)

    --方式一，按句柄发消息
    skynet.send(svc.master, "lua", "SLAVE", skynet.getenv "harbor")

    --方式二，按名字发消息
    --skynet.send("MASTER", "lua", "SLAVE", skynet.getenv "harbor")
end)
