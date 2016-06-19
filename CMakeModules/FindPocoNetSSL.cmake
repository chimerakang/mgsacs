IF(POCO_NETSSL_INCLUDE_DIR AND POCO_NETSSL_LIB )
   SET(POCO_NETSSL_FOUND TRUE)
   
ELSE(POCO_NETSSL_INCLUDE_DIR AND POCO_NETSSL_LIB )
  
  IF(WITH_POCO_NETSSL )
    FIND_PATH(POCO_NETSSL_INCLUDE_DIR 
      NAMES
        Poco/Net/NetSSL.h
      PATHS
        ../../../poco-1.4.6-all/NetSSL_OpenSSL/include/
    ) 
        
    IF(WIN32)                                                             
      FIND_LIBRARY(POCO_NETSSL_LIB_RELEASE 
        NAMES 
          PocoNetSSL
        PATHS
          ${POCO_LIB_DIRECTORY}
        )
        
      FIND_LIBRARY(POCO_NETSSL_LIB_DEBUG 
        NAMES 
          PocoNetSSLd
        PATHS
          ${POCO_LIB_DIRECTORY}
      )
      
    ELSE(WIN32) 
      FIND_LIBRARY( POCO_NETSSL_LIB_RELEASE 
        NAMES
          PocoNetSSL   
        PATHS
	  	  ${POCO_LIB_DIRECTORY}
          /usr/lib
          /usr/local/lib
      )   
  
      FIND_LIBRARY( POCO_NETSSL_LIB_DEBUG
        NAMES
          PocoNetSSLd
        PATHS
	  	  ${POCO_LIB_DIRECTORY}
          /usr/lib
          /usr/local/lib
      ) 
      
    ENDIF(WIN32)  
  
    IF(POCO_NETSSL_INCLUDE_DIR)
      IF(POCO_NETSSL_LIB_RELEASE)
        SET(POCO_NETSSL_LIB "optimized;${POCO_NETSSL_LIB_RELEASE}")
        IF(POCO_NETSSL_LIB_DEBUG)
          SET(POCO_NETSSL_LIB "${POCO_NETSSL_LIB};debug;${POCO_NETSSL_LIB_DEBUG}")
        ENDIF(POCO_NETSSL_LIB_DEBUG)
      ENDIF(POCO_NETSSL_LIB_RELEASE)
    ENDIF(POCO_NETSSL_INCLUDE_DIR)
  
    IF(POCO_NETSSL_INCLUDE_DIR AND POCO_NETSSL_LIB)
      SET(POCO_NETSSL_FOUND TRUE)
      MESSAGE(STATUS "Found Poco NETSSLLib: ${POCO_NETSSL_INCLUDE_DIR}, ${POCO_NETSSL_LIB}")
    ELSE(POCO_NETSSL_INCLUDE_DIR AND POCO_NETSSL_LIB)
      SET(POCO_NETSSL_FOUND FALSE)
      MESSAGE(STATUS "Poco NETSSLLib not found.")
    ENDIF(POCO_NETSSL_INCLUDE_DIR AND POCO_NETSSL_LIB)
  
    MARK_AS_ADVANCED(POCO_NETSSL_LIB_RELEASE POCO_NETSSL_LIB_DEBUG)
    
      
  ENDIF(WITH_POCO_NETSSL)

ENDIF(POCO_NETSSL_INCLUDE_DIR AND POCO_NETSSL_LIB )