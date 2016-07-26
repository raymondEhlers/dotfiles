#ifndef READABLESTYLE_H 
#define READABLESTYLE_H 

// Doesn't seem to work well for ROOT 6...

// Useful information here (apparently based on it?): http://svn.cern.ch/guest/lhcb/Erasmus/trunk/TrigCalib/TrigPerfScripts/scripts/lhcbstyle.C

#ifndef __CINT__
#include <TStyle.h>
#include <iostream>

TStyle * readableStyle()
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

    // We only want to change the Palette for ROOT5. ROOT 6 looks much better
#if ROOT_VERSION_CODE < ROOT_VERSION(6,0,0)
	// Set basic B/W color scheme for dressing elements (ie the actual data colors is set when plotting)
	readableStyle->SetPalette(1);
#endif

	// Remove ugly background
	readableStyle->SetFillStyle(0);

	// Do not display any of the standard histogram decorations
	readableStyle->SetOptStat(0);
	//readableStyle->SetOptFit(111);

	// Use plain black on white colors
	readableStyle->SetFrameBorderMode(0);
	readableStyle->SetFrameFillColor(0);
	readableStyle->SetCanvasBorderMode(0);
	readableStyle->SetCanvasColor(0);
	readableStyle->SetPadBorderMode(0);
	readableStyle->SetPadColor(0);
	readableStyle->SetStatColor(0);

	// Use bold markers
	readableStyle->SetMarkerStyle(kFullCircle);
	readableStyle->SetMarkerSize(1.2);

	// Use bold lines for hist
	readableStyle->SetHistLineWidth(2);

	// Comment out the margin sizes to make the TPaletteAxis labels readable
	// Set margin sizes
	readableStyle->SetPadTopMargin(0.10);
	readableStyle->SetPadRightMargin(0.10);
	readableStyle->SetPadBottomMargin(0.10);
	//readableStyle->SetPadBottomMargin(0.16);
	readableStyle->SetPadLeftMargin(0.10);
	//readableStyle->SetPadLeftMargin(0.16);

	// Title properties
	// Positioning
	readableStyle->SetTitleX(0.4);
	readableStyle->SetTitleY(0.975);
	// Removes ugly box around title
	readableStyle->SetTitleStyle(0);
	// Remove box around title
	readableStyle->SetLineColor(0);
	
	// Doesn't seem to have an effect. It would presumably on the title?
	readableStyle->SetTextFont(42);
	readableStyle->SetTextSize(0.04);
	
	// Axis properties
	// 42 = A thinner, more readable font
	readableStyle->SetLabelFont(42,"xyz");
	readableStyle->SetTitleFont(42,"xyz");
	// Label = axis labels (ie numbers), title = axis label (ie units)
	readableStyle->SetLabelSize(0.04,"xyz");
	readableStyle->SetTitleSize(0.04,"xyz");
	// Offset from edge of plot
	readableStyle->SetTitleOffset(1.0,"x");
	readableStyle->SetTitleOffset(1.2,"y");

	#ifdef __CINT__
	gROOT->SetStyle("readableStyle");
	#endif
	
	#ifndef __CINT__
	readableStyle->cd();
	return readableStyle;
	#endif
}

#endif /* readableStyle.h */
