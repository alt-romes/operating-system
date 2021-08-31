#!/bin/bash

ROOT="$(echo $( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd ))"
export ROOT

export PREFIX="$ROOT/opt/cross"
export TARGET=i686-elf
export PATH="$ROOT/opt/other/bin:$PREFIX/bin:$PATH"
