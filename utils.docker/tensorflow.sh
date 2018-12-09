#!/bin/bash

echo "Detected GPU_SUPPORT $1"

# Make sure spaces are there between the condition and the square brackets
# otherwise will result in command not found
if [ $1 == 0 ] || [ -z $1 ]; then
	echo "User specified no GPU support. Installing TensorFlow CPU version"
	pip3 install tensorflow
else
	echo "User specified GPU support. Installing Tensorflow GPU version"
	pip3 install tensorflow-gpu
fi
