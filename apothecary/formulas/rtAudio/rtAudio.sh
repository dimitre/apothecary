#!/usr/bin/env bash
#
# RtAudio
# RealTime Audio input/output across Linux, Macintosh OS-X and Windows
# http://www.music.mcgill.ca/~gary/rtaudio/
#
# uses an autotools build system

FORMULA_TYPES=( "osx" "vs" "linux" "linux64" "linuxarmv6l" "linuxarmv7l" "linuxaarch64" )

#FORMULA_DEPENDS=( "pkg-config" )

# tell apothecary we want to manually call the dependency commands
# as we set some env vars for osx the depends need to know about
#FORMULA_DEPENDS_MANUAL=1

# define the version
VER=6.0.1
BUILD_ID=2
DEFINES=""

# tools for git use
GIT_URL=https://github.com/thestk/rtaudio
GIT_TAG=master
URL=https://www.music.mcgill.ca/~gary/rtaudio/release/

# download the source code and unpack it into LIB_NAME
function download() {
	#curl -O https://www.music.mcgill.ca/~gary/rtaudio/release/rtaudio-$VER.tar.gz
	echo git -c advice.detachedHead=false clone https://github.com/thestk/rtaudio.git --depth 1 --branch ${GIT_TAG}
	. "$DOWNLOADER_SCRIPT"
	# downloader ${URL}/rtaudio-${VER}.tar.gz
	git -c advice.detachedHead=false clone https://github.com/thestk/rtaudio.git --depth 1 --branch ${GIT_TAG} rtAudio

	# downloader ${GIT_URL}/archive/refs/tags/${VER}.tar.gz
	# tar -xf ${VER}.tar.gz
	# mv rtaudio-${VER} rtaudio
	# rm ${VER}.tar.gz
}

# # prepare the build environment, executed inside the lib src dir
# function prepare() {
# 	# nothing here
# }

# executed inside the lib src dir
function build() {
	echo "rtAudio.sh build function //// TYPE = ${TYPE}"

	DEFS="
			-DCMAKE_C_STANDARD=${C_STANDARD} \
	        -DCMAKE_CXX_STANDARD=${CPP_STANDARD} \
	        -DCMAKE_CXX_STANDARD_REQUIRED=ON \
	        -DCMAKE_CXX_EXTENSIONS=OFF \
	        -DCMAKE_INSTALL_INCLUDEDIR=include
	    "

	if [ "$TYPE" == "osx" ] ; then
		mkdir -p "build_${TYPE}_${PLATFORM}"
		cd "build_${TYPE}_${PLATFORM}"
		rm -f CMakeCache.txt *.a *.o
		cmake .. ${DEFS} \
				-DCMAKE_TOOLCHAIN_FILE=$APOTHECARY_DIR/toolchains/ios.toolchain.cmake \
				-DPLATFORM=$PLATFORM \
				-DENABLE_BITCODE=OFF \
				-DENABLE_ARC=OFF \
				-DENABLE_VISIBILITY=OFF \
				-DCMAKE_POSITION_INDEPENDENT_CODE=TRUE \
				-DBUILD_SHARED_LIBS=OFF \
				-DCMAKE_BUILD_TYPE=Release \
				-DCMAKE_CXX_FLAGS="-fPIC -DUSE_PTHREADS=1" \
				-DCMAKE_C_FLAGS="-fPIC -DUSE_PTHREADS=1" \
				-DCMAKE_INSTALL_PREFIX=Release \
				-DCMAKE_VERBOSE_MAKEFILE=${VERBOSE_MAKEFILE} \
				-DDEPLOYMENT_TARGET=${MIN_SDK_VER} \
				-DCMAKE_INCLUDE_OUTPUT_DIRECTORY=include \
				-DCMAKE_INSTALL_INCLUDEDIR=include \
				-DRTAUDIO_API_ASIO=OFF \
				-DRTAUDIO_BUILD_SHARED_LIBS=OFF \
				-DHAVE_GETTIMEOFDAY=ON \
				-DCMAKE_INSTALL_LIBDIR=lib \
				-DBUILD_TESTING=OFF
		cmake --build . --config Release --target install
		cd ..

	elif [ "$TYPE" == "vs" ] ; then
		echo "building rtAudio $TYPE | $ARCH | $VS_VER | vs: $VS_VER_GEN"
	    echo "--------------------"
	    GENERATOR_NAME="Visual Studio ${VS_VER_GEN}"
	    mkdir -p "build_${TYPE}_${PLATFORM}"
	    cd "build_${TYPE}_${PLATFORM}"
			rm -f CMakeCache.txt *.lib *.o
	    env CXXFLAGS="-DUSE_PTHREADS=1 ${VS_C_FLAGS} ${FLAGS_RELEASE}"
	    VS_DEFS="
	        -DAUDIO_WINDOWS_DS=ON \
	        -DAUDIO_WINDOWS_ASIO=ON \
	        -DAUDIO_WINDOWS_WASAPI=ON \
	        -DBUILD_SHARED_LIBS=OFF \
	        -DBUILD_TESTING=OFF \
	        -DRTAUDIO_STATIC_MSVCRT=OFF
	        "
	    cmake .. ${VS_DEFS} ${DEFS} \
	    	-UCMAKE_CXX_FLAGS \
	        -DCMAKE_CXX_FLAGS="-DUSE_PTHREADS=1 ${FLAGS_RELEASE} ${EXCEPTION_FLAGS}" \
	        -DCMAKE_CXX_FLAGS_RELEASE="-DUSE_PTHREADS=1 ${VS_C_FLAGS} ${FLAGS_RELEASE} ${EXCEPTION_FLAGS}" \
	        -DCMAKE_BUILD_TYPE=Release \
	        -DCMAKE_INSTALL_LIBDIR="lib" \
	        -DCMAKE_INSTALL_PREFIX=Release \
	        -DRTAUDIO_BUILD_SHARED_LIBS=OFF \
	        -DCMAKE_VERBOSE_MAKEFILE=${VERBOSE_MAKEFILE} \
	        ${CMAKE_WIN_SDK} \
	        -A "${PLATFORM}" \
	        -G "${GENERATOR_NAME}"

	    cmake --build . --config Release --target install
	    env CXXFLAGS="-DUSE_PTHREADS=1 ${VS_C_FLAGS} ${FLAGS_DEBUG}"
	    cmake .. ${VS_DEFS} ${DEFS}  \
	    	-UCMAKE_CXX_FLAGS \
	        -DCMAKE_CXX_FLAGS="-DUSE_PTHREADS=1 ${VS_C_FLAGS} ${EXCEPTION_FLAGS}" \
	        -DCMAKE_CXX_FLAGS_DEBUG="-DUSE_PTHREADS=1 ${VS_C_FLAGS} ${FLAGS_DEBUG} ${EXCEPTION_FLAGS}" \
	        -DCMAKE_BUILD_TYPE=Debug \
	        -DCMAKE_INSTALL_LIBDIR="lib" \
	        -DCMAKE_INSTALL_PREFIX=Debug \
	        -DCMAKE_VERBOSE_MAKEFILE=${VERBOSE_MAKEFILE} \
	        ${CMAKE_WIN_SDK} \
	        -A "${PLATFORM}" \
	        -G "${GENERATOR_NAME}"

	    cmake --build . --config Debug --target install

	    unset CXXFLAGS

	    cd ..
	elif [[ "$TYPE" =~ ^(linux|linux64|linuxarmv6l|linuxarmv7l|linuxaarch64)$ ]]; then
		# Compile the program
		mkdir -p build
		cd build
		rm -f CMakeCache.txt *.a *.o
		cmake .. ${DEFS} \
			-G "Unix Makefiles" \
			# -DAUDIO_WINDOWS_WASAPI=OFF \
			# -DAUDIO_WINDOWS_DS=OFF \
			# -DAUDIO_WINDOWS_ASIO=OFF \
			# -DRTAUDIO_API_OSS=ON \
			# -DRTAUDIO_API_ALSA=ON \
			# -DRTAUDIO_API_ALSA=OFF \
			# -DRTAUDIO_API_PULSE=ON \
			# -DRTAUDIO_API_JACK=ON \
			-DCMAKE_VERBOSE_MAKEFILE=${VERBOSE_MAKEFILE} \
			-DBUILD_TESTING=OFF
		make
		make install

	  # /inst
	elif [ "$TYPE" == "msys2" ] ; then
		# Compile the program
		mkdir -p build
		cd build
		rm -f CMakeCache.txt *.a *.o
		cmake .. ${DEFS} \
			-G "Unix Makefiles" \
			-DAUDIO_WINDOWS_WASAPI=ON \
			-DAUDIO_WINDOWS_DS=ON \
			-DAUDIO_WINDOWS_ASIO=ON \
			-DCMAKE_VERBOSE_MAKEFILE=${VERBOSE_MAKEFILE} \
			-DBUILD_TESTING=OFF
		make
		make install
	fi

	# clean up env vars
	# unset PKG_CONFIG PKG_CONFIG_PATH
}

# executed inside the lib src dir, first arg $1 is the dest libs dir root
function copy() {

	# headers
	mkdir -p $1/include
	cp -v RtAudio.h $1/include
	#cp -v RtError.h $1/include #no longer a part of rtAudio
	. "$SECURE_SCRIPT"
	# libs
	mkdir -p $1/lib/$TYPE
	if [ "$TYPE" == "vs" ] ; then
		mkdir -p $1/lib/$TYPE/$PLATFORM/
		cp -Rv build_${TYPE}_${PLATFORM}/Release/include/rtaudio/* $1/include/
    	cp -vf "build_${TYPE}_${PLATFORM}/Release/lib/rtaudio.lib" $1/lib/$TYPE/$PLATFORM/rtaudio.lib
    	#cp -vf "build_${TYPE}_${PLATFORM}/Release/bin/rtaudio.dll" $1/lib/$TYPE/$PLATFORM/rtaudio.dll
    	cp -vf "build_${TYPE}_${PLATFORM}/Debug/lib/rtaudiod.lib" $1/lib/$TYPE/$PLATFORM/rtaudioD.lib
		secure $1/lib/$TYPE/$PLATFORM/rtaudio.lib rtaudio
	elif [ "$TYPE" == "msys2" ] ; then
		cd build
		ls
		cd ../
		cp -v build/librtaudio.dll.a $1/lib/$TYPE/librtaudio.dll.a

	elif [ "$TYPE" == "osx" ] ; then
		mkdir -p $1/lib/$TYPE/$PLATFORM/
		cp -Rv build_${TYPE}_${PLATFORM}/Release/include/rtaudio/* $1/include/
    cp -vf "build_${TYPE}_${PLATFORM}/Release/lib/librtaudio.a" $1/lib/$TYPE/$PLATFORM/librtaudio.a
		secure $1/lib/$TYPE/$PLATFORM/librtaudio.a rtaudio
	fi

	# copy license file
	if [ -d "$1/license" ]; then
        rm -rf $1/license
    fi
	mkdir -p $1/license
	cp -v LICENSE $1/license/
}

# executed inside the lib src dir
function clean() {

	if [ "$TYPE" == "vs" ] ; then
		if [ -d "build_${TYPE}_${ARCH}" ]; then
		    # Delete the folder and its contents
		    rm -r build_${TYPE}_${ARCH}
		fi
	else
		make clean
	fi

	# manually clean dependencies
	#apothecaryDependencies clean
}

function load() {
    . "$LOAD_SCRIPT"
    LOAD_RESULT=$(loadsave ${TYPE} "rtaudio" ${ARCH} ${VER} "$LIBS_DIR_REAL/$1/lib/$TYPE/$PLATFORM" ${PLATFORM} )
    PREBUILT=$(echo "$LOAD_RESULT" | tail -n 1)
    if [ "$PREBUILT" -eq 1 ]; then
        echo 1
    else
        echo 0
    fi
}
