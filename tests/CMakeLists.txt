# Tests root CMakeLists.txt

# Function to add a test
function(add_ramo3d_test TEST_NAME)
    add_executable(${TEST_NAME} ${ARGN})
    target_link_libraries(${TEST_NAME} PRIVATE
        Ramo3D
        Doctest
    )
    target_compile_definitions(${TEST_NAME} PRIVATE DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN)
    set_target_properties(${TEST_NAME} PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin/tests"
        VS_DEBUGGER_WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/bin/tests"
    )
    
    # Add as a CTest test
    add_test(
        NAME ${TEST_NAME}
        COMMAND ${TEST_NAME}
        WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/bin/tests"
    )
endfunction()

# Core module tests
add_subdirectory(core)

# Platform module tests
add_subdirectory(platform)

# Renderer module tests
add_subdirectory(renderer)

# Resources module tests
add_subdirectory(resources)

# Scene module tests
add_subdirectory(scene)