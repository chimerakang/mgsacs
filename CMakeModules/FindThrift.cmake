# - Try to find Thrift
# Once done this will define
#
#  Thrift_FOUND - system has Thrift
#  Thrift_INCLUDE_DIRS - the Thrift include directory
#  Thrift_LIBRARIES - Link these to use Thrift
#  Thrift_DEFINITIONS - Compiler switches required for using Thrift
#
#  Copyright (c) 2006 Andreas Schneider <mail@cynapses.org>
#
# Redistribution and use is allowed according to the terms of the New BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#
IF(THRIFT_LIBS AND THRIFT_INCLUDE_DIR)
  # in cache already
  set(THRIFT_FOUND TRUE)
ELSE( THRIFT_LIBS AND THRIFT_INCLUDE_DIR)
  # use pkg-config to get the directories and then use these values
  # in the FIND_PATH() and FIND_LIB() calls

  IF(WIN32 AND MSVC)
    SET(_ThriftLinkDir $ENV{SystemDrive}/Thrift-Win32/lib )

    find_path(THRIFT_INCLUDE_DIR
      NAMES
        thrift/Thrift.h
      PATHS
        $ENV{ProgramFiles}/Thrift-Win32/include
        $ENV{SystemDrive}/Thrift-Win32/include
    )

    find_library(THRIFT_LIB
      NAMES
        thrift
      PATHS
        ${_ThriftLinkDir}
    )

  ELSE(WIN32 AND MSVC)
    find_path(THRIFT_INCLUDE_DIR
      NAMES
        thrift/Thrift.h
      PATHS
        /usr/local/thrift/include
        /opt/local/thrift/include
    )

    find_library(THRIFT_LIB
      NAMES
        thrift
      PATHS
        ${_ThriftLinkDir}
        /usr/lib
        /usr/local/thrift/lib
        /opt/local/thrift/lib
    )

  ENDIF(WIN32 AND MSVC)

  set(THRIFT_LIBS
      ${THRIFT_LIB}
	  ${THRIFTNB_LIB}
	  ${EVENT_LIB} )


  if (THRIFT_INCLUDE_DIR AND THRIFT_LIBS )
     set(THRIFT_FOUND TRUE)
  endif (THRIFT_INCLUDE_DIR AND THRIFT_LIBS)

  if (THRIFT_FOUND)
    if (NOT THRIFT_FIND_QUIETLY)
      message(STATUS "Found Thrift: ${THRIFT_LIBS}")
    endif (NOT THRIFT_FIND_QUIETLY)
  else (THRIFT_FOUND)
    if (THRIFT_FIND_REQUIRED)
      message(FATAL_ERROR "Could not find Thrift")
    endif (THRIFT_FIND_REQUIRED)
  endif (THRIFT_FOUND)

ENDIF (THRIFT_LIBS AND THRIFT_INCLUDE_DIR)
