#!/bin/bash
srcdir=`dirname $0`
test -z "$srcdir" && srcdir=.

if [[ -z "$@" ]]; then
	configureVars="--prefix=$MYINSTALL"
else
	configureVars="$@"
fi

echo "Configure parameters: $configureVars"
echo "Running in directory: $PWD"

(cd $srcdir; aclocal; libtoolize --force; automake -a --add-missing; autoconf)

$srcdir/configure "$configureVars" 

