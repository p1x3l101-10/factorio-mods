function(add_mod)
  # Arguments
  set(options)
  set(oneValueArgs NAME MOD_ROOT)
  set(multiValueArgs)
  cmake_parse_arguments(_ADD_MOD "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )

  # Create working tree
  file(MAKE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/worktree")
  set(MOD_ROOT "${CMAKE_CURRENT_BINARY_DIR}/worktree/${_ADD_MOD_NAME}")
  file(MAKE_DIRECTORY ${MOD_ROOT})

  # Add files into the mod
  # Get the base name
  string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/" "" MOD_BASEDIR "${_ADD_MOD_MOD_ROOT}")
  # Gather sources
  file(GLOB_RECURSE source_files CONFIGURE_DEPENDS "${_ADD_MOD_MOD_ROOT}/*")
  set(mod_targets)
  # Copy to mod root
  foreach(file IN LISTS source_files)
    # Get normal file names
    string(REGEX REPLACE "^.*\/${MOD_BASEDIR}\/" "" mod_file "${file}")
    # Save to a list
    list(APPEND mod_targets "${MOD_ROOT}/${mod_file}")
    # Get parent dirs
    get_filename_component(parent_dir "${mod_file}" DIRECTORY)
    # Make sure that the file is not a yaml file, we need to translate those into json
    if(mod_file MATCHES "^(.*)?\.yaml$")
      # Change target list to reflect translated file
      list(POP_BACK mod_targets)
      string(REPLACE ".yaml" ".json" translated_mod_file "${mod_file}")
      list(APPEND mod_targets "${MOD_ROOT}/${translated_mod_file}")
      # Create a translation target
      find_program(YQ_BIN NAMES yq REQUIRED)
      add_custom_command(
        OUTPUT "${MOD_ROOT}/${translated_mod_file}"
        DEPENDS "${file}"
        COMMAND mkdir -p "${MOD_ROOT}/${parent_dir}"
        COMMAND ${YQ_BIN} -o=json -I0 "${file}" > "${MOD_ROOT}/${translated_mod_file}"
        COMMENT "Translating mod file: ${mod_file}"
      )
    else()
      # Create the copy target
      add_custom_command(
        OUTPUT "${MOD_ROOT}/${mod_file}"
        DEPENDS "${file}"
        COMMAND mkdir -p "${MOD_ROOT}/${parent_dir}"
        COMMAND cp "${file}" "${MOD_ROOT}/${mod_file}"
        COMMENT "Copying mod file: ${mod_file}"
      )
    endif()
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

  # Find the info file
  if(EXISTS "${_ADD_MOD_MOD_ROOT}/info.yaml")
    set(_ADD_MOD_INFO_FILE "${_ADD_MOD_MOD_ROOT}/info.yaml")
    set(_ADD_MOD_INFO_IS_YAML TRUE)
  elseif(EXISTS "${_ADD_MOD_MOD_ROOT}/info.json")
    set(_ADD_MOD_INFO_FILE "${_ADD_MOD_MOD_ROOT}/info.json")
    set(_ADD_MOD_INFO_IS_YAML FALSE)
  else()
    message(FATAL_ERROR "mod info file not found")
  endif()
  # Parse info for metadata
  if(_ADD_MOD_INFO_IS_YAML)
    parse_json(${YQ_BIN} ${_ADD_MOD_INFO_FILE} ".name" MOD_NAME)
    parse_json(${YQ_BIN} ${_ADD_MOD_INFO_FILE} ".version" MOD_VERSION)
  else()
    find_program(JQ_BIN NAMES jq REQUIRED)
    parse_json(${JQ_BIN} ${_ADD_MOD_INFO_FILE} ".name" MOD_NAME)
    parse_json(${JQ_BIN} ${_ADD_MOD_INFO_FILE} ".version" MOD_VERSION)
  endif()
  list(APPEND CMAKE_CONFIGURE_DEPENDS "${_ADD_MOD_INFO_FILE}")

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
    COMMENT "Compressing ${MOD_NAME}_${MOD_VERSION}.zip"
    COMMAND_EXPAND_LISTS
  )
  # Add this target to all
  add_custom_target("${_ADD_MOD_NAME}" ALL DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/${MOD_NAME}_${MOD_VERSION}.zip")
  # Add clean rule
  set_target_properties("${_ADD_MOD_NAME}" PROPERTIES ADDITIONAL_CLEAN_FILES "${CMAKE_CURRENT_BINARY_DIR}/worktree/${_ADD_MOD_NAME}")
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