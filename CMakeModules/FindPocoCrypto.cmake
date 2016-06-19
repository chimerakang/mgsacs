IF(POCO_CRYPTO_INCLUDE_DIR AND POCO_CRYPTO_LIB )
   SET(POCO_CRYPTO_FOUND TRUE)
   
ELSE(POCO_CRYPTO_INCLUDE_DIR AND POCO_CRYPTO_LIB )
  
  IF(WITH_POCO_CRYPTO )
    FIND_PATH(POCO_CRYPTO_INCLUDE_DIR 
      NAMES
        Poco/Crypto/Crypto.h
      PATHS
        ../../../poco-1.4.6-all/Crypto/include/
    ) 
        
    IF(WIN32)                                                             
      FIND_LIBRARY(POCO_CRYPTO_LIB_RELEASE 
        NAMES 
          PocoCrypto
        PATHS
          ${POCO_LIB_DIRECTORY}
        )
        
      FIND_LIBRARY(POCO_CRYPTO_LIB_DEBUG 
        NAMES 
          PocoCryptod
        PATHS
          ${POCO_LIB_DIRECTORY}
      )
      
    ELSE(WIN32) 
      FIND_LIBRARY( POCO_CRYPTO_LIB_RELEASE 
        NAMES
          PocoCrypto   
        PATHS
	  	  ${POCO_LIB_DIRECTORY}
          /usr/lib
          /usr/local/lib
      )   
  
      FIND_LIBRARY( POCO_CRYPTO_LIB_DEBUG
        NAMES
          PocoCrypto
        PATHS
	  	  ${POCO_LIB_DIRECTORY}
          /usr/lib
          /usr/local/lib
      ) 
      
    ENDIF(WIN32)  
  
    IF(POCO_CRYPTO_INCLUDE_DIR)
      IF(POCO_CRYPTO_LIB_RELEASE)
        SET(POCO_CRYPTO_LIB "optimized;${POCO_CRYPTO_LIB_RELEASE}")
        IF(POCO_CRYPTO_LIB_DEBUG)
          SET(POCO_CRYPTO_LIB "${POCO_CRYPTO_LIB};debug;${POCO_CRYPTO_LIB_DEBUG}")
        ENDIF(POCO_CRYPTO_LIB_DEBUG)
      ENDIF(POCO_CRYPTO_LIB_RELEASE)
    ENDIF(POCO_CRYPTO_INCLUDE_DIR)
  
    IF(POCO_CRYPTO_INCLUDE_DIR AND POCO_CRYPTO_LIB)
      SET(POCO_CRYPTO_FOUND TRUE)
      MESSAGE(STATUS "Found Poco CRYPTOLib: ${POCO_CRYPTO_INCLUDE_DIR}, ${POCO_CRYPTO_LIB}")
    ELSE(POCO_CRYPTO_INCLUDE_DIR AND POCO_CRYPTO_LIB)
      SET(POCO_CRYPTO_FOUND FALSE)
      MESSAGE(STATUS "Poco CRYPTOLib not found.")
    ENDIF(POCO_CRYPTO_INCLUDE_DIR AND POCO_CRYPTO_LIB)
  
    MARK_AS_ADVANCED(POCO_CRYPTO_LIB_RELEASE POCO_CRYPTO_LIB_DEBUG)
    
      
  ENDIF(WITH_POCO_CRYPTO)

ENDIF(POCO_CRYPTO_INCLUDE_DIR AND POCO_CRYPTO_LIB )