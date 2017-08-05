#!/bin/bash

perf stat -ddd ./ffb > /dev/null
perf stat -ddd ./naive > /dev/null
perf stat -ddd ./counting > /dev/null
perf stat -ddd ./bitwise > /dev/null

