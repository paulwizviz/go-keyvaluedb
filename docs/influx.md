# Influx DB

Influx DB is a time series database storing information based principally on timestamp. Please refer to the [official documentation](https://docs.influxdata.com/influxdb/v2.3/) for details.


### A simple example

This example provides a RESTFul network connecting to an influx database. The example code is [here](../cmd/influxcmd/simple/main.go). Use this [script](../scripts/influxdb/ops.sh) to run the example.

* `./scripts/influxdb/ops.sh build` - Build containers
* `./scripts/influxdb/ops.sh start` - Start the RESTFul server
* `./scripts/influxdb/ops.sh stop` - Stop the RESTFul server
* `./scripts/influxdb/ops.sh clean` - Remove docker images and containers from your system.

When you have the example running, GET http://localhost:4040/. This will return a set of demostration data.
