# Core component CMakeLists.txt

# Collect source files
# file(GLOB_RECURSE CORE_SOURCES "*.cpp")
# file(GLOB_RECURSE CORE_HEADERS "${CMAKE_SOURCE_DIR}/include/core/*.h")

# Core library
# add_library(Core STATIC ${CORE_SOURCES} ${CORE_HEADERS})

# Set include directories
# target_include_directories(Core
#     PUBLIC
#         ${CMAKE_SOURCE_DIR}/include
#     PRIVATE
#         ${CMAKE_CURRENT_SOURCE_DIR}
# )

# Add compiler definitions
# target_compile_definitions(Core
#     PRIVATE
#         CORE_EXPORTS
#     PUBLIC
#         $<$<CONFIG:Debug>:RAMO3D_DEBUG>
# )

# Link dependencies
# target_link_libraries(Core
#     PUBLIC
#         tracy
# )

# Install rules
# install(TARGETS Core
#     ARCHIVE DESTINATION lib
#     LIBRARY DESTINATION lib
#     RUNTIME DESTINATION bin
# )

# Examples CMakeLists.txt
cmake_minimum_required(VERSION 3.14)

# We'll add actual examples later as we develop the core functionality
message(STATUS "Examples directory - No examples configured yet")