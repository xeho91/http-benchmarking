math.randomseed(os.time())
math.random(); math.random(); math.random()

function randomValue(value, length)
	local entity   = { "poznan", "krakow" }
	-- leads
	local product  = { "generic", "global-talents" }
	local medium   = { "generic", "paid" }
	local campaign = { "generic", "winter-peak-2016" }
	local source   = { "generic", "my-source" }
	-- customers
	local name    = { "Dan", "Jerry", "Tom", "Katherine", "Agatha", "Joanne", "Chris", "Laurel" }
	local surname = { "Brown", "Christie", "Rowling", "Beckett", "Lance", "DeArc", "Columbus", "Queen" }

	local charset  = {}
	for i = 48,  57 do table.insert(charset, string.char(i)) end
	for i = 65,  90 do table.insert(charset, string.char(i)) end
	for i = 97, 122 do table.insert(charset, string.char(i)) end

	if value == "ID" then
		if length > 0 then
			return randomValue("ID", length - 1) .. charset[math.random(1, #charset)]
		else
			return ""
		end
	elseif value == "entity" then return entity[math.random(1, #entity)]
	-- leads
	elseif value == "product" then return product[math.random(1, #product)]
	elseif value == "medium" then return medium[math.random(1, #medium)]
	elseif value == "campaign" then return campaign[math.random(1, #campaign)]
	elseif value == "source" then return source[math.random(1, #source)]
	-- customers
	elseif value == "name" then return name[math.random(1, #name)]
	elseif value == "surname" then return surname[math.random(1, #surname)]
	end
end
