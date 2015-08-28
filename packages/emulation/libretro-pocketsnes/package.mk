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

PKG_NAME="libretro-pocketsnes"
PKG_VERSION="033a61a"
PKG_REV="1"
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/pocketsnes-libretro"
PKG_URL="https://github.com/libretro/pocketsnes-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_PRIORITY="optional"
PKG_SECTION=""
PKG_SHORTDESC="Port of SNES9x 1.39 for libretro. Heavily optimized for ARM."
PKG_LONGDESC="Port of SNES9x 1.39 for libretro. Heavily optimized for ARM."
PKG_AUTORECONF="no"
PKG_IS_ADDON="no"

PKG_LIBNAME="pocketsnes_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="POCKETSNES_LIB"

pre_make_target() {
  export CFLAGS="$CFLAGS -std=gnu11"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib
  cp $PKG_LIBPATH $INSTALL/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $INSTALL/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/$PKG_NAME-config.cmake
}

