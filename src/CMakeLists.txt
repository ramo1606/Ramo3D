set(SOURCES
    # Core sources
    application.cpp
    
    # Will add more as we develop
)

# Define header files
set(HEADERS
    ${CMAKE_SOURCE_DIR}/include/application.h
    # Add more headers as needed
)

set(EXTERNAL_HEADERS
    ${CMAKE_SOURCE_DIR}/external/raylib/include/raymath.h
    ${CMAKE_SOURCE_DIR}/external/raylib/include/reasings.h
    ${CMAKE_SOURCE_DIR}/external/raylib/include/rmem.h
    ${CMAKE_SOURCE_DIR}/external/raylib/include/rres.h
)

# Create source groups for better organization in Visual Studio
source_group("Source Files" FILES ${SOURCES})
source_group("Header Files" FILES ${HEADERS})
source_group("External Headers\\Raylib" FILES ${EXTERNAL_HEADERS})

# Main library
add_library(Ramo3D ${SOURCES} ${HEADERS} ${EXTERNAL_HEADERS})

# Include directories
target_include_directories(Ramo3D
    PUBLIC
        ${CMAKE_SOURCE_DIR}/include
    PRIVATE
        ${CMAKE_SOURCE_DIR}/src
)

# Link dependencies
target_link_libraries(Ramo3D
    PUBLIC
        SDL3::SDL3
        glad
        raylib_headers
)