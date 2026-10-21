include(GNUInstallDirs)

find_program ( DOXYGEN_EXECUTABLE
  NAMES doxygen
  DOC "Doxygen program" )

if ( NOT ( DOXYGEN_EXECUTABLE MATCHES "NOTFOUND" ) )
  message ( STATUS "doxygen: ${DOXYGEN_EXECUTABLE}" )
  set ( top_srcdir "${CMAKE_SOURCE_DIR}" )
  configure_file (
	    "${CMAKE_CURRENT_SOURCE_DIR}/Doxyfile.in"
	    "${CMAKE_CURRENT_BINARY_DIR}/Doxyfile"
  )

  add_custom_target ( jswrappersdoc
    COMMAND ${DOXYGEN_EXECUTABLE} "${CMAKE_CURRENT_BINARY_DIR}/Doxyfile"
    WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
    COMMENT "Generating JS wrappers doxygen documentation" )
else ()
  message ( WARNING "Doxygen not found. JS Wrappers documentation generation disabled." )
endif ()

