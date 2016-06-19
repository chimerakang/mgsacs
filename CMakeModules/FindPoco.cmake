IF(POCO_INCLUDE_DIR AND POCO_LIBRARIES)
   SET(POCO_FOUND TRUE)

ELSE(POCO_INCLUDE_DIR AND POCO_LIBRARIES)
  FIND_PATH(POCO_INCLUDE_DIR 
    NAMES
      Foundation.h 
      Util.h
      XML.h
      Net.h
      Data.h
      MySQL.h
    PATHS
      "../../../poco-1.4.6-all/Util/include/"
      "../../poco-1.4.6-all/XML/include/"
      "../../poco-1.4.6-all/Net/include/"
      "../../poco-1.4.6-all/Data/include/"
      "../../poco-1.4.6-all/Data/MySQL/include/"
      "../../../poco-1.4.6-all/Foundation/include/Poco/"
      "../../../poco-1.4.6-all/Util/include/Poco/"
      "../../poco-1.4.6-all/XML/include/Poco/"
      "../../poco-1.4.6-all/Net/include/Poco/"
      "../../poco-1.4.6-all/Data/include/Poco/"
      "../../poco-1.4.6-all/Data/MySQL/include/Poco/"
      "../../poco-1.4.6-all/Foundation/include/"
  )
      
  
  SET(POCO_LIB_DIRECTORY "../../../poco-1.4.6-all/lib")

  
  IF(WIN32 AND MSVC)                                                             
    FIND_LIBRARY(POCO_LIBRARY_RELEASE 
      NAMES 
        PocoFoundation
        PocoUtil
        PocoXML
        PocoNet
        PocoData
        PocoDataMySQL
      PATHS
        $(POCO_LIB_DIRECTORY)
      )
      
    FIND_LIBRARY(POCO_LIBRARY_DEBUG 
      NAMES 
        PocoFoundationd
        PocoUtild
        PocoXMLd
        PocoNetd
        PocoDatad
        PocoDataMySQLd
      PATHS
        $(POCO_LIB_DIRECTORY)
    )
    
  ELSE(WIN32 AND MSVC) 
    FIND_LIBRARY( POCO_LIBRARY_RELEASE 
      NAMES
        PocoFoundation
        PocoUtil
        PocoXML
        PocoNet
        PocoData
        PocoDataMySQL
  
      PATHS
        /usr/lib
        /usr/local/lib
    )   

    FIND_LIBRARY( POCO_LIBRARY_DEBUG
      NAMES
        PocoFoundationd
        PocoUtild
        PocoXMLd
        PocoNetd
        PocoDatad
        PocoDataMySQLd
  
      PATHS
        /usr/lib
        /usr/local/lib
    ) 
    
  ENDIF(WIN32 AND MSVC)  

  IF(POCO_INCLUDE_DIR)
    IF(POCO_LIBRARY_RELEASE)
      SET(POCO_LIBRARIES "optimized;${POCO_LIBRARY_RELEASE}")
      IF(POCO_LIBRARY_DEBUG)
        SET(POCO_LIBRARIES "${POCO_LIBRARIES};debug;${POCO_LIBRARY_DEBUG}")
      ENDIF(POCO_LIBRARY_DEBUG)
    ENDIF(POCO_LIBRARY_RELEASE)
  ENDIF(POCO_INCLUDE_DIR)

  IF(POCO_INCLUDE_DIR AND POCO_LIBRARIES)
    SET(POCO_FOUND TRUE)
    MESSAGE(STATUS "Found Poco Lib: ${POCO_INCLUDE_DIR}, ${POCO_LIBRARIES}")
  ELSE(POCO_INCLUDE_DIR AND POCO_LIBRARIES)
    SET(POCO_FOUND FALSE)
    MESSAGE(STATUS "Poco Lib not found.")
  ENDIF(POCO_INCLUDE_DIR AND POCO_LIBRARIES)

  MARK_AS_ADVANCED(POCO_LIBRARY_RELEASE POCO_LIBRARY_DEBUG)

ENDIF(POCO_INCLUDE_DIR AND POCO_LIBRARIES)
          