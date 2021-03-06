#!/bin/bash
#
# Wrapper script to unpack and build mrpt.
#
# Include files will be installed to ../include/.
# Library files will be installed to ../lib/.
#
# One mrpt.tar.gz file should be located in this directory.
tars=`ls mrpt.tar.gz | wc -l`;
if [ "$tars" -eq "0" ];
then
  echo "No source mrpt.tar.gz found in libraries/!"
  exit 1
fi

# Remove any old directory.
rm -rf mrpt/
mkdir mrpt/
tar -xzpf mrpt.tar.gz --strip-components=1 -C mrpt/

cd mrpt/
python3 setup.py build
PYVER=`python3 -c 'import sys; print("python" + sys.version[0:3])'`;
mkdir -p ../lib/$PYVER/site-packages/
PYTHONPATH=../lib/$PYVER/site-packages/ python3 setup.py install --prefix=../ -O2
