# - Try to find BOOST
# Once done this will define
#
#  BOOST_FOUND - system has BOOST
#  BOOST_INCLUDE_DIRS - the BOOST include directory
#  BOOST_LIBRARIES - Link these to use BOOST
#  BOOST_DEFINITIONS - Compiler switches required for using BOOST
#
#  Copyright (c) 2006 Chimera Kang <chimerakang@gmail.com>
#
# Redistribution and use is allowed according to the terms of the New BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#
IF(BOOST_LIBS AND BOOST_INCLUDE_DIR)
  # in cache already
  set(BOOST_FOUND TRUE)
ELSE( BOOST_LIBS AND BOOST_INCLUDE_DIR)
  # use pkg-config to get the directories and then use these values
  # in the FIND_PATH() and FIND_LIB() calls

  IF(WIN32 AND MSVC)
    SET(_BOOSTLinkDir $ENV{SystemDrive}/BOOST-Win32/lib )

    find_path(BOOST_INCLUDE_DIR
      NAMES
        MONGO/MONGO.h
      PATHS
        $ENV{ProgramFiles}/BOOST-Win32/include
        $ENV{SystemDrive}/BOOST-Win32/include
    )

    find_library(BOOST_LIB
      NAMES
        BOOST
      PATHS
        ${_BOOSTLinkDir}
    )

  ELSE(WIN32 AND MSVC)
    find_path(BOOST_INCLUDE_DIR
      NAMES
        asio.hpp
      PATHS
		/usr/local/include/boost
    )


	find_library( BOOST_SYSTEM_LIB
		NAMES
        	boost_system
        PATHS
        	/usr/lib
        	/usr/lib64
        	/usr/local/lib
    )

	find_library( BOOST_THREAD_LIB
		NAMES
        	boost_thread-mt
        PATHS
        	/usr/lib
        	/usr/lib64
        	/usr/local/lib
    )

	find_library( BOOST_FILESYSTEM_LIB
		NAMES
        	boost_filesystem
        PATHS
        	/usr/lib
        	/usr/lib64
        	/usr/local/lib
    )

	find_library( BOOST_REGEX_LIB
		NAMES
    		boost_regex
        PATHS
        	/usr/lib
        	/usr/lib64
        	/usr/local/lib
    )

  ENDIF(WIN32 AND MSVC)

  if( WIN32 )
    set(BOOST_LIBS
      ${BOOST_SYSTEM_LIB}
      ${BOOST_THREAD_LIB}
      ${BOOST_FILESYSTEM_LIB}
      ${BOOST_REGEX_LIB} )
  else( WIN32 )

    set(BOOST_LIBS
      ${BOOST_SYSTEM_LIB}
      ${BOOST_THREAD_LIB}
	  ${BOOST_FILESYSTEM_LIB}
	  ${BOOST_REGEX_LIB} )
  endif( WIN32 )


  if (BOOST_INCLUDE_DIR AND BOOST_LIBS)
     set(BOOST_FOUND TRUE)
  endif (BOOST_INCLUDE_DIR AND BOOST_LIBS)

  if (BOOST_FOUND)
    if (NOT BOOST_FIND_QUIETLY)
      message(STATUS "Found BOOST: ${BOOST_LIBS}")
    endif (NOT BOOST_FIND_QUIETLY)
  else (BOOST_FOUND)
    if (BOOST_FIND_REQUIRED)
      message(FATAL_ERROR "Could not find BOOST")
    endif (BOOST_FIND_REQUIRED)
  endif (BOOST_FOUND)

ENDIF (BOOST_LIBS AND BOOST_INCLUDE_DIR)
