#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

echo 'Modify default IP'
sed -i 's/192.168.1.1/192.168.100.100/g' package/base-files/files/bin/config_generate

echo 'fix vlan ports displaying'
sed -i '$a \
.cbi-section-table-descr { \
    display: table-row !important;\
}' package/lean/luci-theme-argon/htdocs/luci-static/argon/css/style.css

echo '修改默认主题'
sed -i 's/config internal themes/config internal themes\n    option Argon  \"\/luci-static\/argon\"/g' feeds/luci/modules/luci-base/root/etc/config/luci

echo '去除默认bootstrap主题'
#sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
sed -i 's/theme-bootstrap/theme-argon/g' feeds/luci/collections/luci/Makefile

#echo '关闭WiFi'
#sed -i 's/disabled=0/disabled=1/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

#echo '删除默认zerotier'
# not installing external one, so the building fails
#rm -rf ./feeds/packages/net/zerotier