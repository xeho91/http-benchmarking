counter = 1
threads = {}
file = io.open('results/post/leads.csv', 'a')

-- SETUP
require("scripts.setup")

-- INIT
require("scripts.init")

-- REQUEST
request = function()
    requests = requests + 1

    require("scripts.randomValue")

	method  = "POST"
    path    = "/api/v1/leads"
    require("scripts.auth")
    body 	= [[{
  		"id": "]].. randomValue("ID", 32) ..[[",
  		"utm_source": "]].. randomValue("source") ..[[",
  		"utm_campaign": "]].. randomValue("campaign") ..[[",
  		"utm_medium": "]].. randomValue("medium") ..[[",
  		"utm_content": "my-content",
  		"utm_term": "my-term",
  		"entity": "]].. randomValue("entity") ..[[",
         "product": "]].. randomValue("product") ..[["
	}]]

	return wrk.format(method, path, headers, body)
end

-- RESPONSE
require("scripts.response")

-- DONE
require("scripts.done")
