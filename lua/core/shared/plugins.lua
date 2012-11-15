Plugins = {}
Plugins.Loaded = {}

local depend = {}

function Plugins.LoadPlugins()
	local files = file.Find("plugins/*.lua", "LUA")
	for _, v in pairs(files) do	
		local ext = string.Explode("_", v)[1]
		if ext == "sh" then 
			if SERVER then 
				AddCSLuaFile("plugins/" .. v) 
				include("plugins/" .. v)
			elseif CLIENT then include("plugins/" .. v) end
		elseif ext == "sv" and SERVER then
			include("plugins/" .. v)
		elseif ext == "cl" then
			if SERVER then AddCSLuaFile("plugins/" .. v)
			elseif CLIENT then include("plugins/" .. v) end
		end
	end
	hook.Call("SBPostPluginLoading", nil)
end

function Plugins.Register(plugin)
	if not plugin.Run or not plugin.Stop then
		print("Invalid plugin ".. plugin.name .. "!")
	end
	
	if plugin.dependencies then
		table.insert(depend, plugin)
	else
		Plugins.Loaded[plugin.id] = plugin
		plugin.Run()
		print("Registered plugin " .. plugin.name)
	end
end

local function handleDependencies()
	for i, plugin in ipairs(depend) do
		local pluginIds = string.Explode(",", plugin.dependencies)
		for _,pluginId in ipairs(pluginIds) do
			if not Plugins.Loaded[pluginId] then
				print("Unable to resolve dependency \""..pluginId"\" for plugin "..plugin.name)
				return
			end
		end
		plugin.dependencies = nil --haaaaax
		Plugins.Register(plugin)
	end
end
hook.Add("SBPostPluginLoading", "DependencyResolver", handleDependencies)

Plugins.LoadPlugins()
