#!/bin/sh
mpc toggle
kill $(pstree -lp | grep -- -baraction.sh | sed "s/.*sleep//" | sed "s/(//" | sed "s/)//")

