project(game.libretro.pocketsnes)

cmake_minimum_required(VERSION 2.6)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR})

enable_language(CXX)

find_package(kodi REQUIRED)
find_package(libretro-pocketsnes REQUIRED)

set(DEPLIBS pocketsnes)
set(POCKETSNES_CUSTOM_BINARY ${POCKETSNES_LIB}
                         ${PROJECT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX} pocketsnes)

build_addon(${PROJECT_NAME} POCKETSNES DEPLIBS)

