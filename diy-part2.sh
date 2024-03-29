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

chmod +x $GITHUB_WORKSPACE/functions.sh
source $GITHUB_WORKSPACE/functions.sh


# Modify default IP
sed -i 's/192.168.1.1/192.168.3.1/g' $GITHUB_WORKSPACE/openwrt/package/base-files/files/bin/config_generate


echo '修改默认主题'
sed -i 's/config internal themes/config internal themes\n    option Argon  \"\/luci-static\/argon\"/g' $GITHUB_WORKSPACE/openwrt/feeds/luci/modules/luci-base/root/etc/config/luci

rm -rf $GITHUB_WORKSPACE/openwrt/feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 22.x $GITHUB_WORKSPACE/openwrt/feeds/packages/lang/golang

cp -R $GITHUB_WORKSPACE/patchs/613-netfilter_optional_tcp_window_check.patch $GITHUB_WORKSPACE/openwrt/target/linux/generic/pending-5.15/613-netfilter_optional_tcp_window_check.patch
