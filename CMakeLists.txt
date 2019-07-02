########################################################
# CMake file for the pXar framework
CMAKE_MINIMUM_REQUIRED(VERSION 2.4 FATAL_ERROR)
IF(COMMAND CMAKE_POLICY)
  CMAKE_POLICY(SET CMP0003 NEW)
ENDIF(COMMAND CMAKE_POLICY)
########################################################

# Project name
PROJECT(eudecoder LANGUAGES CXX)

# Set standard build flags
SET(COMPILER_FLAGS -pedantic -Wall -Wextra -Wcast-align -Wcast-qual -Wconversion -Wuseless-cast -Wctor-dtor-privacy -Wzero-as-null-pointer-constant -Wdisabled-optimization -Wformat=2 -Winit-self -Wlogical-op -Wmissing-declarations -Wmissing-include-dirs -Wnoexcept -Wold-style-cast -Woverloaded-virtual -Wredundant-decls -Wsign-conversion -Wsign-promo -Wstrict-null-sentinel -Wswitch-default -Wundef -Werror -Wshadow -Wformat-security -Wdeprecated -fdiagnostics-color=auto -Wheader-hygiene)

# Require a C++14 compiler but do allow extensions
SET(CMAKE_CXX_STANDARD 14)
SET(CMAKE_CXX_STANDARD_REQUIRED ON)
SET(CMAKE_CXX_EXTENSIONS OFF)

# Set up the RPATH so executables find the libraries even when installed in non-default location
SET(CMAKE_MACOSX_RPATH TRUE)
SET(CMAKE_SKIP_BUILD_RPATH FALSE)
SET(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)

# Add the automatically determined parts of the RPATH which point to directories outside the build tree to the install RPATH
SET(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

# The RPATH to be used when installing, but only if it's not a system directory
LIST(FIND CMAKE_PLATFORM_IMPLICIT_LINK_DIRECTORIES "${CMAKE_INSTALL_PREFIX}/lib" IsSystemDir)
IF("${IsSystemDir}" STREQUAL "-1")
   SET(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")
ENDIF("${IsSystemDir}" STREQUAL "-1")


# Additional packages to be searched for by cmake
LIST( APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake )

SET(INSTALL_PREFIX "${PROJECT_SOURCE_DIR}" CACHE PATH "Prefix prepended to install directories")
SET(CMAKE_INSTALL_PREFIX "${INSTALL_PREFIX}" CACHE INTERNAL "Prefix prepended to install directories" FORCE)

SET(SOURCE_FILES
  "src/temp_decoder.cc"
)

# this UI and its libraries depend on ROOT:
FIND_PACKAGE(EUDAQ REQUIRED)
FIND_PACKAGE(ROOT REQUIRED)

INCLUDE_DIRECTORIES(SYSTEM ${EUDAQ2_INCLUDE_DIR} ${ROOT_INCLUDE_DIR})

ADD_EXECUTABLE(${PROJECT_NAME} ${SOURCE_FILES})
TARGET_LINK_LIBRARIES(${PROJECT_NAME} ${EUDAQ2_LIBRARY} ${ROOT_LIBRARIES} ${ROOT_COMPONENT_LIBRARIES} )

# set install location
INSTALL(TARGETS ${PROJECT_NAME} EXPORT eudecoder_install
    RUNTIME DESTINATION bin
    ARCHIVE DESTINATION lib)
