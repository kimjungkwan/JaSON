#!/bin/sh
#
#   Copyright 2012 Shane Bell
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

if [ $# -eq 1 ]; then

	if [ -d build ]; then
		echo "Deleting old build directory...\c"
		rm -rf build
		echo "\t\t[DONE]"
	fi
	
	echo "Creating build directory...\c"
	mkdir build
	echo "\t\t[DONE]"
	
	echo "Compressing Javascript...\c"
	mkdir build/js
	java -jar tools/compiler.jar --js js/JaSON.js --js_output_file build/js/JaSON.min.js
	echo "\t\t[DONE]"
	
	echo "Updating references in HTML...\c"
	sed -e s/JaSON.js/JaSON.min.js/ JaSON.html > build/JaSON.html
	echo "\t\t[DONE]"
	
	echo "Copying build artifacts...\c"
	cp -r LICENSE NOTICE manifest.json css img js build/
	rm build/js/JaSON.js
	echo "\t\t[DONE]"
	
	echo "Building JaSON-$1 zip file...\c"
	cd build
    zip -q -r JaSON-$1.zip *
    cd ..
	echo "\t\t[DONE]"
    
    echo "\nBuild complete. JaSON-$1.zip contains the following files:\n"
    unzip -q -l build/JaSON-$1.zip
    
else
    echo "Usage: build version"
    echo " - builds a file called JaSON-version.zip"
fi

