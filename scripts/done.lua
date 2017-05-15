function done(summary, latency, requests)
    io.output(file)

    local total   = summary.requests
    local errors  = summary.errors.read + summary.errors.write + summary.errors.status + summary.errors.timeout
    local success = total - errors

    results = {
    -- LATENCY
        -- Latency min(ms)
        latency.min/1000,
        -- Latency min(s)
        latency.min/1000000,
        -- Latency max(ms)
        latency.max/1000,
        -- Latency max(s)
        latency.max/1000000,
        -- Latency avg(ms)
        latency.mean/1000,
        -- Latency mean(s)
        latency.mean/1000000,
        -- Latency stdev(ms)
        latency.stdev/1000,
        -- Latency stdev(s)
        latency.stdev/1000000,
        -- Latency percentile(5)(ms)
        latency:percentile(5)/1000,
        -- Latency percentile(5)(s)
        latency:percentile(5)/1000000,
        -- Latency percentile(50)(ms)
        latency:percentile(50)/1000,
        -- Latency percentile(50)(s)
        latency:percentile(50)/1000000,
        -- Latency percentile(95)(ms)
        latency:percentile(95)/1000,
        -- Latency percentile(95)(s)
        latency:percentile(95)/1000000,

    -- REQUESTS
        -- Min req/s
        requests.min,
        -- Max req/s
        requests.max,
        -- Avg req/s
        requests.mean,
        -- Stdev req/s
        requests.stdev,
        -- Percentile(5) req/s
        requests:percentile(5),
        -- Percentile(50) req/s
        requests:percentile(50),
        -- Percentile(95) req/s
        requests:percentile(95),

    -- SUMMARY
        -- Test duration (ms)
        summary.duration/1000,
        -- Test duration (s)
        summary.duration/1000000,

        -- Successful responses
        success,
        -- Successful responses(%)
        success/total*100,

        -- Errors received
        errors,
        -- Errors received(%)
        errors/total*100,

    -- ERRORS
        -- Errors received - connect
        summary.errors.connect,
        -- Errors received - connect(%)
        summary.errors.connect/total*100,
        -- Errors received - read
        summary.errors.read,
        -- Errors received - read(%)
        summary.errors.read/total*100,
        -- Errors received - write
        summary.errors.write,
        -- Errors received - write(%)
        summary.errors.write/total*100,
        -- Errors received - status
        summary.errors.status,
        -- Errors received - status(%)
        summary.errors.status/total*100,
        -- Errors received - timeout
        summary.errors.timeout,
        -- Errors received - timeout(%)
        summary.errors.timeout/total*100,

    -- DATA
        -- Data received(B)
        summary.bytes,
        -- Data received(KB)
        summary.bytes/1000,
        -- Data per second(B)
        summary.bytes/(summary.duration/1000000),
        -- Data per second(KB)
        (summary.bytes/1000)/(summary.duration/1000000)
    }

    for key, value in pairs(results) do
        io.write(value .. ",")
    end
    io.write("\n")

    io.close(file)
end
