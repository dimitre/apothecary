apothecary of openFrameworks https://github.com/openframeworks/openframeworks/
==========

potions of C++ Libraries used in openFrameworks 
formulae included 
apothecary is a bash build system, using CMake/Bash/Make with multiple compile targets to build C++ libraries multiplatform
```./apothecary/apothecary -tios -a arm64 update core``` 

## Libraries :
openssl, brotli, boost, curl, cario, assimp, fmt, freetype, glew, glfw, FreeImage, glm, json, libpng, libxml2, pugixml, pixman, poco, rtAudio, svgtiny, tess2, uriparser, videoInput, utf8, zlib, libusb

## Automation 
Libraries are all built securely on and thanks to @Github actions / servers and hashes are deployed alongside libraries in latest with a .pkg hash

### Latest openFrameworks Libraries
[https://github.com/openframeworks/apothecary/releases/tag/bleeding](https://github.com/openframeworks/apothecary/releases/tag/bleeding)
- in openFrameworks | scripts | platform  ```download_latest_libs.sh```


### Stable openFrameworks 0.12 Libaries 
[https://github.com/openframeworks/apothecary/releases/tag/nightly](https://github.com/openframeworks/apothecary/releases/tag/nightly)
- in openFrameworks | scripts | platform and downloaded by running the ```download_libs.sh```


 #  [openFrameworks](http://openframeworks.cc)

apothecary, a bash build system with bash formulaes, Controlling Potions (CMake Build Commands) for Compiling all dependency Libraries for openFrameworks. Built libraries can be used by all and we try and build them all up to date and all licenses are packaged.

## Build status

| Platform                  | Status       | Info                      | Extra Info                     |
|---------------------------|--------------|---------------------------|--------------------------------|
| **Windows x86_64**        | [![build-vs2022-64](https://github.com/openframeworks/apothecary/actions/workflows/build-vs2022-x64.yml/badge.svg)](https://github.com/openframeworks/apothecary/actions/workflows/build-vs2022-x64.yml)     | VS2022                    | C++2b, C17                    |
| **Windows arm64**         | [![build-vs2022-arm64](https://github.com/openframeworks/apothecary/actions/workflows/build-vs2022_arm64.yml/badge.svg)](https://github.com/openframeworks/apothecary/actions/workflows/build-vs2022_arm64.yml)     | VS2022                    | C++2b, C17                    |
| **Windows arm64EC**       | [![build-vs2022-arm64ec](https://github.com/openframeworks/apothecary/actions/workflows/build-vs2022-arm64ec.yml/badge.svg)](https://github.com/openframeworks/apothecary/actions/workflows/build-vs2022-arm64ec.yml)     | VS2022                    | C++2b, C17                    |
| **Linux x86_x64**             | complete     | Make, VSCode              | C++2b, C17, Package Manager    |
| **Linux armv6**           | complete     | Make                      | C++2b, C17, Package Manager    |
| **Linux armv7**           | complete     | Make                      | C++2b, C17, Package Manager    |
| **Linux arm64**           |              | Make                      | C++2b, C17, Package Manager    |
| **macOS x86_64**          | [![build-macos](https://github.com/openframeworks/apothecary/actions/workflows/build-macos.yml/badge.svg)](https://github.com/openframeworks/apothecary/actions/workflows/build-macos.yml)     | Xcode, VSCode             | .xcFrameworks, C++2b, C17      |
| **macOS arm64**           | [![build-macos](https://github.com/openframeworks/apothecary/actions/workflows/build-macos.yml/badge.svg)](https://github.com/openframeworks/apothecary/actions/workflows/build-macos.yml)     | Xcode, VSCode             | .xcFrameworks, C++2b, C17      |
| **emscripten**            | [![build-emscripten](https://github.com/openframeworks/apothecary/actions/workflows/build-emscripten.yml/badge.svg)](https://github.com/openframeworks/apothecary/actions/workflows/build-emscripten.yml)     | Make                      | C++17, C17                    |
| **emscripten memory64**   | [![build-emscripten](https://github.com/openframeworks/apothecary/actions/workflows/build-emscripten.yml/badge.svg)](https://github.com/openframeworks/apothecary/actions/workflows/build-emscripten.yml)     | Make                      | C++17, C17                    |
| **iOS arm64**             | [![build-ios](https://github.com/openframeworks/apothecary/actions/workflows/build-ios.yml/badge.svg)](https://github.com/openframeworks/apothecary/actions/workflows/build-ios.yml)     | Xcode, VSCode             | .xcFrameworks, C++2b          |
| **iOS x86_64 Simulator**  | [![build-ios](https://github.com/openframeworks/apothecary/actions/workflows/build-ios.yml/badge.svg)](https://github.com/openframeworks/apothecary/actions/workflows/build-ios.yml)     | Xcode, VSCode             | .xcFrameworks, C++2b          |
| **iOS arm64 Simulator**   | [![build-ios](https://github.com/openframeworks/apothecary/actions/workflows/build-ios.yml/badge.svg)](https://github.com/openframeworks/apothecary/actions/workflows/build-ios.yml)     | Xcode, VSCode             | .xcFrameworks, C++2b          |
| **tvOS arm64**            | [![build-tvos](https://github.com/openframeworks/apothecary/actions/workflows/build-tvos.yml/badge.svg)](https://github.com/openframeworks/apothecary/actions/workflows/build-tvos.yml)     | Xcode, VSCode             | .xcFrameworks, C++2b          |
| **tvOS x86_64 Simulator** | [![build-tvos](https://github.com/openframeworks/apothecary/actions/workflows/build-tvos.yml/badge.svg)](https://github.com/openframeworks/apothecary/actions/workflows/build-tvos.yml)     | Xcode, VSCode             | .xcFrameworks, C++2b          |
| **tvOS arm64 Simulator**  | [![build-tvos](https://github.com/openframeworks/apothecary/actions/workflows/build-tvos.yml/badge.svg)](https://github.com/openframeworks/apothecary/actions/workflows/build-tvos.yml)     | Xcode, VSCode             | .xcFrameworks, C++2b          |
| **visionOS arm64**        | [![build-macos](https://github.com/openframeworks/apothecary/actions/workflows/build-xros.yml/badge.svg)](https://github.com/openframeworks/apothecary/actions/workflows/build-xros.yml)     | Xcode, VSCode             | .xcFrameworks, C++2b          |
| **visionOS x86_64 Simulator** | [![build-macos](https://github.com/openframeworks/apothecary/actions/workflows/build-xros.yml/badge.svg)](https://github.com/openframeworks/apothecary/actions/workflows/build-xros.yml)  | Xcode, VSCode             | .xcFrameworks, C++2b          |
| **visionOS arm64 Simulator** | [![build-macos](https://github.com/openframeworks/apothecary/actions/workflows/build-xros.yml/badge.svg)](https://github.com/openframeworks/apothecary/actions/workflows/build-xros.yml)  | Xcode, VSCode             | .xcFrameworks, C++2b          |
| **macOS catOS arm64**     | [![build-macos](https://github.com/openframeworks/apothecary/actions/workflows/build-macos.yml/badge.svg)](https://github.com/openframeworks/apothecary/actions/workflows/build-macos.yml)     | Xcode, VSCode             | .xcFrameworks, C++2b          |
| **macOS catOS x86_64**    | [![build-macos](https://github.com/openframeworks/apothecary/actions/workflows/build-macos.yml/badge.svg)](https://github.com/openframeworks/apothecary/actions/workflows/build-macos.yml)     | Xcode, VSCode             | .xcFrameworks, C++2b          |
| **xcframeworks**          | [![build-xcframeworks](https://github.com/openframeworks/apothecary/actions/workflows/build-xcframework.yml/badge.svg)](https://github.com/openframeworks/apothecary/actions/workflows/build-xcframework.yml)     | Xcode, VSCode             | .xcFrameworks, C++2b, C17      |
| **Android arm64**         | [![build-android](https://github.com/openframeworks/apothecary/actions/workflows/build-android.yml/badge.svg)](https://github.com/openframeworks/apothecary/actions/workflows/build-android.yml)     | NDK 23, Android Studio    | CMake                         |
| **Android x86_64**        | [![build-android](https://github.com/openframeworks/apothecary/actions/workflows/build-android.yml/badge.svg)](https://github.com/openframeworks/apothecary/actions/workflows/build-android.yml)     | NDK 23, Android Studio    | CMake                         |
| **Android x86**           | [![build-android](https://github.com/openframeworks/apothecary/actions/workflows/build-android.yml/badge.svg)](https://github.com/openframeworks/apothecary/actions/workflows/build-android.yml)     | NDK 23, Android Studio    | CMake                         |
| **Android armv7**         | [![build-android](https://github.com/openframeworks/apothecary/actions/workflows/build-android.yml/badge.svg)](https://github.com/openframeworks/apothecary/actions/workflows/build-android.yml)     | NDK 23, Android Studio    | CMake                         |

and  scripts in [openFrameworks if working from git](https://github.com/openframeworks/apothecary/#developers).

### Setup your Environment to build apothecary
For your target type, run the script:



### Setup your Environment to build apothecary
For your target type, run the script/osx/install.sh

### Build scripts for target
For your target type, run the build and deploy scripts. This will build all the calculated formulaes required for type and install them in output dir . For macOS:
```
scripts/osx/build_and_deploy_all.sh
```

Build VS 2022:
```
scripts/vs/build_and_deploy_all.sh
```

Build iOS:
```
scripts/ios/build_and_deploy_all.sh
```

Build Android:
```
scripts/android/build_android_arm64.sh
scripts/android/build_android_armv7.sh
scripts/android/build_android_x86.sh
scripts/android/build_android_x86_64.sh
```


#### Running directly
To build one of the dependencies, you can run a command like this to compile OpenCV on OSX`
```
./apothecary/apothecary -t osx -a64 -j 6 update opencv
```

To build all of the dependencies, you can run a command like this for Android
```
./apothecary/apothecary -t android -a arm64 update core
./apothecary/apothecary -t android -a x86_64 update addons
```

To build all of the dependencies, you can run a command like this for macOS 
```
./apothecary/apothecary -t osx -a arm64 update core
./apothecary/apothecary -t osx -a x86_64 update core
```

To build all of the dependencies, you can run a command like this for VS 
```
./apothecary/apothecary -t vs -a arm64 update core
./apothecary/apothecary -t vs -a x86_64 update core
```

To build all of the dependencies, you can run a command like this for VS 
```
./apothecary/apothecary -t emscripten update core
./apothecary/apothecary -t emscripten update addons
```

See the help section for more options
```
./apothecary/apothecary --help
```


------------

2014 openFrameworks team
2013 Dan Wilcox <danomatika@gmail.com> supported by the CMU [Studio for Creative Inquiry](http://studioforcreativeinquiry.org/)
2024 Dan Rosser
