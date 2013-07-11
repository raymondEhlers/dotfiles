#ifndef READABLESTYLE_H 
#define READABLESTYLE_H 

#ifndef __CINT__
#include <TStyle.h>
#include <iostream>

TStyle * initialzieReadableStyle()
#endif
{
	#ifdef __CINT__
	gROOT->SetStyle("Plain");
	#endif
	
	TStyle * readableStyle = new TStyle("readableStyle", "Readable style for ROOT");

	// Yes, Root cannot handle the first std::. Worse, this only happens when this file is not loaded
	// into rootlogon directly. If it is loaded directly, it is fine...
	#ifndef __CINT__
	std::cout << "Creating readable style" << std::endl;
	#else
	cout << "Creating readable style" << std::endl;
	#endif

	readableStyle->SetPalette(1);
	readableStyle->SetOptStat(0);
	readableStyle->SetOptFit(111);

	//set axis attribute
	readableStyle->SetTitleSize(0.05,"X");
	readableStyle->SetTitleSize(0.05,"Y");
	readableStyle->SetTitleColor(1,"X");
	readableStyle->SetTitleColor(1,"Y");
	readableStyle->SetTitleOffset(1.0,"X");
	readableStyle->SetTitleOffset(1.4,"Y");

	// Added to style 7-27-2012 by rehlers so title doesn't overlap axis labels
	readableStyle->SetTitleX(0.2);
	//readableStyle->SetTitleY(0.9);
	// Set title box height / width
	//readableStyle->SetTitleW(); 
	//readableStyle->SetTitleH();

	// Added to style 11-12-12 by rehlers to enable title
	readableStyle->SetOptTitle(1);
	readableStyle->SetTitleTextColor(1);

	//set marker attribute
	readableStyle->SetMarkerSize(1.0);
	readableStyle->SetMarkerStyle(20);

	//
	readableStyle->SetFillStyle(0);
	readableStyle->SetLineColor(0);

	//
	//readableStyle->SetTitleTextColor(2);
	readableStyle->SetTitleStyle(0);

	// Use plain black on white colors
	readableStyle->SetFrameBorderMode(0);
	readableStyle->SetFrameFillColor(0);
	readableStyle->SetCanvasBorderMode(0);
	readableStyle->SetCanvasColor(0);
	readableStyle->SetPadBorderMode(0);
	readableStyle->SetPadColor(0);
	readableStyle->SetStatColor(0);
	
	// Set hist stat box size
	readableStyle->SetStatW(.1);
	readableStyle->SetStatH(.1);

	// set the paper & margin sizes
	readableStyle->SetPaperSize(20,26);

	// Comment out the margin sizes to make the TPaletteAxis labels readable
	// set margin sizes
	readableStyle->SetPadTopMargin(0.05);
	readableStyle->SetPadRightMargin(0.05);
	readableStyle->SetPadBottomMargin(0.16);
	readableStyle->SetPadLeftMargin(0.16);

	// use large fonts
	readableStyle->SetTextFont(42);

	readableStyle->SetTextSize(0.05);
	readableStyle->SetLabelFont(42,"x");
	readableStyle->SetTitleFont(42,"x");
	readableStyle->SetLabelFont(42,"y");
	readableStyle->SetTitleFont(42,"y");
	readableStyle->SetLabelFont(42,"z");
	readableStyle->SetTitleFont(42,"z");

	readableStyle->SetLabelSize(0.05,"x");
	readableStyle->SetTitleSize(0.05,"x");
	readableStyle->SetLabelSize(0.05,"y");
	readableStyle->SetTitleSize(0.05,"y");
	readableStyle->SetLabelSize(0.05,"z");
	readableStyle->SetTitleSize(0.05,"z");

	// use bold lines and markers
	readableStyle->SetMarkerStyle(20);
	readableStyle->SetMarkerSize(1.2);
	readableStyle->SetHistLineWidth(2);
	readableStyle->SetLineStyleString(2,"[12 12]");

	// do not display any of the standard histogram decorations
	//readableStyle->SetOptTitle(0);
	readableStyle->SetOptStat(0);
	readableStyle->SetOptFit(111);

	// put tick marks on top and RHS of plots
	readableStyle->SetPadTickX(1);
	readableStyle->SetPadTickY(1);
	
	#ifdef __CINT__
	gROOT->SetStyle("readableStyle");
	#endif
	
	#ifndef __CINT__
	readableStyle->cd();
	return readableStyle;
	#endif
}

#endif /* readableStyle.h */
