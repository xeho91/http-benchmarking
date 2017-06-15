counter = 1
threads = {}
file = io.open('results/get/leads.csv', 'a')

-- SETUP
require("scripts.setup")

-- INIT
require("scripts.init")

-- REQUEST
request = function()
    requests = requests + 1

    method  = "GET"
	path    = [[/api/v1/leads?date_from="2017-05-27"&date_to="2017-05-28"]]
    require("scripts.auth")

    return wrk.format(method, path, headers)
end

-- RESPONSE
require("scripts.response")

-- DONE
require("scripts.done")
