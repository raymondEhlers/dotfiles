// This allows one to easily access specific types without having to write out a longer cast
// It is nothing more than a simple wrapper, but it will save me time.

namespace HEPUtilities
{
	// This function is only needed if this file is loaded directly as a macro
	void retreiveObjects()
	{
		std::cout << "Funciton to conveniently retreive objects from a TList are now available." << std::endl;
	}

	TH1F * retreiveTH1F(TList * list, TString name)
	{
		return (dynamic_cast <TH1F *> (list->FindObject(name)));
	}

	TH2F * retreiveTH2F(TList * list, TString name)
	{
		return (dynamic_cast <TH2F *> (list->FindObject(name)));
	}

	TH1D * retreiveTH1D(TList * list, TString name)
	{
		return (dynamic_cast <TH1D *> (list->FindObject(name)));
	}

	TH2D * retreiveTH2D(TList * list, TString name)
	{
		return (dynamic_cast <TH2D *> (list->FindObject(name)));
	}

	THnSparseF * retreiveTHnSparseF(TList * list, TString name)
	{
		return (dynamic_cast <THnSparseF *> (list->FindObject(name)));
	}
}

// Should this be located below, when retreiveObjects is actually being called? Almost certainly not, but
// I wouldn't be doing this unless wasn't rather obnoxious in the first place...
#ifdef __CINT__
using namespace HEPUtilities;
#endif

