function done(summary, latency, requests)
    io.output(file)

-- GENERAL INFO
    -- Date & Time
    io.write(os.date("%Y-%m-%d %H:%M:%S"))
    io.write(",")
    -- Threads
    io.write(table.getn(threads))
    io.write(",")

    -- for index, thread in ipairs(threads) do
    --     local id        = thread:get("id")
    --     local requests  = thread:get("requests")
    --     local responses = thread:get("responses")
    --
    --     local msg = "Thread %-2d made %-3d requests and got %-3d responses"
    --     io.write(msg:format(id, requests, responses))
    -- end

-- LATENCY
    -- Latency min(ms)
    io.write(latency.min/1000)
    io.write(",")
    -- Latency min(s)
    io.write(latency.min/1000000)
    io.write(",")
    -- Latency max(ms)
    io.write(latency.max/1000)
    io.write(",")
    -- Latency max(s)
    io.write(latency.max/1000000)
    io.write(",")
    -- Latency avg(ms)
    io.write(latency.mean/1000)
    io.write(",")
    -- Latency mean(s)
    io.write(latency.mean/1000000)
    io.write(",")
    -- Latency stdev(ms)
    io.write(latency.stdev/1000)
    io.write(",")
    -- Latency stdev(s)
    io.write(latency.stdev/1000000)
    io.write(",")
    -- Latency percentile(5)(ms)
    io.write(latency:percentile(5)/1000)
    io.write(",")
    -- Latency percentile(5)(s)
    io.write(latency:percentile(5)/1000000)
    io.write(",")
    -- Latency percentile(50)(ms)
    io.write(latency:percentile(50)/1000)
    io.write(",")
    -- Latency percentile(50)(s)
    io.write(latency:percentile(50)/1000000)
    io.write(",")
    -- Latency percentile(95)(ms)
    io.write(latency:percentile(95)/1000)
    io.write(",")
    -- Latency percentile(95)(s)
    io.write(latency:percentile(95)/1000000)
    io.write(",")

-- REQUESTS
    -- Min req/s
    io.write(requests.min)
    io.write(",")
    -- Max req/s
    io.write(requests.max)
    io.write(",")
    -- Avg req/s
    io.write(requests.mean)
    io.write(",")
    -- Stdev req/s
    io.write(requests.stdev)
    io.write(",")
    -- Percentile(5) req/s
    io.write(requests:percentile(5))
    io.write(",")
    -- Percentile(50) req/s
    io.write(requests:percentile(50))
    io.write(",")
    -- Percentile(95) req/s
    io.write(requests:percentile(95))
    io.write(",")

-- SUMMARY
    local total   = summary.requests
    local errors  = summary.errors.read + summary.errors.write + summary.errors.status + summary.errors.timeout
    local success = total - errors

    -- Test duration (ms)
    io.write(summary.duration/1000)
    io.write(",")
    -- Test duration (s)
    io.write(summary.duration/1000000)
    io.write(",")

    -- Successful responses
    io.write(success)
    io.write(",")
    -- Successful responses(%)
    io.write(success/total*100)
    io.write(",")

    -- Errors received
    io.write(errors)
    io.write(",")
    -- Errors received(%)
    io.write(errors/total*100)
    io.write(",")

    -- Errors received - connect
    io.write(summary.errors.connect)
    io.write(",")
    -- Errors received - connect(%)
    io.write(summary.errors.connect/total*100)
    io.write(",")
    -- Errors received - read
    io.write(summary.errors.read)
    io.write(",")
    -- Errors received - read(%)
    io.write(summary.errors.read/total*100)
    io.write(",")
    -- Errors received - write
    io.write(summary.errors.write)
    io.write(",")
    -- Errors received - write(%)
    io.write(summary.errors.write/total*100)
    io.write(",")
    -- Errors received - status
    io.write(summary.errors.status)
    io.write(",")
    -- Errors received - status(%)
    io.write(summary.errors.status/total*100)
    io.write(",")
    -- Errors received - timeout
    io.write(summary.errors.timeout)
    io.write(",")
    -- Errors received - timeout(%)
    io.write(summary.errors.timeout/total*100)
    io.write(",")

    -- Data received(B)
    io.write(summary.bytes)
    io.write(",")
    -- Data received(KB)
    io.write(summary.bytes/1000)
    io.write(",")
    -- Data per second(B)
    io.write(summary.bytes/(summary.duration/1000000))
    io.write(",")
    -- Data per second(KB)
    io.write((summary.bytes/1000)/(summary.duration/1000000))
    io.write("\n")

    io.close(file)
    print("Results saved in 'results' folder!")
end
