# Renderer component CMakeLists.txt

# # Collect common source files
# file(GLOB RENDERER_COMMON_SOURCES "*.cpp")
# file(GLOB RENDERER_COMMON_HEADERS "${CMAKE_SOURCE_DIR}/include/renderer/*.h")

# # Define renderer sources
# set(RENDERER_SOURCES ${RENDERER_COMMON_SOURCES})
# set(RENDERER_HEADERS ${RENDERER_COMMON_HEADERS})

# # OpenGL backend
# if(ENABLE_OPENGL)
#     file(GLOB_RECURSE OPENGL_SOURCES "opengl/*.cpp")
#     file(GLOB_RECURSE OPENGL_HEADERS "${CMAKE_SOURCE_DIR}/include/renderer/opengl/*.h")
#     list(APPEND RENDERER_SOURCES ${OPENGL_SOURCES})
#     list(APPEND RENDERER_HEADERS ${OPENGL_HEADERS})
# endif()

# # DirectX backend
# if(ENABLE_DIRECTX)
#     file(GLOB_RECURSE DIRECTX_SOURCES "directx/*.cpp")
#     file(GLOB_RECURSE DIRECTX_HEADERS "${CMAKE_SOURCE_DIR}/include/renderer/directx/*.h")
#     list(APPEND RENDERER_SOURCES ${DIRECTX_SOURCES})
#     list(APPEND RENDERER_HEADERS ${DIRECTX_HEADERS})
# endif()

# # Software backend
# if(ENABLE_SOFTWARE)
#     file(GLOB_RECURSE SOFTWARE_SOURCES "software/*.cpp")
#     file(GLOB_RECURSE SOFTWARE_HEADERS "${CMAKE_SOURCE_DIR}/include/renderer/software/*.h")
#     list(APPEND RENDERER_SOURCES ${SOFTWARE_SOURCES})
#     list(APPEND RENDERER_HEADERS ${SOFTWARE_HEADERS})
# endif()

# # Renderer library
# add_library(Renderer STATIC ${RENDERER_SOURCES} ${RENDERER_HEADERS})

# # Set include directories
# target_include_directories(Renderer
#     PUBLIC
#         ${CMAKE_SOURCE_DIR}/include
#     PRIVATE
#         ${CMAKE_CURRENT_SOURCE_DIR}
# )

# # Add compiler definitions
# target_compile_definitions(Renderer
#     PRIVATE
#         RENDERER_EXPORTS
#     PUBLIC
#         $<$<BOOL:${ENABLE_OPENGL}>:RENDERER_OPENGL>
#         $<$<BOOL:${ENABLE_DIRECTX}>:RENDERER_DIRECTX>
#         $<$<BOOL:${ENABLE_SOFTWARE}>:RENDERER_SOFTWARE>
# )

# # Dependencies
# set(RENDERER_DEPS
#     Core
#     Platform
# )

# # Backend-specific dependencies
# if(ENABLE_OPENGL)
#     list(APPEND RENDERER_DEPS glad)
# endif()

# if(ENABLE_DIRECTX)
#     # DirectX dependencies would go here
# endif()

# # Link dependencies
# target_link_libraries(Renderer
#     PUBLIC
#         ${RENDERER_DEPS}
# )

# # Install rules
# install(TARGETS Renderer
#     ARCHIVE DESTINATION lib
#     LIBRARY DESTINATION lib
#     RUNTIME DESTINATION bin
# )

# Examples CMakeLists.txt
cmake_minimum_required(VERSION 3.14)

# We'll add actual examples later as we develop the core functionality
message(STATUS "Examples directory - No examples configured yet")