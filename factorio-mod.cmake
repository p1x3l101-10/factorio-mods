function(add_mod)
  # Arguments
  set(options INFO_IS_YAML)
  set(oneValueArgs NAME MOD_ROOT INFO_FILE)
  set(multiValueArgs)
  cmake_parse_arguments(_ADD_MOD "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )

  # Create working tree
  file(MAKE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/worktree")
  set(MOD_ROOT "${CMAKE_CURRENT_BINARY_DIR}/worktree/${_ADD_MOD_NAME}")
  file(MAKE_DIRECTORY ${MOD_ROOT})

  # Add files into the mod
  # Gather sources
  file(GLOB_RECURSE source_files CONFIGURE_DEPENDS "${_ADD_MOD_MOD_ROOT}/*")
  set(mod_targets)
  # Remove info files
  list(REMOVE_ITEM source_files "${_ADD_MOD_MOD_ROOT}/info.yaml" "${_ADD_MOD_MOD_ROOT}/info.json")
  # Copy to mod root
  foreach(file IN LISTS source_files)
    # Get normal file names
    string(REGEX REPLACE "^.*\/src\/" "" mod_file "${file}")
    # Save to a list
    list(APPEND mod_targets "${MOD_ROOT}/${mod_file}")
    # Get parent dirs
    get_filename_component(parent_dir "${mod_file}" DIRECTORY)
    # Create the copy target
    add_custom_command(
      OUTPUT "${MOD_ROOT}/${mod_file}"
      DEPENDS "${file}"
      COMMAND mkdir -p "${MOD_ROOT}/${parent_dir}"
      COMMAND cp "${file}" "${MOD_ROOT}/${mod_file}"
      COMMENT "Copying mod file: ${mod_file}"
    )
  endforeach()
  # License
  if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/LICENSE.md)
    add_custom_command(
      OUTPUT "${MOD_ROOT}/LICENSE.md"
      DEPENDS "${file}"
      COMMAND cp "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE.md" "${MOD_ROOT}/LICENSE.md"
      COMMENT "Adding License"
    )
    list(APPEND mod_targets "${MOD_ROOT}/LICENSE.md")
  endif()
  # Credits
  if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/CREDITS.md)
    add_custom_command(
      OUTPUT "${MOD_ROOT}/CREDITS.md"
      DEPENDS "${file}"
      COMMAND cp "${CMAKE_CURRENT_SOURCE_DIR}/CREDITS.md" "${MOD_ROOT}/CREDITS.md"
      COMMENT "Adding Credits"
    )
    list(APPEND mod_targets "${MOD_ROOT}/CREDITS.md")
  endif()
  # Copy correct info file to mod root
  if(_ADD_MOD_INFO_IS_YAML)
    find_program(YQ_BIN NAMES yq REQUIRED)
    add_custom_command(
      OUTPUT "${MOD_ROOT}/info.json"
      DEPENDS "${_ADD_MOD_INFO_FILE}"
      COMMAND ${YQ_BIN} -o=json -I0 "${_ADD_MOD_INFO_FILE}" > "${MOD_ROOT}/info.json"
      COMMENT "Converting info file"
    )
  else()
    find_program(JQ_BIN NAMES jq REQUIRED)
    add_custom_command(
      OUTPUT "${MOD_ROOT}/info.json"
      DEPENDS "${_ADD_MOD_INFO_FILE}"
      COMMAND jq --compact-output "${_ADD_MOD_INFO_FILE}" > "${MOD_ROOT}/info.json"
      COMMENT "Converting info file"
    )
  endif()
  list(APPEND mod_targets "${MOD_ROOT}/info.json")

  # Parse info for metadata
  if(_ADD_MOD_INFO_IS_YAML)
    parse_json(${YQ_BIN} ${_ADD_MOD_INFO_FILE} ".name" MOD_NAME)
    parse_json(${YQ_BIN} ${_ADD_MOD_INFO_FILE} ".version" MOD_VERSION)
  else()
    parse_json(${JQ_BIN} ${_ADD_MOD_INFO_FILE} ".name" MOD_NAME)
    parse_json(${JQ_BIN} ${_ADD_MOD_INFO_FILE} ".version" MOD_VERSION)
  endif()

  if(NOT ${_ADD_MOD_NAME} STREQUAL ${MOD_NAME})
    message(WARNING "Mod target '${_ADD_MOD_NAME}' does not match internal name! (${MOD_NAME})")
    message(WARNING "This could cause name conflicts")
  endif()

  # Do list processing so that I can only zip the declared files
  set(files_to_zip "${mod_targets}")
  list(TRANSFORM mod_targets REPLACE "^.*\/build\/worktree\/" "./" OUTPUT_VARIABLE files_to_zip)
  # Create the mod file
  find_program(ZIP_BIN zip REQUIRED)
  add_custom_command(
    OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${MOD_NAME}_${MOD_VERSION}.zip"
    DEPENDS ${mod_targets}
    COMMAND ${ZIP_BIN} -9 -r -q "${CMAKE_CURRENT_BINARY_DIR}/${MOD_NAME}_${MOD_VERSION}.zip" ${files_to_zip}
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/worktree
    COMMAND_EXPAND_LISTS
  )
  # Create a link for the current version
  add_custom_command(
    OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${MOD_NAME}_current.zip"
    DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/${MOD_NAME}_${MOD_VERSION}.zip"
    COMMAND ln -sf "${MOD_NAME}_${MOD_VERSION}.zip" "${CMAKE_CURRENT_BINARY_DIR}/${MOD_NAME}_current.zip"
    COMMENT "Linking current version"
  )
  # Add this target to all
  add_custom_target("Mod" ALL DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/${MOD_NAME}_current.zip")
  # Add clean rule
  set_target_properties("Mod" PROPERTIES ADDITIONAL_CLEAN_FILES "${CMAKE_CURRENT_BINARY_DIR}/worktree")
endfunction()

macro(parse_json jq_bin json_file key variable)
  execute_process(
    COMMAND ${jq_bin} "${key}" "${json_file}"
    COMMAND_ERROR_IS_FATAL ANY
    OUTPUT_STRIP_TRAILING_WHITESPACE
    OUTPUT_FILE "${CMAKE_CURRENT_BINARY_DIR}/.parse_json_result"
  )
  file(STRINGS "${CMAKE_CURRENT_BINARY_DIR}/.parse_json_result" ${variable})
endmacro()