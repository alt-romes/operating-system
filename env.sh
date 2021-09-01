#!/bin/bash

ROOT="$(echo $( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd ))"
export ROOT

export PATH="$ROOT/opt/other/bin:$ROOT/opt/cross/bin:$PATH"
