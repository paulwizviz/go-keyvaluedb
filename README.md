# Overview

A key–value database, or key–value store, is a data storage paradigm designed for storing, retrieving, and managing associative arrays, and a data structure more commonly known today as a dictionary or hash table ([Source: Wiki](https://en.wikipedia.org/wiki/Key%E2%80%93value_database)).

The working examples uses Go to illustrate implementation. To work with the examples, please install:

* Go version 1.18 or later
* Docker (with docker-compose)

## Project structure

This project has been structured in a way to help you find working example based on the Go coding standard. You will find the Go codes organised in these folders:

* `build` -- scripts used to create apps and containers
* `cmd` -- source codes for building executables
• `scripts` - bash scripts to help you build and execute apps.

## Topics

* [Badger DB](./docs/badgerdb.md)
* [Level DB](./docs/leveldb.md)
* [Influx DB](./docs/influx.md)

## Disclaimers

The working examples in this projects are purely for illustration only and are subject to modification without notice. Any opinions expressed is this project mine or belongs to the author of any referenced materials.

## Copyright

Unless specificed copyright in this project are assigned as follows.

Copyright 2022 Paul Sitoh

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.