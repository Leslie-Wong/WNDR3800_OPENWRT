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

chmod +x $GITHUB_WORKSPACE/functions.sh
source $GITHUB_WORKSPACE/functions.sh


# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default

# Add luci-theme-argon
cd $GITHUB_WORKSPACE/openwrt/package
git clone https://github.com/jerrykuku/luci-theme-argon.git


sudo sed -i 's/DEFAULT:@SECLEVEL=2/DEFAULT:@SECLEVEL=1/g' /etc/ssl/openssl.cnf
sudo sed -i 's/DEFAULT:@SECLEVEL=2/DEFAULT:@SECLEVEL=1/g' /usr/lib/ssl/openssl.cnf
