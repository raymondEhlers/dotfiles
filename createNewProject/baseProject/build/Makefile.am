# General configuration
AUTOMAKE_OPTIONS = foreign
ACLOCAL_AMFLAGS = -I m4

AM_LDFLAGS = -L$(libdir) `root-config --libs`
AM_CPPFLAGS = -I$(includedir) -I`root-config --incdir`
AM_CXXFLAGS = -Wall -Werror

# Executable parameters
bin_PROGRAMS = baseProject

baseProject_SOURCES = ../src/main.cc

#baseProject_LDADD = -lboost_program_options -lHEPUtilities
baseProject_LDADD = libBaseProject.la

# Library parameters
lib_LTLIBRARIES = libBaseProject.la

libBaseProject_la_includedir=$(includedir)

libBaseProject_la_include_HEADERS = ../src/baseProject.h

noinst_HEADERS = ../src/baseProjectLinkDef.h

#libBaseProject_la_LIBADD = -lHEPUtilities

libBaseProject_la_SOURCES = ../src/baseProject.cc

# Test library to ensure that it can be used successfully in Root
BUILT_SOURCES = testexternals.cc

noinst_PROGRAMS = testexternals

testexternals_LDADD = libBaseProject.la

testexternals.cc:
	echo "//*** this is a generated file. Do not commit, do not edit" > $@
	echo "int main()" >> $@
	echo "{" >> $@
	echo "  return 0;" >> $@
	echo "}" >> $@

# Create dictionary for the class
../src/baseProject_Dict.C: ../src/baseProject.h ../src/baseProjectLinkDef.h
	rootcint -f $@ -c $(DEFAULT_INCLUDES) $(AM_CPPFLAGS) $^

# clean up our created files in build area on make clean
clean-local:
	rm -f ../src/*Dict*
	rm -f testexternals*
