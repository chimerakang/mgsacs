IF(POCO_UTIL_INCLUDE_DIR AND POCO_UTIL_LIB )
   SET(POCO_UTIL_FOUND TRUE)
   
ELSE(POCO_UTIL_INCLUDE_DIR AND POCO_UTIL_LIB )
    
  IF(WITH_POCO_UTIL )
    FIND_PATH(POCO_UTIL_INCLUDE_DIR 
      NAMES
        Poco/Util/Util.h
      PATHS
        ../../../poco-1.4.6-all/Util/include
    ) 
    
    
    IF(WIN32)                                                             
      FIND_LIBRARY(POCO_UTIL_LIB_RELEASE 
        NAMES 
          PocoUtil
        PATHS
          ${POCO_LIB_DIRECTORY}
      )
        
      FIND_LIBRARY(POCO_UTIL_LIB_DEBUG 
        NAMES 
          PocoUtild
        PATHS
          ${POCO_LIB_DIRECTORY}
      )
      
      
    ELSE(WIN32) 
      FIND_LIBRARY( POCO_UTIL_LIB_RELEASE 
        NAMES
          PocoUtil 
        PATHS
          /usr/lib
          /usr/local/lib
          ${POCO_LIB_DIRECTORY}
          
      )   
  
      FIND_LIBRARY( POCO_UTIL_LIB_DEBUG
        NAMES
          PocoUtild
        PATHS
          /usr/lib
          /usr/local/lib
          ${POCO_LIB_DIRECTORY}
      ) 
      
    ENDIF(WIN32)  
  
    IF(POCO_UTIL_INCLUDE_DIR)
     
      IF(POCO_UTIL_LIB_RELEASE)
        SET(POCO_UTIL_LIB "optimized;${POCO_UTIL_LIB_RELEASE}")
        IF(POCO_UTIL_LIB_DEBUG)
          SET(POCO_UTIL_LIB "${POCO_UTIL_LIB};debug;${POCO_UTIL_LIB_DEBUG}")
        ENDIF(POCO_UTIL_LIB_DEBUG)
      ENDIF(POCO_UTIL_LIB_RELEASE)
    ENDIF(POCO_UTIL_INCLUDE_DIR)
  
    IF(POCO_UTIL_INCLUDE_DIR AND POCO_UTIL_LIB)
      SET(POCO_UTIL_FOUND TRUE)
      MESSAGE(STATUS "Found Poco UtilLib: ${POCO_UTIL_INCLUDE_DIR}, ${POCO_UTIL_LIB}")
    ELSE(POCO_UTIL_INCLUDE_DIR AND POCO_UTIL_LIB)
      SET(POCO_UTIL_FOUND FALSE)
      MESSAGE(STATUS "Poco UtilLib not found.")
    ENDIF(POCO_UTIL_INCLUDE_DIR AND POCO_UTIL_LIB)
  
    MARK_AS_ADVANCED(POCO_UTIL_LIB_RELEASE POCO_UTIL_LIB_DEBUG)
    
      
  ENDIF(WITH_POCO_UTIL)

ENDIF(POCO_UTIL_INCLUDE_DIR AND POCO_UTIL_LIB )