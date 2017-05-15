# http-benchmarking
wrk http-benchmarking setup for my dear friend - Lycha! :)

# First step
To start using it go to wrk directory.

Then please firstly edit the line`scripts/auth.lua`.
```
["Authorization"] = "Insert your own auth token here"
```
Unless you have different headers configuration, feel free to edit it here.

# Setup
To configure testing options, edit `test.sh` file.
You can modify **duration**, **connection** and **trial** options.

# Usage
To start testing please use:
```sh
$ ./test.sh <get/post> <testing_object>
```
Currently available testing objects:
* GET
  * customers
  * leads
* POST
  * customers
  * customers-statistics
  * leads
  * leads-statistics

Example:
```sh
$ ./test.sh get leads
```

Or if you want to test all of existing files, just simply use:
```sh
$./test.sh all
```


# Results
Results will be saved in `results` folder.
Each testing object has own `.csv` file.
It can be converted to JSON or edited with any Sheets editing program.
