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

#echo 'revert commit'
#git revert -n c6bb9a7912a0f2dda7d7f67fc607297dac688db0 fda63a952cd6764724df9a1f1a2b5db793028808 f061029ed17d33ba5dbd03981ddfe17c6c10e888 

echo 'Modify default IP'
sed -i 's/192.168.1.1/192.168.100.100/g' package/base-files/files/bin/config_generate

echo 'fix vlan ports displaying'
sed -i '$a \
.cbi-section-table-descr { \
    display: table-row !important;\
}' feeds/luci/themes/luci-theme-argon/htdocs/luci-static/argon/css/style.css

echo '修改默认主题'
sed -i 's/config internal themes/config internal themes\n    option Argon  \"\/luci-static\/argon\"/g' feeds/luci/modules/luci-base/root/etc/config/luci

echo '去除默认bootstrap主题'
#sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
sed -i 's/theme-bootstrap/theme-argon/g' feeds/luci/collections/luci/Makefile

echo '关闭WiFi'
sed -i 's/disabled=0/disabled=1/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

echo '删除lean默认设置选项'
# 开启wifi
sed -i '/wireless/d' package/lean/default-settings/files/zzz-default-settings

#echo '使用外部zerotier'
## when using feed, it;s not installing external one, so the building fails. Use clone directlly.
#rm -rf ./feeds/packages/net/zerotier
#git clone https://github.com/cstkingkey/zerotier-openwrt.git ./package/zerotier

#echo 'replace dep'
#sed -i 's/ip-full/ip-tiny/g' feeds/luci/applications/luci-app-arpbind/Makefile

echo 'fix uclient-fetch'
sed -i 's/ALTERNATIVES:=200:\/usr\/bin\/wget:\/bin\/uclient-fetch/ALTERNATIVES:= \n  $(if $(CONFIG_PACKAGE_wget), ,ALTERNATIVES+= \\\n    200:\/usr\/bin\/wget:\/bin\/uclient-fetch \\\n    200:\/usr\/bin\/wget-ssl:\/bin\/uclient-fetch)/g' package/libs/uclient/Makefile

sed -i 's/ --tries=1//g' feeds/luci/applications/luci-app-adbyby-plus/root/usr/share/adbyby/admem.sh
sed -i 's/ www/ http:\/\//g' feeds/luci/applications/luci-app-adbyby-plus/root/usr/share/adbyby/admem.sh

sed -i 's/"auto",/"auto",ip6addr,/g' package/network/ipv6/odhcp6c/files/dhcpv6.sh
cp -r $GITHUB_WORKSPACE/packages/* package/