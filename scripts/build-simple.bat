@echo off
setlocal

echo Building simple window example...

:: Find the project root directory (where this script is located)
set SCRIPT_DIR=%~dp0
set PROJECT_ROOT=%SCRIPT_DIR%..

:: Navigate to project root
cd "%PROJECT_ROOT%"

:: Create build directory if it doesn't exist
if not exist build mkdir build

:: Navigate to build directory
cd build

:: Configure with CMake
cmake .. -DCMAKE_BUILD_TYPE=Debug -DBUILD_EXAMPLES=ON

:: Build just the simple window example
cmake --build . --config Debug --target simple_window

if %ERRORLEVEL% EQU 0 (
    echo.
    echo Build successful!
    echo Executable located at: %PROJECT_ROOT%\build\bin\examples\Debug\simple_window.exe
    echo.
    echo Running example...
    echo.
    
    :: Run the example if it was built successfully
    cd bin\examples\Debug
    simple_window.exe
    cd ..\..\..
) else (
    echo.
    echo Build failed. See errors above.
    echo.
)

:: Return to original directory
cd ..

pause