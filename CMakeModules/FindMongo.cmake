# - Try to find MONGO
# Once done this will define
#
#  MONGO_FOUND - system has MONGO
#  MONGO_INCLUDE_DIRS - the MONGO include directory
#  MONGO_LIBRARIES - Link these to use MONGO
#  MONGO_DEFINITIONS - Compiler switches required for using MONGO
#
#  Copyright (c) 2006 Andreas Schneider <mail@cynapses.org>
#
# Redistribution and use is allowed according to the terms of the New BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#
IF(MONGO_LIBS AND MONGO_INCLUDE_DIR)
  # in cache already
  set(MONGO_FOUND TRUE)
ELSE( MONGO_LIBS AND MONGO_INCLUDE_DIR)
  # use pkg-config to get the directories and then use these values
  # in the FIND_PATH() and FIND_LIB() calls

  IF(WIN32 AND MSVC)
    SET(_MONGOLinkDir $ENV{SystemDrive}/MONGO-Win32/lib )
  
    find_path(MONGO_INCLUDE_DIR
      NAMES
        MONGO/MONGO.h
      PATHS
        $ENV{ProgramFiles}/MONGO-Win32/include
        $ENV{SystemDrive}/MONGO-Win32/include
    )
  
    find_library(MONGO_LIB
      NAMES
        MONGO
      PATHS
        ${_MONGOLinkDir}
    )

  ELSE(WIN32 AND MSVC)
    find_path(MONGO_INCLUDE_DIR
      NAMES
        dbclient.h
      PATHS
        /usr/local/include/mongo/client
    )
  
    find_library(MONGOCLIENT_LIB
      NAMES
        mongoclient
      PATHS
        /usr/lib
        /usr/local/lib
    )

	find_library( BOOST_SYSTEM_LIB
		NAMES
        	boost_system
        PATHS
        	/usr/lib
        	/usr/local/lib
    )

	find_library( BOOST_THREAD_LIB
		NAMES
        	boost_thread
        PATHS
        	/usr/lib
        	/usr/local/lib
    )
        
	find_library( BOOST_FILESYSTEM_LIB
		NAMES
        	boost_filesystem
        PATHS
        	/usr/lib
        	/usr/local/lib
    )
    
  ENDIF(WIN32 AND MSVC)

  if( WIN32 )
    set(MONGO_LIBS
      ${MONGOCLIENT_LIB}
      ${BOOST_SYSTEM_LIB}
      ${BOOST_THREAD_LIB}
      ${BOOST_FILESYSTEM_LIB} )
  else( WIN32 )

    set(MONGO_LIBS
      ${MONGOCLIENT_LIB}
      ${BOOST_SYSTEM_LIB}
      ${BOOST_THREAD_LIB}
	  ${BOOST_FILESYSTEM_LIB} )
  endif( WIN32 )


  if (MONGO_INCLUDE_DIR AND MONGO_LIBS)
     set(MONGO_FOUND TRUE)
  endif (MONGO_INCLUDE_DIR AND MONGO_LIBS)

  if (MONGO_FOUND)
    if (NOT MONGO_FIND_QUIETLY)
      message(STATUS "Found Mongo: ${MONGO_LIBS}")
    endif (NOT MONGO_FIND_QUIETLY)
  else (MONGO_FOUND)
    if (MONGO_FIND_REQUIRED)
      message(FATAL_ERROR "Could not find Mongo")
    endif (MONGO_FIND_REQUIRED)
  endif (MONGO_FOUND)

ENDIF (MONGO_LIBS AND MONGO_INCLUDE_DIR)
