# ifndef __CINT__
#include <iostream>

std::cout << "This file is not designed to be used outside of interactive Root" << std::endl;
std::cout << "Please reconsider your usage of this file" std::endl;

#endif
#ifdef __CINT__
// For some reason, it appears that rootLogon needs to be scoped (?)
{
	const char * hostname = gSystem->Getenv("NERSC_HOST");
	// If hostname is null, then we are not on pdsf, and the style should be loaded
	if (hostname == 0) 
	{
		std::cout << "Loading readableStyle.h" << std::endl;
		gROOT->LoadMacro("../include/readableStyle.h");		
	}
	else
	{
		if (!strcmp(hostname, "pdsf"))
		{
			std::cout << "Loading retreiveObjects.h" << std::endl;
			gROOT->LoadMacro("retreiveObjects.h");
		}
	}
	std::cout << "Finishing loading startup macros" << std::endl;
}
#endif
