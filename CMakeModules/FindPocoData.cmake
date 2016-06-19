IF(POCO_DATA_INCLUDE_DIR AND POCO_DATA_LIB )
   SET(POCO_DATA_FOUND TRUE)
   
ELSE(POCO_DATA_INCLUDE_DIR AND POCO_DATA_LIB )
  
  IF(WITH_POCO_DATA )
    FIND_PATH(POCO_DATA_INCLUDE_DIR 
      NAMES
        Poco/Data/Data.h
      PATHS
        ../../../poco-1.4.6-all/Data/include/
    ) 
        
    IF(WIN32)                                                             
      FIND_LIBRARY(POCO_DATA_LIB_RELEASE 
        NAMES 
          PocoData
        PATHS
          ${POCO_LIB_DIRECTORY}
        )
        
      FIND_LIBRARY(POCO_DATA_LIB_DEBUG 
        NAMES 
          PocoDatad
        PATHS
          ${POCO_LIB_DIRECTORY}
      )
      
    ELSE(WIN32) 
      FIND_LIBRARY( POCO_DATA_LIB_RELEASE 
        NAMES
          PocoData 
        PATHS
          /usr/lib
          /usr/local/lib
          ${POCO_LIB_DIRECTORY}
      )   
  
      FIND_LIBRARY( POCO_DATA_LIB_DEBUG
        NAMES
          PocoDatad
        PATHS
          /usr/lib
          /usr/local/lib
          ${POCO_LIB_DIRECTORY}
      ) 
      
    ENDIF(WIN32)  
  
    IF(POCO_DATA_INCLUDE_DIR)
      IF(POCO_DATA_LIB_RELEASE)
        SET(POCO_DATA_LIB "optimized;${POCO_DATA_LIB_RELEASE}")
        IF(POCO_DATA_LIB_DEBUG)
          SET(POCO_DATA_LIB "${POCO_DATA_LIB};debug;${POCO_DATA_LIB_DEBUG}")
        ENDIF(POCO_DATA_LIB_DEBUG)
      ENDIF(POCO_DATA_LIB_RELEASE)
    ENDIF(POCO_DATA_INCLUDE_DIR)
  
    IF(POCO_DATA_INCLUDE_DIR AND POCO_DATA_LIB)
      SET(POCO_DATA_FOUND TRUE)
      MESSAGE(STATUS "Found Poco DATALib: ${POCO_DATA_INCLUDE_DIR}, ${POCO_DATA_LIB}")
    ELSE(POCO_DATA_INCLUDE_DIR AND POCO_DATA_LIB)
      SET(POCO_DATA_FOUND FALSE)
      MESSAGE(STATUS "Poco DATALib not found.")
    ENDIF(POCO_DATA_INCLUDE_DIR AND POCO_DATA_LIB)
  
    MARK_AS_ADVANCED(POCO_DATA_LIB_RELEASE POCO_DATA_LIB_DEBUG)
    
      
  ENDIF(WITH_POCO_DATA)

ENDIF(POCO_DATA_INCLUDE_DIR AND POCO_DATA_LIB )