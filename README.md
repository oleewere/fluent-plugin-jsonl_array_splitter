# JSONL array splitter filter plugin for Fluentd

[![Build Status](https://travis-ci.org/oleewere/fluent-plugin-jsonl_array_splitter.svg?branch=master)](https://travis-ci.org/oleewere/fluent-plugin-jsonl_array_splitter)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## Requirements

| fluent-plugin-jsonl_array_splitter | fluentd | ruby |
|------------------------|---------|------|
| >= 1.0.0 | >= v0.14.0 | >= 2.4 |
|  < 1.0.0 | >= v0.12.0 | >= 2.1 |

## Overview

Fluent filter plugin that can construct multiple records from one JSONL formatted (string) record.

## Installation

Install from RubyGems:
```
$ gem install fluent-plugin-jsonl_array_splitter
```

## Configuration

```
<filter preprocessed.raw.**>
  @type jsonl_array_splitter
  key_name rawJsonLines
</filter>
```

Input:

```json
{"command_field": "v1", "jsonlRaw": "{\"key1\": \"val1\"},{\"key2\": \"val2\"}\n{\"key1\": \"val3\"},{\"key2\": \"val4\"}"}
```

Filter Output:

```json
  {"command_field": "v1", "key1": "val1", "key2": "val2"},
  {"command_field": "v1", "key1": "val3", "key2": "val4"}
```

### Configuration options

`key_name`: JSONL field name that needs to be parsed/splitted

`reserve_key`: keep original JSONL field in the output

`debug`: print lines that are parsed one-by-one

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
