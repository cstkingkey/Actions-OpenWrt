#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default

#echo 'add zerotier feed'
#sed -i '$a src-git zerotier https://github.com/mwarning/zerotier-openwrt.git' feeds.conf.default

#echo 'change feeds'
#sed -i 's/coolsnowwolf\/packages/cstkingkey\/packages/g' feeds.conf.default

echo 'Add a feed source'
echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

#svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
svn co https://github.com/openwrt/luci/trunk/collections/luci-ssl package/luci-ssl
sed -i 's/luci-light/luci/g' package/luci-ssl/Makefile
sed -i 's/include ..\/..\/luci.mk/include $(TOPDIR)\/feeds\/luci\/luci.mk/g' package/luci-ssl/Makefile
