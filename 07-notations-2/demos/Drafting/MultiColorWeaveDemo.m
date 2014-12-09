(* ::Package:: *)

(* ::Title:: *)
(*MultiColor Weave Demo*)


(* ::Text:: *)
(*Create a Random Weave*)


weave = Table[RandomInteger[], {10},{15}]


weave // ArrayPlot


(* ::Text:: *)
(*Create Random Color Sequences*)


weftColors =  Table[RandomChoice[{Blue, Lighter[Blue, .5]}], {10}]


warpColors =  Table[RandomChoice[{Red, Lighter[Red, .5]}], {15}]


colors = Table[{c1,c2},{c1, weftColors},{c2, warpColors}];


Image[MapThread[#2[[#1+1]]&,{weave,colors},2], ImageSize->Small]


(* ::Chapter:: *)
(*Color Draft*)


(* ::Subsection:: *)
(* Grid Drawing*)


DraftGrid[

	{threading_, treadling_, drawdown_, weave_}, 
	w1_, h1_, w2_, h2_, 
	OptionsPattern[{FrameThickness -> 8}]

] := Block[
	
	{ 
		frm = OptionValue[FrameThickness],

	 (* adding a frame around every single item *)
	  show = Framed[ Show[ ##]]&

	},

	Grid[

		{
			{ 
				show[threading, ImageSize-> {w1, h1}], 
				show[drawdown, ImageSize-> {h2, h1}]
			}, 
			{ 
				show[weave, ImageSize-> {w1, w2}], 
				show[treadling, ImageSize-> {h2, w2}]
			 }
		},

    
		FrameStyle -> Directive[AbsoluteThickness[frm], RGBColor[0.35,0.35,0.35]],
		Spacings ->  {1, 1} * frm / 20,
		Alignment -> {{Top, Top}, {Left, Left}},
		Frame ->  All,
		Background -> White

	]

]


(* ::Subsection:: *)
(*Draft Drawing*)


ColorDraft[weave_?MatrixQ,warpColors_?VectorQ, weftColors_?VectorQ]:= Block[

	{
		colors = Table[{c1,c2},{c1, weftColors},{c2, warpColors}],
		pxl = 12,
		img,
		w1, w2
	},

	(* dimensions *)
	w1 = Length[weave[[1]]] * pxl;
	w2 = Length[weave] * pxl;

	(* create colored weave image *)
	img = Image[ MapThread[#2[[#1+1]]&, {weave,colors},2] , ImageSize -> Medium];

	(* show it with draftgrid *)
	DraftGrid[{
			Image @ {warpColors},
			Image @ (List /@\[NonBreakingSpace]weftColors) ,
			Graphics[],
			img
		}, 
		w1, pxl, w2, pxl,
		FrameThickness -> pxl
	]

]


(* ::Section:: *)
(*Example*)


ColorDraft[weave, warpColors, weftColors]
