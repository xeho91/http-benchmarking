counter = 1
threads = {}
file = io.open('results/get/customers.csv', 'a')

-- SETUP
require("scripts.setup")

-- INIT
require("scripts.init")

-- REQUEST
request = function()
    requests = requests + 1

    method  = "GET"
    path    = [[/api/v1/customers?date_from="2016-11-12"&date_to="2017-04-12"]]
    require("scripts.auth")

    return wrk.format(method, path, headers)
end

-- RESPONSE
require("scripts.response")

-- DONE
require("scripts.done")
