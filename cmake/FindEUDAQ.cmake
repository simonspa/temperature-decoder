# - Try to find the EUDAQ2 framework
# Once done this will define
#  EUDAQ2_FOUND - System has EUDAQ2
#  EUDAQ2_INCLUDE_DIR - The EUDAQ2 main include directories
#  EUDAQ2_LIBRARY - The libraries needed to use EUDAQ2

MESSAGE(STATUS "Looking for EUDAQ2...")

FIND_PATH(EUDAQ2_INCLUDE_DIR NAMES "eudaq/FileReader.hh" PATHS "$ENV{EUDAQ2PATH}/include")
MESSAGE(STATUS "FileReader.hh => ${EUDAQ2_INCLUDE_DIR}")
IF(EUDAQ2_INCLUDE_DIR)
   SET(EUDAQ2_INC_FOUND TRUE)
   MESSAGE(STATUS "Found EUDAQ2 headers: ${EUDAQ2_INCLUDE_DIR}")
ENDIF()

FIND_LIBRARY(EUDAQ2_LIBRARY NAMES "libeudaq_core.so" HINTS "$ENV{EUDAQ2PATH}/lib")
MESSAGE(STATUS "libeudaq_core.so => ${EUDAQ2_LIBRARY}")
IF(EUDAQ2_LIBRARY)
   SET(EUDAQ2_LIB_FOUND TRUE)
   MESSAGE(STATUS "Found EUDAQ2 library: ${EUDAQ2_LIBRARY} ")

   GET_FILENAME_COMPONENT(EUDAQ2_LIB_PATH ${EUDAQ2_LIBRARY} DIRECTORY)
   MESSAGE(STATUS "EUDAQ2_LIB_PATH = ${EUDAQ2_LIB_PATH}")

   FILE(GLOB EUDAQ2_LIBRARY "${EUDAQ2_LIB_PATH}/*.so")
   MESSAGE(STATUS "EUDAQ2_LIBRARY list = ${EUDAQ2_LIBRARY}")
ENDIF()

IF(EUDAQ2_LIB_FOUND AND EUDAQ2_INC_FOUND)
   SET(EUDAQ2_FOUND TRUE)
ENDIF()

#mark_as_advanced(EUDAQ2_LIBRARY EUDAQ2_INCLUDE_DIR)
mark_as_advanced(EUDAQ2_LIBRARY EUDAQ2_INCLUDE_DIR)
