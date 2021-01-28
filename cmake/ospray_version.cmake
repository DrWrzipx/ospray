## Copyright 2009-2020 Intel Corporation
## SPDX-License-Identifier: Apache-2.0

set(OSPRAY_VERSION_MAJOR 2)
set(OSPRAY_VERSION_MINOR 5)
set(OSPRAY_VERSION_PATCH 0)
set(OSPRAY_SOVERSION 2)
set(OSPRAY_VERSION_GITHASH 0)
set(OSPRAY_VERSION_NOTE "")

if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/.git AND
   IS_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/.git)
  find_package(Git)
  if (GIT_FOUND)
    execute_process(
      COMMAND ${GIT_EXECUTABLE} rev-parse HEAD
      WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
      OUTPUT_VARIABLE "OSPRAY_VERSION_GITHASH"
      ERROR_QUIET
      OUTPUT_STRIP_TRAILING_WHITESPACE)
    string(SUBSTRING ${OSPRAY_VERSION_GITHASH} 0 8 OSPRAY_VERSION_GITHASH_SHORT)
    execute_process(
      COMMAND ${GIT_EXECUTABLE} rev-parse --abbrev-ref HEAD
      WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
      OUTPUT_VARIABLE "OSPRAY_VERSION_GITBRANCH"
      ERROR_QUIET
      OUTPUT_STRIP_TRAILING_WHITESPACE)
    if (NOT OSPRAY_VERSION_GITBRANCH MATCHES "^master$|^release-")
      if (NOT OSPRAY_VERSION_GITBRANCH STREQUAL "HEAD")
        set(OSPRAY_VERSION_NOTE "-${OSPRAY_VERSION_GITBRANCH}")
      endif()
      set(OSPRAY_VERSION_NOTE "${OSPRAY_VERSION_NOTE} (${OSPRAY_VERSION_GITHASH_SHORT})")
    endif()
  endif()
endif()

set(OSPRAY_VERSION
  ${OSPRAY_VERSION_MAJOR}.${OSPRAY_VERSION_MINOR}.${OSPRAY_VERSION_PATCH}
)