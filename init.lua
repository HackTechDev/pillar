-- build <player> <structure>
-- Build a structure

minetest.register_chatcommand("buildStructure", {
	params = "<structure name> <structure param>",
	description = "Build a structure with parameters",
	func = function(user, args)

		if args == "" then
			return false, "Parameters required."
		end

		local structureName, structureParam = args:match("^(%S+)%s(%S+)$")

		if not structureParam then
			return false, "Structure parameters required"
		end

		local player = minetest.get_player_by_name(user)
		if not player then
			return false, "Player not found"
		end

		local fmt = "Build a %s structure at: (%.2f,%.2f,%.2f)"

		local pos = player:getpos()
		
		-- /buildStructure pillar 5
		if structureName == "pillar" then
			minetest.chat_send_player(user, "Build pillar " .. structureParam)
			local heightPillar = tonumber(structureParam)
			for i = 0, heightPillar do
				minetest.set_node({x=pos.x + 2, y=pos.y + i, z=pos.z }, {name="default:ice"})
			end
		else
			return false, "No structure builded"
		end

		return true, fmt:format(args, pos.x, pos.y, pos.z)
	end
})
