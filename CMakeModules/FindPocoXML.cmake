IF(POCO_XML_INCLUDE_DIR AND POCO_XML_LIB )
   SET(POCO_XML_FOUND TRUE)
   
ELSE(POCO_XML_INCLUDE_DIR AND POCO_XML_LIB )
  
  IF(WITH_POCO_XML )
    FIND_PATH(POCO_XML_INCLUDE_DIR 
      NAMES
        Poco/XML/XML.h
      PATHS
        ../../../poco-1.4.6-all/XML/include/
    ) 
        
    IF(WIN32)                                                             
      FIND_LIBRARY(POCO_XML_LIB_RELEASE 
        NAMES 
          PocoXML
        PATHS
          ${POCO_LIB_DIRECTORY}
        )
        
      FIND_LIBRARY(POCO_XML_LIB_DEBUG 
        NAMES 
          PocoXMLd
        PATHS
          ${POCO_LIB_DIRECTORY}
      )
      
    ELSE(WIN32) 
      FIND_LIBRARY( POCO_XML_LIB_RELEASE 
        NAMES
          PocoXML 
        PATHS
          /usr/lib
          /usr/local/lib
          ${POCO_LIB_DIRECTORY}
      )   
  
      FIND_LIBRARY( POCO_XML_LIB_DEBUG
        NAMES
          PocoXMLd
        PATHS
          /usr/lib
          /usr/local/lib
          ${POCO_LIB_DIRECTORY}
      ) 
      
    ENDIF(WIN32)  
  
    IF(POCO_XML_INCLUDE_DIR)
      IF(POCO_XML_LIB_RELEASE)
        SET(POCO_XML_LIB "optimized;${POCO_XML_LIB_RELEASE}")
        IF(POCO_XML_LIB_DEBUG)
          SET(POCO_XML_LIB "${POCO_XML_LIB};debug;${POCO_XML_LIB_DEBUG}")
        ENDIF(POCO_XML_LIB_DEBUG)
      ENDIF(POCO_XML_LIB_RELEASE)
    ENDIF(POCO_XML_INCLUDE_DIR)
  
    IF(POCO_XML_INCLUDE_DIR AND POCO_XML_LIB)
      SET(POCO_XML_FOUND TRUE)
      MESSAGE(STATUS "Found Poco XMLLib: ${POCO_XML_INCLUDE_DIR}, ${POCO_XML_LIB}")
    ELSE(POCO_XML_INCLUDE_DIR AND POCO_XML_LIB)
      SET(POCO_XML_FOUND FALSE)
      MESSAGE(STATUS "Poco XMLLib not found.")
    ENDIF(POCO_XML_INCLUDE_DIR AND POCO_XML_LIB)
  
    MARK_AS_ADVANCED(POCO_XML_LIB_RELEASE POCO_XML_LIB_DEBUG)
    
      
  ENDIF(WITH_POCO_XML)

ENDIF(POCO_XML_INCLUDE_DIR AND POCO_XML_LIB )