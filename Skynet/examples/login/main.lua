local skynet = require "skynet"

skynet.start(function()
	local loginserver = skynet.newservice("logind")
	local gate = skynet.newservice("gated", loginserver) -- 把登陆服的addr传入gated中，gated中 的 ... 就是指这里传进的不定参数

	skynet.call(gate, "lua", "open" , {
		port = 8888,
		maxclient = 64,
		servername = "sample",
	})
end)
