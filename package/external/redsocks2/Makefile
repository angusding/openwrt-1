#
# Copyright (C) 2015 OpenWrt-dist && wongsyrone
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=redsocks2
PKG_VERSION:=0.65
PKG_RELEASE:=1
PKG_REV:=02a53ce90413c73895fd3d126319478540c46571

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/semigodking/redsocks.git

PKG_LICENSE:=GPLv2
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Zhuofei Wang <SemigodKing@gmail.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/redsocks2/Default
	SECTION:=net
	CATEGORY:=Network
	TITLE:=TCP to SOCKS or HTTPS proxy server $(2)
	URL:=https://github.com/semigodking/redsocks
	VARIANT:=$(1)
	DEPENDS:=$(3)
endef

Package/redsocks2 = $(call Package/redsocks2/Default,openssl,(OpenSSL),+libevent2 +libopenssl)
Package/redsocks2-polarssl = $(call Package/redsocks2/Default,polarssl,(PolarSSL),+libevent2 +libpolarssl)

define Package/redsocks2/description
Redirect any TCP connection to a SOCKS or HTTPS proxy server. \
This is a modified version of original redsocks. \
The name is changed to be REDSOCKS2 since this release to distinguish with original redsocks. \
This variant is useful for anti-GFW (Great Fire Wall).
endef

Package/redsocks2-polarssl/description = $(Package/redsocks2/description)

define Package/redsocks2/conffiles
/etc/config/redsocks2
endef

Package/redsocks2-polarssl/conffiles = $(Package/redsocks2/conffiles)

define Package/redsocks2/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	uci -q batch <<-EOF >/dev/null
		delete ucitrack.@redsocks2[-1]
		add ucitrack redsocks2
		set ucitrack.@redsocks2[-1].init=redsocks2
		commit ucitrack
		delete firewall.redsocks2
		set firewall.redsocks2=include
		set firewall.redsocks2.type=script
		set firewall.redsocks2.path=/usr/share/redsocks2/firewall.include
		set firewall.redsocks2.reload=1
		commit firewall
EOF
fi
exit 0
endef

Package/redsocks2-polarssl/postinst = $(Package/redsocks2/postinst)

ifeq ($(BUILD_VARIANT),polarssl)
	MAKE_FLAGS += USE_CRYPTO_POLARSSL=true
endif

define Package/redsocks2/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/redsocks2 $(1)/usr/sbin/redsocks2
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/redsocks2.config $(1)/etc/config/redsocks2
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/redsocks2.init $(1)/etc/init.d/redsocks2
	$(INSTALL_DIR) $(1)/usr/share/redsocks2
	$(INSTALL_DATA) ./files/redsocks2.include $(1)/usr/share/redsocks2/firewall.include
	$(INSTALL_DIR) $(1)/etc/redsocks2
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/redsocks.conf.example $(1)/etc/redsocks2/config.example
endef

Package/redsocks2-polarssl/install = $(Package/redsocks2/install)

$(eval $(call BuildPackage,redsocks2))
$(eval $(call BuildPackage,redsocks2-polarssl))
