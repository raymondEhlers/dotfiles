#!/usr/bin/env bash
# Create a new c++ project with automake and the source files setup

localPathName="/home/ray/.dotfiles/createNewProject"

changeName ()
{
	# $1 = file, $2 = new name, $3 = new filename (bool) 
	if [[ -z "${1}" ]] || [[ -z "${2}" ]] || [[ -z "${3}" ]]
	then
		echo "Failed to pass sufficient options to changeName()"
		exit -1
	fi

	# Creates various cases
	newName="${2}"
	newNameUpperCase=$(echo "$newName" | tr '[:lower:]' '[:upper:]')
	newNameProperCase=${newName^}

	# Determines the correct new filename. If ${3} is false, then use the normal filename.
	# If true, then change the filename to use $newName
	if [[ "${3}" == false ]]
	then
		newFilename="${1}"
	else
		newFilename=$(echo "${1}" | sed -e "s/baseProject/${newName}/g")
	fi

	# Ensure that the new file is placed in the appropriate directory
	newFilename="$newName/$newFilename"

	sed -e "s/baseProject/${newName}/g" -e "s/BaseProject/${newNameProperCase}/g" -e "s/BASEPROJECT/${newNameUpperCase}/g" "$localPathName/baseProject/${1}" > "${newFilename}"
}

if [[ -z $1 ]]
then
	echo "Must give a project name"
	exit -1
fi

newName="${1}"

# Create the necessary directory structure
mkdir -p "${newName}/build"
mkdir -p "${newName}/build/m4"
touch "${newName}/build/m4/.keepInGit"
mkdir -p "${newName}/src"

# Relevant files are:
# configure.ac, Makefile.am, LinkDef.h (name only), baseProject.cc, baseProject.h

# Take care of the build directory
changeName build/Makefile.am "${newName}" false
changeName build/configure.ac "${newName}" false
ln -s "$localPathName/../autogen.sh" "${newName}/build/."

# Take care of the src directory
changeName src/baseProject.cc "${newName}" true
changeName src/baseProject.h "${newName}" true
changeName src/baseProjectLinkDef.h "${newName}" true
changeName src/main.cc "${newName}" false

# Take care of .gitignore when the git repo is created
ln -s "$localPathName/.gitignore" "${newName}/."
