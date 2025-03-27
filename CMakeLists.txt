cmake_minimum_required(VERSION 3.30)
project("p1x3l101-mods" NONE) # I use lua here
include(./factorio-mod.cmake) # The mod generator tools

add_mod(
  NAME "hexalith-nuclear-science"
  MOD_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/hexalith-nuclear-science
)