#!/usr/bin/env bash

export ROOT="$(pwd)"

export PREFIX="$ROOT/opt/cross"
export TARGET=i686-elf
export PATH="$ROOT/opt/other/bin:$PREFIX/bin:$PATH"
