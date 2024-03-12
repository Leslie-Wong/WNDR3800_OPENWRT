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

# Modify default IP
sed -i 's/192.168.1.1/192.168.3.1/g' $GITHUB_WORKSPACE/openwrt/package/base-files/files/bin/config_generate

# mosdns ENABLED CGO
sed -i 's/CGO_ENABLED=0/CGO_ENABLED=1/g' $GITHUB_WORKSPACE/openwrt/packages/blob/master/net/mosdns/Makefile

echo '修改默认主题'
sed -i 's/config internal themes/config internal themes\n    option Argon  \"\/luci-static\/argon\"/g' $GITHUB_WORKSPACE/openwrt/feeds/luci/modules/luci-base/root/etc/config/luci

# 移除 openwrt feeds 自带的核心包
rm -rf $GITHUB_WORKSPACE/openwrt/feeds/packages/net/{xray-core,v2ray-core,v2ray-geodata,sing-box}
rm -rf  $GITHUB_WORKSPACE/openwrt/feeds/jell/{base-files,dnsmasq,firewall*,fullconenat,libnftnl,nftables,ppp,opkg,ucl,upx,vsftpd-alt,miniupnpd-iptables,wireless-regdb}

# 更新 golang 1.22 版本
cd $GITHUB_WORKSPACE/openwrt
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages/lang/golang


echo 'Update Mosdns package'
cd $GITHUB_WORKSPACE/openwrt

find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
find ./ | grep Makefile | grep mosdns | xargs rm -f

git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# 更新 chinadns-ng 版本
rm -rf $GITHUB_WORKSPACE/openwrt/feeds/jell/chinadns-ng
#svn co https://github.com/xiaorouji/openwrt-passwall-packages/trunk/chinadns-ng/ $GITHUB_WORKSPACE/openwrt/feeds/jell/chinadns-ng
cd $GITHUB_WORKSPACE/openwrt/feeds
mkdir temp_chinadns-ng
cd temp_chinadns-ng
git init
git config core.sparseCheckout true
echo 'chinadns-ng' > .git/info/sparse-checkout
git remote add -f origin https://github.com/xiaorouji/openwrt-passwall-packages.git
git pull origin main
vm chinadns-ng $GITHUB_WORKSPACE/openwrt/feeds/jell/
cd ..
rm -rf temp_chinadns-ng
