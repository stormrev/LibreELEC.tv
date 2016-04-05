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

PKG_NAME="libretro-pcsx-rearmed"
PKG_VERSION="bb22137"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/pcsx_rearmed"
PKG_URL="https://github.com/libretro/pcsx_rearmed/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_PRIORITY="optional"
PKG_SECTION=""
PKG_SHORTDESC="game.libretro.pcsx-rearmed: PCSX Rearmed for Kodi"
PKG_LONGDESC="game.libretro.pcsx-rearmed: PCSX Rearmed for Kodi"
PKG_AUTORECONF="no"
PKG_IS_ADDON="no"

PKG_LIBNAME="pcsx_rearmed_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="PCSX_REARMED_LIB"

make_target() {
  case $PROJECT in
    RPi)
      make -f Makefile.libretro platform=armv6-hardfloat-arm1176jzf-s
      ;;
    RPi2)
      make -f Makefile.libretro platform=armv7-neon-hardfloat-cortex-a7
      ;;
    imx6)
      make -f Makefile.libretro platform=armv7-neon-hardfloat-cortex-a9
      ;;
    WeTek_Play)
      make -f Makefile.libretro platform=armv7-neon-hardfloat-cortex-a9
      ;;
    Generic)
      make -f Makefile.libretro 
      ;;
  esac
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib
  cp $PKG_LIBPATH $INSTALL/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $INSTALL/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/$PKG_NAME-config.cmake
}

