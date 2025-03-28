cmake_minimum_required(VERSION 3.30)
project("p1x3l101-mods" NONE) # I use lua here
include(./factorio-mod.cmake) # The mod generator tools

add_mod(
  NAME "hexalith-nuclear-science"
  MOD_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/hexalith-nuclear-science
)

add_mod(
  NAME "p1x3l101-tweaks"
  MOD_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/tweaks
)

add_mod(
  NAME "p1x3l101-shared-parts"
  MOD_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/shared-parts
)

add_mod(
  NAME "pneumatic-inserter-fork"
  MOD_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/pneumatic-inserter-fork
)