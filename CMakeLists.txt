cmake_minimum_required(VERSION 3.30)
project("hexalith-nuclear-science" NONE) # I use lua here
include(./factorio-mod.cmake) # The mod generator tools

add_mod(
  NAME ${PROJECT_NAME}
  MOD_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/src
  INFO_FILE ${CMAKE_CURRENT_SOURCE_DIR}/src/info.yaml INFO_IS_YAML
)