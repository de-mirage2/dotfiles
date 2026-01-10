#!/bin/sh

echo $(rg -Nv '^#' $1 | shuf -n 1)
