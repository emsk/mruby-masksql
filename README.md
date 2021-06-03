# mruby-masksql

[![Build Status](https://github.com/emsk/mruby-masksql/actions/workflows/build.yml/badge.svg)](https://github.com/emsk/mruby-masksql/actions/workflows/build.yml)
[![Build Status](https://travis-ci.org/emsk/mruby-masksql.svg?branch=main)](https://travis-ci.org/emsk/mruby-masksql)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A command-line tool to mask sensitive values in a SQL file

*This tool is an mruby implementation of the [mask_sql](https://github.com/emsk/mask_sql).*

## Installation

Binary files for macOS and Linux (NOT for Windows) are provided.

1. [Download the zip file](../../releases)
2. Extract it
3. Put the binary file to the directory you want
4. Add the directory to the PATH environment variable

## Usage

### Mask sensitive values in a SQL file

```sh
$ mruby-masksql --in dump.sql --out masked_dump.sql --config mask_config.yml
```

### Generate a config file

```sh
$ mruby-masksql init
```

See [mask_sql's README](https://github.com/emsk/mask_sql) for more details.

## License

[MIT](LICENSE)
