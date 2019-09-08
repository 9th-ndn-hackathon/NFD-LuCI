#!/bin/bash
DEST=$1
if [[ -z $DEST ]]; then
  echo 'Usage: bash upload.sh ROUTER-IP' >/dev/stderr
  exit 2
fi
tar -C luci -cvf - . | ssh root@$DEST tar -C /usr/lib/lua/luci -xf -
