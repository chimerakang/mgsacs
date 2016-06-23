###
# Helper macro that generates .pc and installs it.
# Argument: name - the name of the .pc package, e.g. "nel-pacs.pc"
###
MACRO(KIWI_GEN_PC name)
  IF(NOT WIN32 AND WITH_INSTALL_LIBRARIES)
    CONFIGURE_FILE(${name}.in "${CMAKE_CURRENT_BINARY_DIR}/${name}")
    INSTALL(FILES "${CMAKE_CURRENT_BINARY_DIR}/bin" DESTINATION lib/pkgconfig)
  ENDIF(NOT WIN32 AND WITH_INSTALL_LIBRARIES)
ENDMACRO(KIWI_GEN_PC)

###
# Helper macro that generates revision.h from revision.h.in
###
MACRO(KIWI_GEN_REVISION_H)
  IF(EXISTS ${CMAKE_SOURCE_DIR}/revision.h.in)
    INCLUDE_DIRECTORIES(${CMAKE_BINARY_DIR})
    ADD_DEFINITIONS(-DHAVE_REVISION_H)
    SET(HAVE_REVISION_H ON)

    # a custom target that is always built
    ADD_CUSTOM_TARGET(revision ALL
      DEPENDS ${CMAKE_BINARY_DIR}/revision.h)

    # creates revision.h using cmake script
    ADD_CUSTOM_COMMAND(OUTPUT ${CMAKE_BINARY_DIR}/revision.h
      COMMAND ${CMAKE_COMMAND}
      -DSOURCE_DIR=${CMAKE_SOURCE_DIR}
      -DROOT_DIR=${CMAKE_SOURCE_DIR}/..
      -P ${CMAKE_SOURCE_DIR}/CMakeModules/GetRevision.cmake)

    # revision.h is a generated file
    SET_SOURCE_FILES_PROPERTIES(${CMAKE_BINARY_DIR}/revision.h
      PROPERTIES GENERATED TRUE
      HEADER_FILE_ONLY TRUE)
  ENDIF(EXISTS ${CMAKE_SOURCE_DIR}/revision.h.in)
ENDMACRO(KIWI_GEN_REVISION_H)

###
#
###
MACRO(KIWI_TARGET_LIB name)
  IF(WITH_STATIC)
    ADD_LIBRARY(${name} STATIC ${ARGN})
  ELSE(WITH_STATIC)
    ADD_LIBRARY(${name} SHARED ${ARGN})
  ENDIF(WITH_STATIC)
ENDMACRO(KIWI_TARGET_LIB)

###
# Helper macro that sets the default library properties.
# Argument: name - the target name whose properties are being set
# Argument:
###
MACRO(KIWI_DEFAULT_PROPS name label)
  IF(NOT MSVC10)
    SET_TARGET_PROPERTIES(${name} PROPERTIES PROJECT_LABEL ${label})
  ENDIF(NOT MSVC10)
  GET_TARGET_PROPERTY(type ${name} TYPE)
  IF(${type} STREQUAL SHARED_LIBRARY)
    # Set versions only if target is a shared library
    SET_TARGET_PROPERTIES(${name} PROPERTIES
      VERSION ${NL_VERSION} SOVERSION ${NL_VERSION_MAJOR})
    IF(NL_LIB_PREFIX)
      SET_TARGET_PROPERTIES(${name} PROPERTIES INSTALL_NAME_DIR ${NL_LIB_PREFIX})
    ENDIF(NL_LIB_PREFIX)
  ENDIF(${type} STREQUAL SHARED_LIBRARY)

  IF(${type} STREQUAL EXECUTABLE AND WIN32)
    SET_TARGET_PROPERTIES(${name} PROPERTIES
      VERSION ${NL_VERSION}
      SOVERSION ${NL_VERSION_MAJOR}
      COMPILE_FLAGS "/GA"
      LINK_FLAGS "/VERSION:${NL_VERSION}")
  ENDIF(${type} STREQUAL EXECUTABLE AND WIN32)

  IF(WITH_STLPORT AND WIN32)
    SET_TARGET_PROPERTIES(${name} PROPERTIES COMPILE_FLAGS "/X")
  ENDIF(WITH_STLPORT AND WIN32)
ENDMACRO(KIWI_DEFAULT_PROPS)

###
# Adds the target suffix on Windows.
# Argument: name - the library's target name.
###
MACRO(KIWI_ADD_LIB_SUFFIX name)
  IF(WIN32)
    SET_TARGET_PROPERTIES(${name} PROPERTIES DEBUG_POSTFIX "_d" RELEASE_POSTFIX "_r")
  ENDIF(WIN32)
ENDMACRO(KIWI_ADD_LIB_SUFFIX)

###
# Adds the runtime link flags for Win32 binaries and links STLport.
# Argument: name - the target to add the link flags to.
###
MACRO(KIWI_ADD_RUNTIME_FLAGS name)
  IF(WIN32)
#    SET_TARGET_PROPERTIES(${name} PROPERTIES
#      LINK_FLAGS_DEBUG "${CMAKE_LINK_FLAGS_DEBUG}"
#      LINK_FLAGS_RELEASE "${CMAKE_LINK_FLAGS_RELEASE}")
  ENDIF(WIN32)
  IF(WITH_STLPORT)
    TARGET_LINK_LIBRARIES(${name} ${STLPORT_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT})
  ENDIF(WITH_STLPORT)
ENDMACRO(KIWI_ADD_RUNTIME_FLAGS)

###
# Checks build vs. source location. Prevents In-Source builds.
###
MACRO(CHECK_OUT_OF_SOURCE)
  IF(${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_BINARY_DIR})
    MESSAGE(FATAL_ERROR "

CMake generation for this project is not allowed within the source directory!
Remove the CMakeCache.txt file and try again from another folder, e.g.:

   rm CMakeCache.txt
   mkdir cmake
   cd cmake
   cmake ..
    ")
  ENDIF(${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_BINARY_DIR})

ENDMACRO(CHECK_OUT_OF_SOURCE)

MACRO(KIWI_SETUP_DEFAULT_OPTIONS)
  ###
  # Features
  ###
  OPTION(WITH_LOGGING             "With Logging"                                  ON )
  OPTION(WITH_COVERAGE            "With Code Coverage Support"                    OFF)

  # Default to static building on Windows.
  IF(WIN32)
    OPTION(WITH_STATIC            "With static libraries."                        ON )
  ELSE(WIN32)
    OPTION(WITH_STATIC            "With static libraries."                        OFF)
  ENDIF(WIN32)
  OPTION(WITH_STATIC_DRIVERS      "With static drivers."                          OFF)
  IF(WIN32)
    OPTION(WITH_EXTERNAL          "With provided external."                       ON )
  ELSE(WIN32)
    OPTION(WITH_EXTERNAL          "With provided external."                       OFF)
  ENDIF(WIN32)
  OPTION(WITH_STATIC_EXTERNAL     "With static external libraries"                ON )
  OPTION(WITH_INSTALL_LIBRARIES   "Install development files."                    ON )

  ###
  # Poco support
  ###
  OPTION(WITH_POCO_LIB     	  	  "With Poco Lib."                      		  ON )
  OPTION(WITH_KIWI_SERVER         "Build Kiwi Server."                            ON )
ENDMACRO(KIWI_SETUP_DEFAULT_OPTIONS)

MACRO(KIWI_SETUP_BUILD)

  #-----------------------------------------------------------------------------
  # Setup the buildmode variables.
  #
  # None                  = KIWI_RELEASE
  # Debug                 = KIWI_DEBUG
  # Release               = KIWI_RELEASE

  SET(CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING "" FORCE)

  IF(CMAKE_BUILD_TYPE MATCHES "Debug")
    SET(KIWI_BUILD_MODE "KIWI_DEBUG")
  ELSE(CMAKE_BUILD_TYPE MATCHES "Debug")
    IF(CMAKE_BUILD_TYPE MATCHES "Release")
      SET(KIWI_BUILD_MODE "KIWI_RELEASE")
    ELSE(CMAKE_BUILD_TYPE MATCHES "Release")
      SET(KIWI_BUILD_MODE "KIWI_RELEASE")
      # enforce release mode if it's neither Debug nor Release
      SET(CMAKE_BUILD_TYPE "Release" CACHE STRING "" FORCE)
    ENDIF(CMAKE_BUILD_TYPE MATCHES "Release")
  ENDIF(CMAKE_BUILD_TYPE MATCHES "Debug")

  SET(HOST_CPU ${CMAKE_SYSTEM_PROCESSOR})

  IF(HOST_CPU MATCHES "amd64")
    SET(HOST_CPU "x86_64")
  ELSEIF(HOST_CPU MATCHES "i.86")
    SET(HOST_CPU "x86")
  ENDIF(HOST_CPU MATCHES "amd64")

  # Determine target CPU
  IF(NOT TARGET_CPU)
    SET(TARGET_CPU $ENV{DEB_HOST_GNU_CPU})
  ENDIF(NOT TARGET_CPU)

  # If not specified, use the same CPU as host
  IF(NOT TARGET_CPU)
    SET(TARGET_CPU ${CMAKE_SYSTEM_PROCESSOR})
  ENDIF(NOT TARGET_CPU)

  IF(TARGET_CPU MATCHES "amd64")
    SET(TARGET_CPU "x86_64")
  ELSEIF(TARGET_CPU MATCHES "i.86")
    SET(TARGET_CPU "x86")
  ENDIF(TARGET_CPU MATCHES "amd64")

  # DEB_HOST_ARCH_ENDIAN is 'little' or 'big'
  # DEB_HOST_ARCH_BITS is '32' or '64'

  # If target and host CPU are the same
  IF("${HOST_CPU}" STREQUAL "${TARGET_CPU}")
    # x86-compatible CPU
    IF(HOST_CPU MATCHES "x86")
      IF(NOT CMAKE_SIZEOF_VOID_P)
        INCLUDE (CheckTypeSize)
        CHECK_TYPE_SIZE("void*"  CMAKE_SIZEOF_VOID_P)
      ENDIF(NOT CMAKE_SIZEOF_VOID_P)

      # Using 32 or 64 bits libraries
      IF(CMAKE_SIZEOF_VOID_P EQUAL 8)
        SET(TARGET_CPU "x86_64")
      ELSE(CMAKE_SIZEOF_VOID_P EQUAL 8)
        SET(TARGET_CPU "x86")
      ENDIF(CMAKE_SIZEOF_VOID_P EQUAL 8)
    ENDIF(HOST_CPU MATCHES "x86")
    # TODO: add checks for ARM and PPC
  ELSE("${HOST_CPU}" STREQUAL "${TARGET_CPU}")
    MESSAGE(STATUS "Compiling on ${HOST_CPU} for ${TARGET_CPU}")
  ENDIF("${HOST_CPU}" STREQUAL "${TARGET_CPU}")

  IF(TARGET_CPU STREQUAL "x86_64")
    SET(TARGET_X64 1)
    SET(PLATFORM_CFLAGS "${PLATFORM_CFLAGS} -DHAVE_X86_64")
  ELSEIF(TARGET_CPU STREQUAL "x86")
    SET(TARGET_X86 1)
    SET(PLATFORM_CFLAGS "${PLATFORM_CFLAGS} -DHAVE_X86")
  ENDIF(TARGET_CPU STREQUAL "x86_64")

  # Fix library paths suffixes for Debian MultiArch
  IF(NOT CMAKE_LIBRARY_ARCHITECTURE)
    SET(CMAKE_LIBRARY_ARCHITECTURE $ENV{DEB_HOST_MULTIARCH})
  ENDIF(NOT CMAKE_LIBRARY_ARCHITECTURE)

  IF(CMAKE_LIBRARY_ARCHITECTURE)
    SET(CMAKE_LIBRARY_PATH "/lib/${CMAKE_LIBRARY_ARCHITECTURE};/usr/lib/${CMAKE_LIBRARY_ARCHITECTURE};${CMAKE_LIBRARY_PATH}")
  ENDIF(CMAKE_LIBRARY_ARCHITECTURE)

  IF(MSVC)
    IF(MSVC10)
      # /Ox is working with VC++ 2010, but custom optimizations don't exist
      SET(SPEED_OPTIMIZATIONS "/Ox /GF /GS-")
      # without inlining it's unusable, use custom optimizations again
      SET(MIN_OPTIMIZATIONS "/Od /Ob1")
    ELSEIF(MSVC90)
      # don't use a /O[012x] flag if you want custom optimizations
      SET(SPEED_OPTIMIZATIONS "/Ob2 /Oi /Ot /Oy /GT /GF /GS-")
      # without inlining it's unusable, use custom optimizations again
      SET(MIN_OPTIMIZATIONS "/Ob1")
    ELSEIF(MSVC80)
      # don't use a /O[012x] flag if you want custom optimizations
      SET(SPEED_OPTIMIZATIONS "/Ox /GF /GS-")
      # without inlining it's unusable, use custom optimizations again
      SET(MIN_OPTIMIZATIONS "/Od /Ob1")
    ELSE(MSVC10)
      MESSAGE(FATAL_ERROR "Can't determine compiler version ${MSVC_VERSION}")
    ENDIF(MSVC10)

    SET(PLATFORM_CFLAGS "${PLATFORM_CFLAGS} /D_CRT_SECURE_NO_WARNINGS /D_CRT_NONSTDC_NO_WARNINGS /DWIN32 /D_WINDOWS /W3 /Zi /Zm1000 /MP /Gy-")

    # Common link flags
    SET(PLATFORM_LINKFLAGS "-DEBUG")

    IF(TARGET_X64)
      # Fix a bug with Intellisense
      SET(PLATFORM_CFLAGS "${PLATFORM_CFLAGS} /D_WIN64")
      # Fix a compilation error for some big C++ files
      SET(MIN_OPTIMIZATIONS "${MIN_OPTIMIZATIONS} /bigobj")
    ELSE(TARGET_X64)
      # Allows 32 bits applications to use 3 GB of RAM
      SET(PLATFORM_LINKFLAGS "${PLATFORM_LINKFLAGS} /LARGEADDRESSAWARE")
    ENDIF(TARGET_X64)

    # Exceptions are only set for C++
    SET(PLATFORM_CXXFLAGS "${PLATFORM_CFLAGS} /EHa")

    SET(KIWI_DEBUG_CFLAGS "/MDd /RTC1 /D_DEBUG ${MIN_OPTIMIZATIONS}")
    SET(KIWI_RELEASE_CFLAGS "/MD /D NDEBUG ${SPEED_OPTIMIZATIONS}")
    SET(KIWI_DEBUG_LINKFLAGS "/NODEFAULTLIB:msvcrt /INCREMENTAL:YES")
    SET(KIWI_RELEASE_LINKFLAGS "/OPT:REF /OPT:ICF /INCREMENTAL:NO")
  ELSE(MSVC)
    IF(HOST_CPU STREQUAL "x86_64" AND TARGET_CPU STREQUAL "x86")
      SET(PLATFORM_CFLAGS "${PLATFORM_CFLAGS} -m32 -march=i686")
    ENDIF(HOST_CPU STREQUAL "x86_64" AND TARGET_CPU STREQUAL "x86")

    IF(HOST_CPU STREQUAL "x86" AND TARGET_CPU STREQUAL "x86_64")
      SET(PLATFORM_CFLAGS "${PLATFORM_CFLAGS} -m64")
    ENDIF(HOST_CPU STREQUAL "x86" AND TARGET_CPU STREQUAL "x86_64")

    SET(PLATFORM_CFLAGS "${PLATFORM_CFLAGS} -g -D_REENTRANT -pipe -ftemplate-depth-48 -Wall -ansi -W -Wpointer-arith -Wsign-compare -Wno-deprecated-declarations -Wno-multichar -Wno-unused -fno-strict-aliasing")

    IF(WITH_COVERAGE)
      SET(PLATFORM_CFLAGS "-fprofile-arcs -ftest-coverage ${PLATFORM_CFLAGS}")
    ENDIF(WITH_COVERAGE)

    IF(APPLE)
      SET(PLATFORM_CFLAGS "-gdwarf-2 ${PLATFORM_CFLAGS} -std=c++11 ")
    ENDIF(APPLE)


    # Fix "relocation R_X86_64_32 against.." error on x64 platforms
    IF(TARGET_X64 AND WITH_STATIC AND NOT WITH_STATIC_DRIVERS)
      SET(PLATFORM_CFLAGS "-fPIC ${PLATFORM_CFLAGS}")
    ENDIF(TARGET_X64 AND WITH_STATIC AND NOT WITH_STATIC_DRIVERS)

    SET(PLATFORM_CXXFLAGS ${PLATFORM_CFLAGS})

    IF(NOT APPLE)
      SET(PLATFORM_LINKFLAGS "${PLATFORM_LINKFLAGS} -Wl,--no-undefined -Wl,--as-needed")
    ENDIF(NOT APPLE)

    SET(KIWI_DEBUG_CFLAGS "-DKIWI_DEBUG -D_DEBUG")
    SET(KIWI_RELEASE_CFLAGS "-DKIWI_RELEASE -DNDEBUG -O3")
  ENDIF(MSVC)
ENDMACRO(KIWI_SETUP_BUILD)

MACRO(KIWI_SETUP_BUILD_FLAGS)
  SET(CMAKE_C_FLAGS ${PLATFORM_CFLAGS} CACHE STRING "" FORCE)
  SET(CMAKE_CXX_FLAGS ${PLATFORM_CXXFLAGS} CACHE STRING "" FORCE)

  ## Debug
  SET(CMAKE_C_FLAGS_DEBUG ${KIWI_DEBUG_CFLAGS} CACHE STRING "" FORCE)
  SET(CMAKE_CXX_FLAGS_DEBUG ${KIWI_DEBUG_CFLAGS} CACHE STRING "" FORCE)
  SET(CMAKE_EXE_LINKER_FLAGS_DEBUG "${PLATFORM_LINKFLAGS} ${KIWI_DEBUG_LINKFLAGS}" CACHE STRING "" FORCE)
  SET(CMAKE_MODULE_LINKER_FLAGS_DEBUG "${PLATFORM_LINKFLAGS} ${KIWI_DEBUG_LINKFLAGS}" CACHE STRING "" FORCE)
  SET(CMAKE_SHARED_LINKER_FLAGS_DEBUG "${PLATFORM_LINKFLAGS} ${KIWI_DEBUG_LINKFLAGS}" CACHE STRING "" FORCE)

  ## Release
  SET(CMAKE_C_FLAGS_RELEASE ${KIWI_RELEASE_CFLAGS} CACHE STRING "" FORCE)
  SET(CMAKE_CXX_FLAGS_RELEASE ${KIWI_RELEASE_CFLAGS} CACHE STRING "" FORCE)
  SET(CMAKE_EXE_LINKER_FLAGS_RELEASE "${PLATFORM_LINKFLAGS} ${KIWI_RELEASE_LINKFLAGS}" CACHE STRING "" FORCE)
  SET(CMAKE_MODULE_LINKER_FLAGS_RELEASE "${PLATFORM_LINKFLAGS} ${KIWI_RELEASE_LINKFLAGS}" CACHE STRING "" FORCE)
  SET(CMAKE_SHARED_LINKER_FLAGS_RELEASE "${PLATFORM_LINKFLAGS} ${KIWI_RELEASE_LINKFLAGS}" CACHE STRING "" FORCE)
ENDMACRO(KIWI_SETUP_BUILD_FLAGS)

MACRO(KIWI_SETUP_PREFIX_PATHS)
  ## Allow override of install_prefix/share path.
  IF(NOT KIWI_SHARE_PREFIX)
    IF(WIN32)
      SET(KIWI_SHARE_PREFIX "../share/kiwi" CACHE PATH "Installation path for data.")
    ELSE(WIN32)
      SET(KIWI_SHARE_PREFIX "${CMAKE_INSTALL_PREFIX}/share/kiwi" CACHE PATH "Installation path for data.")
    ENDIF(WIN32)
  ENDIF(NOT KIWI_SHARE_PREFIX)

  ## Allow override of install_prefix/sbin path.
  IF(NOT KIWI_SBIN_PREFIX)
    IF(WIN32)
      SET(KIWI_SBIN_PREFIX "../sbin" CACHE PATH "Installation path for admin tools and services.")
    ELSE(WIN32)
      SET(KIWI_SBIN_PREFIX "${CMAKE_INSTALL_PREFIX}/sbin" CACHE PATH "Installation path for admin tools and services.")
    ENDIF(WIN32)
  ENDIF(NOT KIWI_SBIN_PREFIX)

  ## Allow override of install_prefix/bin path.
  IF(NOT KIWI_BIN_PREFIX)
    IF(WIN32)
      SET(KIWI_BIN_PREFIX "../bin" CACHE PATH "Installation path for tools and applications.")
    ELSE(WIN32)
      SET(KIWI_BIN_PREFIX "${CMAKE_INSTALL_PREFIX}/bin" CACHE PATH "Installation path for tools and applications.")
    ENDIF(WIN32)
  ENDIF(NOT KIWI_BIN_PREFIX)

  ## Allow override of install_prefix/lib path.
  IF(NOT KIWI_LIB_PREFIX)
    IF(WIN32)
      SET(KIWI_LIB_PREFIX "../lib" CACHE PATH "Installation path for libraries.")
    ELSE(WIN32)
      IF(CMAKE_LIBRARY_ARCHITECTURE)
        SET(KIWI_LIB_PREFIX "${CMAKE_INSTALL_PREFIX}/lib/${CMAKE_LIBRARY_ARCHITECTURE}" CACHE PATH "Installation path for libraries.")
      ELSE(CMAKE_LIBRARY_ARCHITECTURE)
        SET(KIWI_LIB_PREFIX "${CMAKE_INSTALL_PREFIX}/lib" CACHE PATH "Installation path for libraries.")
      ENDIF(CMAKE_LIBRARY_ARCHITECTURE)
    ENDIF(WIN32)
  ENDIF(NOT KIWI_LIB_PREFIX)

ENDMACRO(KIWI_SETUP_PREFIX_PATHS)

MACRO(KIWI_SETUP_POCO_LIB_PATH)
  if( WITH_POCO_LIB )
  	IF(WIN32)
      	if( TARGET_X64 )
	    	SET(POCO_LIB_DIRECTORY "../../../poco-1.4.6-all/lib" )
      	else( TARGET_X64 )
	    	SET(POCO_LIB_DIRECTORY "../../../poco-1.4.6-all/lib" )
    	endif( TARGET_X64 )
    else( WIN32 )
    	if( APPLE )
          if( TARGET_X64 )
	    	SET(POCO_LIB_DIRECTORY "../../../poco-1.4.6-all/lib/Darwin/x86_64" )
      	  else( TARGET_X64 )
	    	SET(POCO_LIB_DIRECTORY "../../../poco-1.4.6-all/lib/Darwin/x86" )
    	  endif( TARGET_X64 )
    	endif( APPLE )
    endif( WIN32 )
  endif( WITH_POCO_LIB )

ENDMACRO(KIWI_SETUP_POCO_LIB_PATH)


MACRO(SETUP_EXTERNAL)
  IF(WITH_EXTERNAL)
    FIND_PACKAGE(External REQUIRED)
  ENDIF(WITH_EXTERNAL)

  IF(WIN32)
    FIND_PACKAGE(External REQUIRED)

    IF(MSVC10)
      IF(NOT MSVC10_REDIST_DIR)
        # If you have VC++ 2010 Express, put x64/Microsoft.VC100.CRT/*.dll in ${EXTERNAL_PATH}/redist
        SET(MSVC10_REDIST_DIR "${EXTERNAL_PATH}/redist")
      ENDIF(NOT MSVC10_REDIST_DIR)

      IF(NOT VC_DIR)
        IF(NOT VC_ROOT_DIR)
          GET_FILENAME_COMPONENT(VC_ROOT_DIR "[HKEY_CURRENT_USER\\Software\\Microsoft\\VisualStudio\\10.0_Config;InstallDir]" ABSOLUTE)
          # VC_ROOT_DIR is set to "registry" when a key is not found
          IF(VC_ROOT_DIR MATCHES "registry")
            GET_FILENAME_COMPONENT(VC_ROOT_DIR "[HKEY_CURRENT_USER\\Software\\Microsoft\\VCExpress\\10.0_Config;InstallDir]" ABSOLUTE)
            IF(VC_ROOT_DIR MATCHES "registry")
              FILE(TO_CMAKE_PATH $ENV{VS100COMNTOOLS} VC_ROOT_DIR)
              IF(NOT VC_ROOT_DIR)
                MESSAGE(FATAL_ERROR "Unable to find VC++ 2010 directory!")
              ENDIF(NOT VC_ROOT_DIR)
            ENDIF(VC_ROOT_DIR MATCHES "registry")
          ENDIF(VC_ROOT_DIR MATCHES "registry")
        ENDIF(NOT VC_ROOT_DIR)
        # convert IDE fullpath to VC++ path
        STRING(REGEX REPLACE "Common7/.*" "VC" VC_DIR ${VC_ROOT_DIR})
      ENDIF(NOT VC_DIR)
    ELSE(MSVC10)
      IF(NOT VC_DIR)
        IF(${CMAKE_MAKE_PROGRAM} MATCHES "Common7")
          # convert IDE fullpath to VC++ path
          STRING(REGEX REPLACE "Common7/.*" "VC" VC_DIR ${CMAKE_MAKE_PROGRAM})
        ELSE(${CMAKE_MAKE_PROGRAM} MATCHES "Common7")
          # convert compiler fullpath to VC++ path
          STRING(REGEX REPLACE "VC/bin/.+" "VC" VC_DIR ${CMAKE_CXX_COMPILER})
        ENDIF(${CMAKE_MAKE_PROGRAM} MATCHES "Common7")
      ENDIF(NOT VC_DIR)
    ENDIF(MSVC10)

  ELSE(WIN32)
    IF(APPLE)
      IF(WITH_STATIC_EXTERNAL)
        SET(CMAKE_FIND_LIBRARY_SUFFIXES .a .dylib .so)
      ELSE(WITH_STATIC_EXTERNAL)
        SET(CMAKE_FIND_LIBRARY_SUFFIXES .dylib .so .a)
      ENDIF(WITH_STATIC_EXTERNAL)

    ELSE(APPLE)
      IF(WITH_STATIC_EXTERNAL)
        SET(CMAKE_FIND_LIBRARY_SUFFIXES .a .so)
      ELSE(WITH_STATIC_EXTERNAL)
        SET(CMAKE_FIND_LIBRARY_SUFFIXES .so .a)
      ENDIF(WITH_STATIC_EXTERNAL)
    ENDIF(APPLE)
  ENDIF(WIN32)

  IF(WITH_STLPORT)
    FIND_PACKAGE(STLport REQUIRED)
    INCLUDE_DIRECTORIES(${STLPORT_INCLUDE_DIR})
    IF(MSVC)
      SET(VC_INCLUDE_DIR "${VC_DIR}/include")

      FIND_PACKAGE(WindowsSDK REQUIRED)
      # use VC++ and Windows SDK include paths
      INCLUDE_DIRECTORIES(${VC_INCLUDE_DIR} ${WINSDK_INCLUDE_DIR})
    ENDIF(MSVC)
  ENDIF(WITH_STLPORT)
ENDMACRO(SETUP_EXTERNAL)
