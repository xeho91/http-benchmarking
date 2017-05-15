counter = 1
threads = {}
file = io.open('results/post/customers.csv', 'a')

-- SETUP
require("scripts.setup")

-- INIT
require("scripts.init")

-- REQUEST
request = function()
    requests = requests + 1

	require("scripts.randomValue")

	method  = "POST"
    path    = "/api/v1/customers"
    require("scripts.auth")
	body    = [[{
		"lead_id": "a9aa445312aab6f75b4c98c455b8f820",
		"email": "]].. randomValue("name") .. randomValue("ID", 5) ..[[@]].. randomValue("surname") ..[[.pl",
		"entity_id": 1,
		"fields": {
			"name": "]].. randomValue("name") ..[[",
			"surname": "]].. randomValue("surname") ..[[",
			"phone_number": "+48 ]].. math.random(100000000, 999999999) ..[["
		}
	}]]

    return wrk.format(method, path, headers, body)
end

-- RESPONSE
require("scripts.response")

-- DONE
require("scripts.done")
