if(
    TARGET ecl::library
)
    return()
endif()

add_library(
    ecl::library
    SHARED
    IMPORTED
)

if(MSVC)
    set_target_properties(
        ecl::library
        PROPERTIES
            IMPORTED_LOCATION
                "${CMAKE_CURRENT_LIST_DIR}/bin/libecl.dll"
            IMPORTED_LOCATION_DEBUG
                "${CMAKE_CURRENT_LIST_DIR}/bin/libecld.dll"
            IMPORTED_IMPLIB
                "${CMAKE_CURRENT_LIST_DIR}/lib/ecl.lib"
            IMPORTED_IMPLIB_DEBUG          
                "${CMAKE_CURRENT_LIST_DIR}/lib/ecld.lib"
            INTERFACE_INCLUDE_DIRECTORIES
                "${CMAKE_CURRENT_LIST_DIR}/include/"
    )
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    set_target_properties(
        ecl::library
        PROPERTIES
            IMPORTED_LOCATION
                "${CMAKE_CURRENT_LIST_DIR}/lib/libecl.so"
            IMPORTED_LOCATION_DEBUG
                "${CMAKE_CURRENT_LIST_DIR}/lib/libecld.so"
            INTERFACE_INCLUDE_DIRECTORIES
                "${CMAKE_CURRENT_LIST_DIR}/include/"
    )
endif()

set(
    COMPONENT_NAMES

    CNPM_RUNTIME_ecl_library
    CNPM_RUNTIME
)

foreach(COMPONENT_NAME ${COMPONENT_NAMES})
    install(
        FILES
            $<TARGET_FILE:ecl::library>
        DESTINATION
            .
        COMPONENT
            ${COMPONENT_NAME}
        EXCLUDE_FROM_ALL
    )
endforeach()
