#!/bin/bash
###################################################

# test name
NAME="0.configure.parallel_make"

# configuration parameters
CONF_PARAM=""

###################################################


testdir=`pwd`

# sets source directory
cd $ROOT/
srcdir=`pwd`

cd $testdir/

# title
echo >> $testdir/results.log
echo "$NAME in: $testdir" >> $testdir/results.log
echo >> $testdir/results.log

#cleanup
rm -rf config.log config.status
rm -rf ./bin ./obj ./setup ./OUTPUT_FILES ./DATA

# configuration
# (out-of-source compilation)
echo "configuration: $srcdir/configure ${CONF_PARAM}" >> $testdir/results.log
$srcdir/configure ${CONF_PARAM} >> $testdir/results.log 2>&1

# checks exit code
if [[ $? -ne 0 ]]; then
  echo >> $testdir/results.log
  echo "configuration failed, please check..." >> $testdir/results.log
  exit 1
fi

# default all compilation
make clean >> $testdir/results.log 2>&1

# checks exit code
if [[ $? -ne 0 ]]; then
  echo >> $testdir/results.log
  echo "compilation failed, please check..." >> $testdir/results.log
  exit 1
fi

# parallel make
make -j 4 all >> $testdir/results.log 2>&1

# checks exit code
if [[ $? -ne 0 ]]; then
  echo >> $testdir/results.log
  echo "compilation failed, please check..." >> $testdir/results.log
  exit 1
fi

echo "" >> $testdir/results.log
echo "successful compilation" >> $testdir/results.log

