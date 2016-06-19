IF(POCO_MYSQL_INCLUDE_DIR AND POCO_MYSQL_LIB )
   SET(POCO_MYSQL_FOUND TRUE)
   
ELSE(POCO_MYSQL_INCLUDE_DIR AND POCO_MYSQL_LIB )
  
  IF(WITH_POCO_MYSQL )
    FIND_PATH(POCO_MYSQL_INCLUDE_DIR 
      NAMES
        Poco/Data/MySQL/MySQL.h
      PATHS
        ../../../poco-1.4.6-all/Data/MySQL/include/
    ) 
        
    IF(WIN32)                                                             
      FIND_LIBRARY(POCO_MYSQL_LIB_RELEASE 
        NAMES 
          PocoDataMySQL
        PATHS
          ${POCO_LIB_DIRECTORY}
        )
        
      FIND_LIBRARY(POCO_MYSQL_LIB_DEBUG 
        NAMES 
          PocoDataMySQLd
        PATHS
          ${POCO_LIB_DIRECTORY}
      )
      
    ELSE(WIN32) 
      FIND_LIBRARY( POCO_MYSQL_LIB_RELEASE 
        NAMES
          PocoDataMySQL 
        PATHS
          /usr/lib
          /usr/local/lib
          ${POCO_LIB_DIRECTORY}
      )   
  
      FIND_LIBRARY( POCO_MYSQL_LIB_DEBUG
        NAMES
          PocoDataMySQLd
        PATHS
          /usr/lib
          /usr/local/lib
          ${POCO_LIB_DIRECTORY}
      ) 
      
    ENDIF(WIN32)  
  
    IF(POCO_MYSQL_INCLUDE_DIR)
      IF(POCO_MYSQL_LIB_RELEASE)
        SET(POCO_MYSQL_LIB "optimized;${POCO_MYSQL_LIB_RELEASE}")
        IF(POCO_MYSQL_LIB_DEBUG)
          SET(POCO_MYSQL_LIB "${POCO_MYSQL_LIB};debug;${POCO_MYSQL_LIB_DEBUG}")
        ENDIF(POCO_MYSQL_LIB_DEBUG)
      ENDIF(POCO_MYSQL_LIB_RELEASE)
    ENDIF(POCO_MYSQL_INCLUDE_DIR)
  
    IF(POCO_MYSQL_INCLUDE_DIR AND POCO_MYSQL_LIB)
      SET(POCO_MYSQL_FOUND TRUE)
      MESSAGE(STATUS "Found Poco MySQLLib: ${POCO_MYSQL_INCLUDE_DIR}, ${POCO_MYSQL_LIB}")
    ELSE(POCO_MYSQL_INCLUDE_DIR AND POCO_MYSQL_LIB)
      SET(POCO_MYSQL_FOUND FALSE)
      MESSAGE(STATUS "Poco MySQLLib not found.")
    ENDIF(POCO_MYSQL_INCLUDE_DIR AND POCO_MYSQL_LIB)
  
    MARK_AS_ADVANCED(POCO_MYSQL_LIB_RELEASE POCO_MYSQL_LIB_DEBUG)
    
      
  ENDIF(WITH_POCO_MYSQL)

ENDIF(POCO_MYSQL_INCLUDE_DIR AND POCO_MYSQL_LIB )