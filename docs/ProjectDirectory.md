Ramo3D/
├── .gitignore
├── CMakeLists.txt
├── CMakeUserPresets.json
├── LICENSE
├── README.md
│
├── assets/
│   ├── models/
│   │   └── .gitkeep
│   ├── shaders/
│   │   ├── opengl/
│   │   │   ├── basic.frag
│   │   │   └── basic.vert
│   │   └── .gitkeep
│   └── textures/
│       └── .gitkeep
│
├── cmake/
│   ├── dependencies.cmake
│   └── utils.cmake
│
├── docs/
│   ├── architecture.md
│   ├── renderers.md
│   └── memory_management.md
│
├── examples/
│   ├── CMakeLists.txt
│   ├── basic_triangle/
│   │   ├── CMakeLists.txt
│   │   └── main.cpp
│   └── pbr_showcase/
│       ├── CMakeLists.txt
│       └── main.cpp
│
├── externals/
│   └── .gitkeep
│
├── include/
│   ├── core/
│   │   ├── common.h
│   │   ├── core.h
│   │   ├── logging/
│   │   │   ├── logger.h
│   │   │   └── log_level.h
│   │   ├── memory/
│   │   │   ├── allocator.h
│   │   │   ├── linear_allocator.h
│   │   │   ├── pool_allocator.h
│   │   │   └── memory_manager.h
│   │   └── error/
│   │       ├── error.h
│   │       └── assert.h
│   │
│   ├── platform/
│   │   ├── platform.h
│   │   ├── window.h
│   │   └── input.h
│   │
│   ├── renderer/
│   │   ├── renderer.h
│   │   ├── renderer_api.h
│   │   ├── buffer.h
│   │   ├── shader.h
│   │   ├── texture.h
│   │   ├── camera.h
│   │   ├── material.h
│   │   ├── light.h
│   │   ├── opengl/
│   │   │   ├── gl_renderer.h
│   │   │   ├── gl_buffer.h
│   │   │   └── gl_shader.h
│   │   ├── directx/
│   │   │   └── .gitkeep
│   │   └── software/
│   │       ├── sw_renderer.h
│   │       └── sw_buffer.h
│   │
│   ├── resources/
│   │   ├── resource.h
│   │   ├── resource_manager.h
│   │   ├── mesh.h
│   │   └── model.h
│   │
│   ├── scene/
│   │   ├── scene.h
│   │   ├── entity.h
│   │   ├── component.h
│   │   ├── transform.h
│   │   └── scene_manager.h
│   │
│   └── editor/
│       ├── editor.h
│       └── ui_layer.h
│
├── scripts/
│   ├── generate_vs2022.bat
│   └── package_release.bat
│
├── src/
│   ├── core/
│   │   ├── CMakeLists.txt
│   │   ├── logging/
│   │   │   ├── logger.cpp
│   │   │   └── console_sink.cpp
│   │   ├── memory/
│   │   │   ├── linear_allocator.cpp
│   │   │   ├── pool_allocator.cpp
│   │   │   └── memory_manager.cpp
│   │   └── error/
│   │       └── error.cpp
│   │
│   ├── platform/
│   │   ├── CMakeLists.txt
│   │   ├── sdl/
│   │   │   ├── sdl_window.cpp
│   │   │   └── sdl_input.cpp
│   │   └── platform.cpp
│   │
│   ├── renderer/
│   │   ├── CMakeLists.txt
│   │   ├── renderer.cpp
│   │   ├── camera.cpp
│   │   ├── material.cpp
│   │   ├── opengl/
│   │   │   ├── gl_renderer.cpp
│   │   │   ├── gl_buffer.cpp
│   │   │   └── gl_shader.cpp
│   │   ├── directx/
│   │   │   └── .gitkeep
│   │   └── software/
│   │       ├── sw_renderer.cpp
│   │       └── sw_buffer.cpp
│   │
│   ├── resources/
│   │   ├── CMakeLists.txt
│   │   ├── resource_manager.cpp
│   │   ├── mesh.cpp
│   │   └── model.cpp
│   │
│   ├── scene/
│   │   ├── CMakeLists.txt
│   │   ├── scene.cpp
│   │   ├── entity.cpp
│   │   ├── transform.cpp
│   │   └── scene_manager.cpp
│   │
│   └── editor/
│       ├── CMakeLists.txt
│       ├── editor.cpp
│       └── ui_layer.cpp
│
└── tests/
    ├── CMakeLists.txt
    ├── core/
    │   ├── CMakeLists.txt
    │   ├── memory_tests.cpp
    │   └── logging_tests.cpp
    ├── platform/
    │   ├── CMakeLists.txt
    │   └── window_tests.cpp
    ├── renderer/
    │   ├── CMakeLists.txt
    │   └── buffer_tests.cpp
    ├── resources/
    │   ├── CMakeLists.txt
    │   └── resource_tests.cpp
    └── scene/
        ├── CMakeLists.txt
        └── entity_tests.cpp