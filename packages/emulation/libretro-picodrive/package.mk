
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

PKG_NAME="libretro-picodrive"
PKG_VERSION="38d161b"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/libretro/picodrive"
PKG_URL="https://github.com/libretro/picodrive/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform $PKG_NAME:host"
PKG_PRIORITY="optional"
PKG_SECTION=""
PKG_SHORTDESC="Fast MegaDrive/MegaCD/32X emulator"
PKG_LONGDESC="Fast MegaDrive/MegaCD/32X emulator"
PKG_AUTORECONF="no"
PKG_IS_ADDON="no"

PKG_LIBNAME="picodrive_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="PICODRIVE_LIB"

pre_configure_host() {
  # fails to build in subdirs
  cd $ROOT/$PKG_BUILD
  rm -rf .$HOST_NAME
}

configure_host() {
  :
}

make_host() {
  if [ "$ARCH" == "arm" ]; then
    make -C cpu/cyclone CONFIG_FILE=../cyclone_config.h
  fi
}

makeinstall_host() {
  :
}

pre_configure_target() {
  # fails to build in subdirs
  cd $ROOT/$PKG_BUILD
  rm -rf .$TARGET_NAME
}

configure_target() {
  strip_gold
}

make_target() {
  make -f Makefile.libretro
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib
  cp $PKG_LIBPATH $INSTALL/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $INSTALL/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/$PKG_NAME-config.cmake
}

