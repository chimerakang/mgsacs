#-----------------------------------------------------------------------------
# Load some macros.
SET(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../CMakeModules;${CMAKE_MODULE_PATH}")

FIND_PACKAGE(Thrift REQUIRED)

PROJECT(talkClient CXX C)

FILE(GLOB SRC *.cpp *.h ../thrift/*.h ../thrift/*.cpp )

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../ )
include_directories(${THRIFT_INCLUDE_DIR} )

ADD_EXECUTABLE(talkClient WIN32 ${SRC} )
TARGET_LINK_LIBRARIES(talkClient ${THRIFT_LIBS}  )
