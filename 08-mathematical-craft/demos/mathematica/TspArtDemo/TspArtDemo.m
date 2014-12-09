(* ::Package:: *)

(* ::Title:: *)
(*TSP Art Demo*)


(* ::Section:: *)
(*Create a dithered image*)


(* ::Text:: *)
(*Get a small version of Lenna from the test mages*)


img =ImageResize[ExampleData[{"TestImage","Lena"}], 128]


(* ::Text:: *)
(*Convert it to grayscale *)


grayscale = ColorConvert[img, "Grayscale"]


(* ::Text:: *)
(*Convert it to monochrome using dithering*)


monochrome= Binarize @ ColorQuantize[grayscale,2, Dithering->True]


(* ::Input:: *)
(**)


(* ::Section:: *)
(*TSP Art*)


(* ::Text:: *)
(*Colors for foreground and background*)


{fgcolor, bgcolor} = Through @ {Lighter, Darker} @ Red


(* ::Subsection:: *)
(*Connecting White Pixels*)


(* ::Text:: *)
(*Get a list of white pixels*)


fgpos = PixelValuePositions[monochrome, 1];


(* ::Text:: *)
(*Let Mathematica find a tour through all the pixels*)


fgidx = Last @\[NonBreakingSpace]FindShortestTour @ fgpos;


(* ::Text:: *)
(*Now display the tour*)


Graphics[{fgcolor, Line[fgpos[[fgidx]]]}, ImageSize-> 256, Background-> bgcolor]


(* ::Subsection:: *)
(*Connecting Black Pixels*)


(* ::Text:: *)
(*Get a list of black pixels*)


bgpos = PixelValuePositions[monochrome, 0];


(* ::Text:: *)
(*Let Mathematica find a tour through all the pixels*)


bgidx = Last @\[NonBreakingSpace]FindShortestTour @ bgpos;


(* ::Text:: *)
(*Now display the tour*)


Graphics[{bgcolor, Line[bgpos[[bgidx]]]}, ImageSize-> 256, Background-> fgcolor]
