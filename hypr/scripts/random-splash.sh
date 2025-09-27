#!/bin/bash

echo $(rg -Nv '^#' "splashes.txt" | shuf -n 1)
