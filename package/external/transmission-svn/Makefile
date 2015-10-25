#
# Copyright (C) 2009-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_BRANCH:=trunk
PKG_SOURCE_URL:=svn://svn.transmissionbt.com/Transmission/trunk
PKG_REV:=14589

PKG_NAME:=transmission-svn
PKG_VERSION:=2.84+r$(PKG_REV)
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=svn
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2


PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/transmission-svn/template
  SUBMENU:=BitTorrent
  SECTION:=net
  CATEGORY:=Network
  TITLE:=A free, lightweight BitTorrent client
  URL:=https://trac.transmissionbt.com/timeline
  MAINTAINER:=Cezary Jackiewicz <cezary@eko.one.pl>
endef

define Package/transmission-svn-daemon
  $(call Package/transmission-svn/template)
  DEPENDS:=+libcurl +libopenssl +libpthread +libevent2 +librt
  MENU:=1
  USERID:=transmission=224:transmission=224
endef

define Package/transmission-svn-daemon/description
 Transmission is a simple BitTorrent client.
 It features a very simple, intuitive interface
 on top on an efficient, cross-platform back-end.
 This package contains the daemon itself.
endef


define Package/transmission-svn-daemon/conffiles
/etc/config/transmission
endef

#CONFIGURE_VARS += \
	LIBEVENT_LIBS="$(STAGING_DIR)/usr/lib/libevent-2.0.so.5"

#CONFIGURE_ARGS += \
	--enable-daemon \
	--enable-cli \
	--enable-utp \
	--without-gtk \
	--enable-largefile


CMAKE_OPTIONS += \
	-DENABLE_DAEMON=ON \
	-DENABLE_GTK=OFF \
	-DENABLE_QT=OFF \
	-DENABLE_TESTS=OFF \
	-DINSTALL_DOC=OFF \
	-DUSE_SYSTEM_MINIUPNPC=OFF \
	-DWITH_SYSTEMD=OFF \
	-DEVENT2_LIBRARY:String="$(STAGING_DIR)/usr/lib/libevent-2.0.so.5"


# temporary fix github download issue before make
define Build/Configure
	$(call Build/Configure/Default)
	(cd $(PKG_BUILD_DIR)/third-party/b64-c1e3323498/src; \
		wget https://github.com/mikedld/libb64/archive/c1e3323498.tar.gz; \
	cd $(PKG_BUILD_DIR)/third-party/dht-cc379e406d/src; \
		wget https://github.com/jech/dht/archive/cc379e406d.tar.gz; \
	cd $(PKG_BUILD_DIR)/third-party/miniupnpc-5de2bcb561/src; \
		wget https://github.com/miniupnp/miniupnp/archive/5de2bcb561.tar.gz; \
	cd $(PKG_BUILD_DIR)/third-party/natpmp-cf7f452d66/src; \
		wget https://github.com/miniupnp/libnatpmp/archive/cf7f452d66.tar.gz; \
	cd $(PKG_BUILD_DIR)/third-party/utp-7c4f19abdf/src; \
		wget https://github.com/bittorrent/libutp/archive/7c4f19abdf.tar.gz; \
	)
endef

define Package/transmission-svn-daemon/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/transmission-daemon $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) files/transmission.init $(1)/etc/init.d/transmission
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) files/transmission.config $(1)/etc/config/transmission
endef


$(eval $(call BuildPackage,transmission-svn-daemon))
