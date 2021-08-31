#!/usr/bin/env bash

export ROOT="$(pwd)"

export PREFIX="$ROOT/opt/cross"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$ROOT/opt/bin:$PATH"
