/**
 * @file main.cpp
 * @brief Simple window example for Ramo3D
 * 
 * This is a basic example that creates a window and runs a simple game loop.
 * No complex abstractions are used - just direct SDL3 calls.
 */

 #include <SDL3/SDL.h>
 #include <iostream>
 #include <string>
 
 // Error handling helper
 void checkSDLError(const std::string& message)
 {
     const char* error = SDL_GetError();
     if (error && *error != '\0') 
     {
         std::cerr << "SDL Error (" << message << "): " << error << std::endl;
         SDL_ClearError();
     }
 }
 
 int main(int argc, char* argv[])
 {
    (argc);
    (argv);

     // Initialize SDL
     if (!SDL_Init(SDL_INIT_VIDEO)) 
     {
         std::cerr << "Failed to initialize SDL: " << SDL_GetError() << std::endl;
         return 1;
     }
     
     std::cout << "SDL initialized successfully!" << std::endl;
     std::cout << "Platform: " << SDL_GetPlatform() << std::endl;
     
     // Create window
     SDL_Window* window = SDL_CreateWindow(
         "Ramo3D Simple Window",  // Window title
         800,                     // Width
         600,                     // Height
         SDL_WINDOW_RESIZABLE     // Flags
     );
     
     if (!window) 
     {
         std::cerr << "Failed to create window: " << SDL_GetError() << std::endl;
         SDL_Quit();
         return 1;
     }
     
     // Create renderer (with VSync enabled)
     SDL_Renderer* renderer = SDL_CreateRenderer(window, NULL);
     
     if (!renderer) 
     {
         std::cerr << "Failed to create renderer: " << SDL_GetError() << std::endl;
         SDL_DestroyWindow(window);
         SDL_Quit();
         return 1;
     }
     
     // Set up rendering variables
     float rectX = 300.0f;        // Rectangle X position
     float rectY = 200.0f;        // Rectangle Y position
     const float rectWidth = 100.0f;    // Rectangle width
     const float rectHeight = 100.0f;   // Rectangle height
     
     // Variables for tracking frame rate
     uint64_t lastTime = SDL_GetTicks();
     uint64_t currentTime = 0;
     float deltaTime = 0.0f;
     
     int frameCount = 0;
     float frameAccumulator = 0.0f;
     float fps = 0.0f;
     
     // Main loop
     bool running = true;
     SDL_Event event;
     
     std::cout << "Starting main loop..." << std::endl;
     std::cout << "Controls:" << std::endl;
     std::cout << "  WASD - Move rectangle" << std::endl;
     std::cout << "  F - Toggle fullscreen" << std::endl;
     std::cout << "  Escape - Exit application" << std::endl;
     
     while (running) 
     {
         // Calculate delta time (time since last frame)
         currentTime = SDL_GetTicks();
         deltaTime = (currentTime - lastTime) / 1000.0f;
         lastTime = currentTime;
         
         // Update FPS counter
         frameCount++;
         frameAccumulator += deltaTime;
         if (frameAccumulator >= 1.0f) 
         {
             fps = frameCount / frameAccumulator;
             frameCount = 0;
             frameAccumulator = 0.0f;
             
             // Update window title with FPS
             std::string title = "Ramo3D Simple Window | FPS: " + std::to_string(static_cast<int>(fps));
             SDL_SetWindowTitle(window, title.c_str());
         }
         
         // Handle events
         while (SDL_PollEvent(&event)) 
         {
             switch (event.type) 
             {
                 case SDL_EVENT_QUIT:
                     running = false;
                     break;
                 
                 case SDL_EVENT_KEY_DOWN:
                     if (event.key.repeat == 0) 
                     {  // Ignore key repeats
                         switch (event.key.scancode)
                         {
                             case SDL_SCANCODE_ESCAPE:
                                 running = false;
                                 break;
                             
                             case SDL_SCANCODE_F:
                                 // Toggle fullscreen
                                 {
                                     uint32_t flags = static_cast<uint32_t>(SDL_GetWindowFlags(window));
                                     bool isFullscreen = (flags & SDL_WINDOW_FULLSCREEN) != 0;
                                     SDL_SetWindowFullscreen(window, !isFullscreen);
                                 }
                                 break;
                         }
                     }
                     break;
                 
                 case SDL_EVENT_WINDOW_RESIZED:
                     std::cout << "Window resized to: " << event.window.data1 
                               << "x" << event.window.data2 << std::endl;
                     break;
             }
         }
         
         // Handle keyboard state for movement
         const uint8_t* keyboardState = reinterpret_cast<const uint8_t*>(SDL_GetKeyboardState(nullptr));
         float moveSpeed = 200.0f; // pixels per second
         
         if (keyboardState[SDL_SCANCODE_W]) {
             rectY -= moveSpeed * deltaTime;
         }
         if (keyboardState[SDL_SCANCODE_S]) {
             rectY += moveSpeed * deltaTime;
         }
         if (keyboardState[SDL_SCANCODE_A]) {
             rectX -= moveSpeed * deltaTime;
         }
         if (keyboardState[SDL_SCANCODE_D]) {
             rectX += moveSpeed * deltaTime;
         }
         
         // Get the current window size to constrain the rectangle
         int windowWidth, windowHeight;
         SDL_GetWindowSize(window, &windowWidth, &windowHeight);
         
         // Keep rectangle within window bounds
         if (rectX < 0) rectX = 0;
         if (rectY < 0) rectY = 0;
         if (rectX > windowWidth - rectWidth) rectX = windowWidth - rectWidth;
         if (rectY > windowHeight - rectHeight) rectY = windowHeight - rectHeight;
         
         // Clear screen
         SDL_SetRenderDrawColor(renderer, 64, 64, 64, 255);
         SDL_RenderClear(renderer);
         
         // Draw rectangle
         SDL_FRect rect = { rectX, rectY, rectWidth, rectHeight };
         SDL_SetRenderDrawColor(renderer, 255, 0, 0, 255);
         SDL_RenderFillRect(renderer, &rect);
         
         // Draw border around the window
         SDL_FRect border = { 2, 2, static_cast<float>(windowWidth) - 4, static_cast<float>(windowHeight) - 4 };
         SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
         SDL_RenderRect(renderer, &border);
         
         // Present renderer (swap buffers)
         SDL_RenderPresent(renderer);
     }
     
     // Cleanup
     std::cout << "Shutting down..." << std::endl;
     SDL_DestroyRenderer(renderer);
     SDL_DestroyWindow(window);
     SDL_Quit();
     
     std::cout << "Clean exit!" << std::endl;
     return 0;
 }