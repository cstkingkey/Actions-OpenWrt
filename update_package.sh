#!/usr/bin/env bash
# make package/feeds/packages/adguardhome/download V=sc && make package/feeds/packages/adguardhome/check FIXUP=1
make $1download V=sc && make $1check FIXUP=1
