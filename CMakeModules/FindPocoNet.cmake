IF(POCO_NET_INCLUDE_DIR AND POCO_NET_LIB )
   SET(POCO_NET_FOUND TRUE)
   
ELSE(POCO_NET_INCLUDE_DIR AND POCO_NET_LIB )
  
  IF(WITH_POCO_NET )
    FIND_PATH(POCO_NET_INCLUDE_DIR 
      NAMES
        Poco/Net/Net.h
      PATHS
        ../../../poco-1.4.6-all/Net/include/
    ) 
        
    IF(WIN32)                                                             
      FIND_LIBRARY(POCO_NET_LIB_RELEASE 
        NAMES 
          PocoNet
        PATHS
          ${POCO_LIB_DIRECTORY}
        )
        
      FIND_LIBRARY(POCO_NET_LIB_DEBUG 
        NAMES 
          PocoNetd
        PATHS
          ${POCO_LIB_DIRECTORY}
      )
      
    ELSE(WIN32) 
      FIND_LIBRARY( POCO_NET_LIB_RELEASE 
        NAMES
          PocoNet 
        PATHS
          ${POCO_LIB_DIRECTORY}
          /usr/lib
          /usr/local/lib
      )   
  
      FIND_LIBRARY( POCO_NET_LIB_DEBUG
        NAMES
          PocoNetd
        PATHS
          ${POCO_LIB_DIRECTORY}
          /usr/lib
          /usr/local/lib
      ) 
      
    ENDIF(WIN32)  
  
    IF(POCO_NET_INCLUDE_DIR)
      IF(POCO_NET_LIB_RELEASE)
        SET(POCO_NET_LIB "optimized;${POCO_NET_LIB_RELEASE}")
        IF(POCO_NET_LIB_DEBUG)
          SET(POCO_NET_LIB "${POCO_NET_LIB};debug;${POCO_NET_LIB_DEBUG}")
        ENDIF(POCO_NET_LIB_DEBUG)
      ENDIF(POCO_NET_LIB_RELEASE)
    ENDIF(POCO_NET_INCLUDE_DIR)
  
    IF(POCO_NET_INCLUDE_DIR AND POCO_NET_LIB)
      SET(POCO_NET_FOUND TRUE)
      MESSAGE(STATUS "Found Poco NETLib: ${POCO_NET_INCLUDE_DIR}, ${POCO_NET_LIB}")
    ELSE(POCO_NET_INCLUDE_DIR AND POCO_NET_LIB)
      SET(POCO_NET_FOUND FALSE)
      MESSAGE(STATUS "Poco NETLib not found.")
    ENDIF(POCO_NET_INCLUDE_DIR AND POCO_NET_LIB)
  
    MARK_AS_ADVANCED(POCO_NET_LIB_RELEASE POCO_NET_LIB_DEBUG)
    
      
  ENDIF(WITH_POCO_NET)

ENDIF(POCO_NET_INCLUDE_DIR AND POCO_NET_LIB )