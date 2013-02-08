#ifndef ATLASSTYLE_H
#define ATLASSTYLE_H
#ifndef __CINT__
#include <TStyle.h>

TStyle * initialzieATLASStyle()
#endif
{
	#ifdef __CINT__
	gROOT->SetStyle("Plain");
	#endif
	
	TStyle * atlasStyle = new TStyle("atlasStyle", "ATLAS style for ROOT");
	std::cout << "Creating ATLAS style" << std::endl;
	
	atlasStyle->SetPalette(1);
	atlasStyle->SetOptStat(0);
	atlasStyle->SetOptFit(111);

	//set axis attribute
	atlasStyle->SetTitleSize(0.05,"X");
	atlasStyle->SetTitleSize(0.05,"Y");
	atlasStyle->SetTitleColor(1,"X");
	atlasStyle->SetTitleColor(1,"Y");
	atlasStyle->SetTitleOffset(1.0,"X");
	atlasStyle->SetTitleOffset(1.4,"Y");

	// Added to ATLAS style 7-27 by rehlers so title doesn't overlap axis labels
	atlasStyle->SetTitleX(0.2);
	//atlasStyle->SetTitleY(0.9);
	// Set title box height / width
	//atlasStyle->SetTitleW(); 
	//atlasStyle->SetTitleH();

	// Added to ATLAS style 11-12-12 by rehlers to enable title
	atlasStyle->SetOptTitle(1);
	atlasStyle->SetTitleTextColor(1);

	//set marker attribute
	atlasStyle->SetMarkerSize(1.0);
	atlasStyle->SetMarkerStyle(20);

	//
	atlasStyle->SetFillStyle(0);
	atlasStyle->SetLineColor(0);

	//
	//atlasStyle->SetTitleTextColor(2);
	atlasStyle->SetTitleStyle(0);


	//atlas style
	//use plain black on white colors
	atlasStyle->SetFrameBorderMode(0);
	atlasStyle->SetFrameFillColor(0);
	atlasStyle->SetCanvasBorderMode(0);
	atlasStyle->SetCanvasColor(0);
	atlasStyle->SetPadBorderMode(0);
	atlasStyle->SetPadColor(0);
	atlasStyle->SetStatColor(0);

	// set the paper & margin sizes
	atlasStyle->SetPaperSize(20,26);

	// Comment out the margin sizes to make the TPaletteAxis labels readable
	// set margin sizes
	atlasStyle->SetPadTopMargin(0.05);
	atlasStyle->SetPadRightMargin(0.05);
	atlasStyle->SetPadBottomMargin(0.16);
	atlasStyle->SetPadLeftMargin(0.16);

	// use large fonts
	atlasStyle->SetTextFont(42);

	atlasStyle->SetTextSize(0.05);
	atlasStyle->SetLabelFont(42,"x");
	atlasStyle->SetTitleFont(42,"x");
	atlasStyle->SetLabelFont(42,"y");
	atlasStyle->SetTitleFont(42,"y");
	atlasStyle->SetLabelFont(42,"z");
	atlasStyle->SetTitleFont(42,"z");

	atlasStyle->SetLabelSize(0.05,"x");
	atlasStyle->SetTitleSize(0.05,"x");
	atlasStyle->SetLabelSize(0.05,"y");
	atlasStyle->SetTitleSize(0.05,"y");
	atlasStyle->SetLabelSize(0.05,"z");
	atlasStyle->SetTitleSize(0.05,"z");

	// use bold lines and markers
	atlasStyle->SetMarkerStyle(20);
	atlasStyle->SetMarkerSize(1.2);
	atlasStyle->SetHistLineWidth(2);
	atlasStyle->SetLineStyleString(2,"[12 12]");

	// do not display any of the standard histogram decorations
	//atlasStyle->SetOptTitle(0);
	atlasStyle->SetOptStat(0);
	atlasStyle->SetOptFit(111);

	// put tick marks on top and RHS of plots
	atlasStyle->SetPadTickX(1);
	atlasStyle->SetPadTickY(1);
	
	#ifdef __CINT__
	gROOT->SetStyle("atlasStyle");
	#endif
	
	#ifndef __CINT__
	atlasStyle->cd();
	return atlasStyle;
	#endif
}

#endif /* ATLASSTYLE.h */
