// This allows one to easily access specific types without having to write out a longer cast
// It is nothing more than a simple wrapper, but it will save me time.

// NOTE: Root is not consistent with its ability to handle namespaces, so I am just hiding it from
//  CINT in general.

#ifndef __CINT__
namespace HEPUtilities
{
#endif
    // This function is only needed if this file is loaded directly as a macro
    void retrieveObjects()
    {
        std::cout << "Funciton to conveniently retreive objects from a TList are now available." << std::endl;
    }

    TH1F * retrieveTH1F(TList * list, TString name)
    {
        return (dynamic_cast <TH1F *> (list->FindObject(name)));
    }

    TH2F * retrieveTH2F(TList * list, TString name)
    {
        return (dynamic_cast <TH2F *> (list->FindObject(name)));
    }

    TH1D * retrieveTH1D(TList * list, TString name)
    {
        return (dynamic_cast <TH1D *> (list->FindObject(name)));
    }

    TH2D * retrieveTH2D(TList * list, TString name)
    {
        return (dynamic_cast <TH2D *> (list->FindObject(name)));
    }

    THnSparseF * retrieveTHnSparseF(TList * list, TString name)
    {
        return (dynamic_cast <THnSparseF *> (list->FindObject(name)));
    }
#ifndef __CINT__
}
#endif
