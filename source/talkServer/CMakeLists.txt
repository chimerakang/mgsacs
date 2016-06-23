#-----------------------------------------------------------------------------
# Load some macros.
SET(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../CMakeModules;${CMAKE_MODULE_PATH}")

set(
    talker_skeleton_sources
    "${CMAKE_CURRENT_SOURCE_DIR}../thrift/gen-cpp/talkClient_server.skeleton.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}../thrift/gen-cpp/talkServer_server.skeleton.cpp"
)

add_custom_command(
  OUTPUT test.out

  COMMAND rm -f ${talker_skeleton_sources}
)

FIND_PACKAGE(Thrift REQUIRED)
FIND_PACKAGE(Boost REQUIRED)

PROJECT(talkServer CXX C)

FILE(GLOB SRC *.cpp *.h ../thrift/gen-cpp/*.h ../thrift/gen-cpp/*.cpp )

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../ )
include_directories(${THRIFT_INCLUDE_DIR} )

ADD_EXECUTABLE(talkServer WIN32 ${SRC} )
TARGET_LINK_LIBRARIES(talkServer ${THRIFT_LIBS} ${BOOST_LIBS} )
