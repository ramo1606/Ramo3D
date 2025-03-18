# Platform component CMakeLists.txt

# Collect source files
# file(GLOB_RECURSE PLATFORM_SOURCES "*.cpp")
# file(GLOB_RECURSE PLATFORM_HEADERS "${CMAKE_SOURCE_DIR}/include/platform/*.h")

# Platform library
# add_library(Platform STATIC ${PLATFORM_SOURCES} ${PLATFORM_HEADERS})

# Set include directories
# target_include_directories(Platform
#     PUBLIC
#         ${CMAKE_SOURCE_DIR}/include
#     PRIVATE
#         ${CMAKE_CURRENT_SOURCE_DIR}
# )

# Add compiler definitions
# target_compile_definitions(Platform
#     PRIVATE
#         PLATFORM_EXPORTS
# )

# Link dependencies
# target_link_libraries(Platform
#     PUBLIC
#         Core
#         SDL3::SDL3
# )

# Install rules
# install(TARGETS Platform
#     ARCHIVE DESTINATION lib
#     LIBRARY DESTINATION lib
#     RUNTIME DESTINATION bin
# )

# Examples CMakeLists.txt
cmake_minimum_required(VERSION 3.14)

# We'll add actual examples later as we develop the core functionality
message(STATUS "Examples directory - No examples configured yet")