# Simple window example CMakeLists.txt
cmake_minimum_required(VERSION 3.14)

# Simple window example
add_executable(simple_window
    main.cpp
)

# Link directly with SDL3 for this example
target_link_libraries(simple_window
    PRIVATE
        SDL3::SDL3
)

# Set output directory and working directory
set_target_properties(simple_window PROPERTIES
    FOLDER "Examples"
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin/examples"
    VS_DEBUGGER_WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/bin/examples"
)

# Copy SDL3 DLL to the output directory on Windows
if(WIN32)
    add_custom_command(TARGET simple_window POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
            $<TARGET_RUNTIME_DLLS:simple_window>
            $<TARGET_FILE_DIR:simple_window>
        COMMAND_EXPAND_LISTS
    )
endif()