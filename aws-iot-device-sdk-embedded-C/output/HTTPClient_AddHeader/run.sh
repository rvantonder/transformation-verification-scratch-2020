#!/bin/bash


# ordinary
echo 'base branch f2bde65aa7334de6dc3722ff5f87de5072d23cf'
git checkout f2bde65aa7334de6dc3722ff5f87de5072d23cf6
make clean
time make result &> time-base-branch.txt

# patched
echo 'assert_then_assume patched'
git checkout assert_then_assume
make clean
time make result &> time-assert-then-assume.txt

# comby patched
echo 'comby patched'
git checkout f2bde65aa7334de6dc3722ff5f87de5072d23cf6
echo 'checkout f2bde'
echo 'chdir'
pwd
cd ../../../../../../
comby ' assert(:[cond]);' ' assert(:[cond]); __CPROVER_assume(:[cond]);' .c -stats -i
cd -
echo 'chdir'
pwd
make clean
time make result &> time-comby-patch.txt
cd ../../../../../../
git restore \*
cd -
