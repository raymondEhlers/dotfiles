#ifdef __CLING__
#include <iostream>
#endif

void rootLogon()
{
    // Set general build preferences. This only applies to ACLiC.
    // kTrue causes the build dir to be relative. This may break for dir path with spaces...
    // However, this should not be done when running with the train
    const char * etrainRoot = gSystem->Getenv("ETRAIN_ROOT");
    if (etrainRoot == 0)
    {
        std::cout << "Loading build preferences" << std::endl;
        gSystem->SetBuildDir("$PWD/build", kTRUE);
        //gROOT->ProcessLine(".exception");
    }

    const char * hostname = gSystem->Getenv("NERSC_HOST");
    // If NERSC_HOST is null, then we are not on pdsf, and the style should be loaded
    if (hostname == 0)
    {
        // Calling macro directly actually executes the style, rather than just loading it.
        // This is needed, as the file is not loaded directly anymore.
        //std::cout << "Loading readableStyle.h" << std::endl;
        //gROOT->Macro("readableStyle.h");
    }

    TString systemType = gSystem->GetFromPipe("uname -s");
    if (systemType != "")
    {
        //std::cout << "systemType: " << systemType << std::endl;
        // If on Mac OS X, need to load CGAL
        if (systemType == "Darwin")
        {
            std::cout << "On Mac OS X. Added /usr/local/lib to allow loading CGAL." << std::endl;
            gSystem->AddDynamicPath("/usr/local/lib");
            // Loads the library directly
            //gSystem->Load("/usr/local/lib/libCGAL");
        }
    }
    else
    {
        std::cout << "systemType is empty" << std::endl;
    }

    std::cout << "Loading retrieveObjects.h" << std::endl;
#ifdef __CLING__
    gROOT->ProcessLine(".L retrieveObjects.h");
#else
    gROOT->LoadMacro("retrieveObjects.h");
#endif
    std::cout << "Finishing loading startup macros" << std::endl;
}
