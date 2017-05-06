function setup(thread)
    thread:set("id", counter)
    table.insert(threads, thread)
    counter = counter + 1
end
