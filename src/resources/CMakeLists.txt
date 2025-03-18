# Resources component CMakeLists.txt

# # Collect source files
# file(GLOB_RECURSE RESOURCES_SOURCES "*.cpp")
# file(GLOB_RECURSE RESOURCES_HEADERS "${CMAKE_SOURCE_DIR}/include/resources/*.h")

# # Resources library
# add_library(Resources STATIC ${RESOURCES_SOURCES} ${RESOURCES_HEADERS})

# # Set include directories
# target_include_directories(Resources
#     PUBLIC
#         ${CMAKE_SOURCE_DIR}/include
#     PRIVATE
#         ${CMAKE_CURRENT_SOURCE_DIR}
# )

# # Add compiler definitions
# target_compile_definitions(Resources
#     PRIVATE
#         RESOURCES_EXPORTS
# )

# # Link dependencies
# target_link_libraries(Resources
#     PUBLIC
#         Core
#         Platform
#         assimp::assimp
# )

# # Install rules
# install(TARGETS Resources
#     ARCHIVE DESTINATION lib
#     LIBRARY DESTINATION lib
#     RUNTIME DESTINATION bin
# )

# Examples CMakeLists.txt
cmake_minimum_required(VERSION 3.14)

# We'll add actual examples later as we develop the core functionality
message(STATUS "Examples directory - No examples configured yet")