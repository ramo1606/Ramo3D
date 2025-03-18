::@echo off
::mkdir build
::cd build
::cmake .. -DCMAKE_BUILD_TYPE=Debug -DWITH_EDITOR=ON
::cmake --build . --config Debug
::cd ..

@echo off
setlocal

echo Generating Visual Studio 2022 solution for Ramo3D...

:: Find the project root directory (where this script is located)
set SCRIPT_DIR=%~dp0
set PROJECT_ROOT=%SCRIPT_DIR%..

:: Navigate to project root
cd "%PROJECT_ROOT%"

:: Create build directory if it doesn't exist
if not exist build mkdir build

:: Navigate to build directory
cd build

:: Generate VS2022 solution
cmake .. -G "Visual Studio 17 2022" -A x64

if %ERRORLEVEL% EQU 0 (
    echo.
    echo Solution generated successfully!
    echo Open Ramo3D.sln in the build directory to start development.
    echo.
) else (
    echo.
    echo Error generating solution. Please check CMake output above.
    echo.
)

:: Return to original directory
cd ..

pause