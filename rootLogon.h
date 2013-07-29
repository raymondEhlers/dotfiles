#ifndef __CINT__
#include <iostream>

std::cout << "This file is not designed to be used outside of interactive Root" << std::endl;
std::cout << "Please reconsider your usage of this file" std::endl;

#endif
#ifdef __CINT__
// For some reason, it appears that rootLogon needs to be scoped (?)
{
	// Set general build preferences. This only applies to ACLiC.
	// kTrue causes the build dir to be relative. This may break for dir path with spaces...
	std::cout << "Loading build preferences" << std::endl;
	gSystem->SetBuildDir("$PWD/build", kTRUE);

	const char * hostname = gSystem->Getenv("NERSC_HOST");
	// If hostname is null, then we are not on pdsf, and the style should be loaded
	if (hostname == 0)
	{
		// Calling macro directly actually executes the style, rather than just loading it.
		// This is needed, as the file is not loaded directly anymore.
		std::cout << "Loading readableStyle.h" << std::endl;
		gROOT->Macro("readableStyle.h");
	}

	std::cout << "Loading retreiveObjects.h" << std::endl;
	gROOT->LoadMacro("retreiveObjects.h");

	std::cout << "Finishing loading startup macros" << std::endl;
}
#endif
