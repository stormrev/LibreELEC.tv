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

PKG_NAME="libretro-craft"
PKG_VERSION="1a2809d"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/Craft"
PKG_URL="https://github.com/libretro/Craft/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_PRIORITY="optional"
PKG_SECTION=""
PKG_SHORTDESC="A simple Minecraft clone written in C using modern OpenGL (shaders)"
PKG_LONGDESC="A simple Minecraft clone written in C using modern OpenGL (shaders)"
PKG_AUTORECONF="no"
PKG_IS_ADDON="no"

PKG_LIBNAME="craft_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="CRAFT_LIB"

pre_configure_target() {
  # fails to build in subdirs
  cd $ROOT/$PKG_BUILD
  rm -rf .$TARGET_NAME
}

make_target() {
  case $PROJECT in
    RPi)
      make -f Makefile.libretro platform=rpi
      ;;
    RPi2)
      make -f Makefile.libretro platform=rpi2
      ;;
    imx6)
      make -f Makefile.libretro platform=imx6
      ;;
    WeTek_Play)
      make -f Makefile.libretro platform=armv7-neon-gles-cortex-a9
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

