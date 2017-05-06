counter = 1
threads = {}
file = io.open('results/post/leads-statistics.csv', 'a')

-- SETUP
require("scripts.setup")

-- INIT
require("scripts.init")

-- REQUEST
request = function()
    requests = requests + 1

    method  = "POST"
    path    = "/api/v1/leads/leads-statistics"
    require("scripts.auth")
	body    = [[{
		"date_from": "2016-11-12",
		"date_to": "2017-04-12",
		"product": "generic",
		"entity": "generic",
		"utm_campaign": "generic"
	}]]

    return wrk.format(method, path, headers, body)
end

-- RESPONSE
require("scripts.response")

-- DONE
require("scripts.done")
