#-----------------------------------------------------------------------------
# Load some macros.
SET(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../CMakeModules;${CMAKE_MODULE_PATH}")

FIND_PACKAGE(Thrift REQUIRED)

PROJECT(talkServer CXX C)

FILE(GLOB SRC *.cpp *.h ../thrift/*.h ../thrift/*.cpp )

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../ )
include_directories(${THRIFT_INCLUDE_DIR} )

ADD_EXECUTABLE(talkServer WIN32 ${SRC} )
TARGET_LINK_LIBRARIES(talkServer ${THRIFT_LIBS}  )
