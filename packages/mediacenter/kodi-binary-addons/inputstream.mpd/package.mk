################################################################################
#      This file is part of LibreELEC - http://www.libreelec.tv
#      Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="inputstream.mpd"
PKG_VERSION="2ebae49"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kodi.tv"
PKG_URL="https://github.com/mapfau/inputstream.mpd/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC=""

PKG_IS_ADDON="yes"

configure_target() {
  cmake -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CONF \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_MODULE_PATH=$SYSROOT_PREFIX/usr/lib/kodi \
        -DCMAKE_PREFIX_PATH=$SYSROOT_PREFIX/usr \
        ..
}

post_makeinstall_target() {
  mkdir -p wv && cd wv
  cmake -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CONF \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_MODULE_PATH=$SYSROOT_PREFIX/usr/lib/kodi \
        -DCMAKE_PREFIX_PATH=$SYSROOT_PREFIX/usr \
        $ROOT/$PKG_BUILD/wvdecrypter
  make

  mkdir -p $INSTALL/usr/lib/kodi/addons/$PKG_NAME/decrypter
  cp -P $ROOT/$PKG_BUILD/.$TARGET_NAME/wv/libssd_wv.so $INSTALL/usr/lib/kodi/addons/$PKG_NAME/decrypter
  if [ -d $ROOT/$PKG_BUILD/$TARGET_ARCH ]; then
    cp -P $ROOT/$PKG_BUILD/$TARGET_ARCH/* $INSTALL/usr/lib/kodi/addons/$PKG_NAME/decrypter
  fi

  # this is a workaround
  cp -PR $INSTALL/usr/lib/kodi/addons/$PKG_NAME/* $INSTALL/usr/share/kodi/addons/$PKG_NAME/
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/
  cp -PR $PKG_BUILD/.install_pkg/usr/share/kodi/addons/$PKG_NAME/* $ADDON_BUILD/$PKG_ADDON_ID/
  cp -PL $PKG_BUILD/.install_pkg/usr/lib/kodi/addons/$PKG_NAME/*.so $ADDON_BUILD/$PKG_ADDON_ID/
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/decrypter/
  cp -P $PKG_BUILD/.$TARGET_NAME/wv/libssd_wv.so $ADDON_BUILD/$PKG_ADDON_ID/decrypter/
  if [ -d $ROOT/$PKG_BUILD/$TARGET_ARCH ]; then
    cp -P $ROOT/$PKG_BUILD/$TARGET_ARCH/* $ADDON_BUILD/$PKG_ADDON_ID/decrypter
  fi
}
