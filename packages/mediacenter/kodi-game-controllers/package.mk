################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="kodi-game-controllers"
PKG_VERSION="0ea19e8"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kodi-game/kodi-game-controllers"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="mediacenter"
PKG_SHORTDESC="Repository for Kodi's game controller add-ons"
PKG_LONGDESC="Repository for Kodi's game controller add-ons"
PKG_AUTORECONF="no"
PKG_IS_ADDON="yes"

make_target() {
  :
}

makeinstall_target() {
 :
}

addon() {
  for _ADDON in $PKG_BUILD/addons/* ; do
    _ADDON_ID=$(basename $_ADDON)

    mkdir -p $ADDON_BUILD/$_ADDON_ID/
    cp -PR $PKG_BUILD/addons/$_ADDON_ID/* $ADDON_BUILD/$_ADDON_ID/

    MULTI_ADDONS="$MULTI_ADDONS $_ADDON_ID"
  done

  # export MULTI_ADDONS so create_addon knows multiple addons
  # were installed in $ADDON_BUILD/
  export MULTI_ADDONS="$MULTI_ADDONS"
}
