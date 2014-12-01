(* ::Package:: *)

(* ::Title:: *)
(*Weave Construction*)


(* ::Section:: *)
(*Weave Function*)


(* ::Text:: *)
(*To construct a basic weave (like a twill or an atlas) we just need to take a basic sequence, and shift it until we obtain the original sequence again.*)


weave[v_?VectorQ, shift_]:= Block[
	{
		n = Length[v] ,
		fn = RotateRight[#, shift]&
	},
	NestWhileList[fn,v,fn[# ]!= v&]
]


weave[n_Integer, s_Integer] := weave[PadRight[{1}, n, 0], s]


(* ::Subsubsection:: *)
(*Example*)


weave[{1,1,0,0},1] //MatrixForm 


weave[3,1] //MatrixForm 


(* ::Section:: *)
(*Plotting Weaves*)


(* ::Text:: *)
(*To plot a weave we can use the ArrayPlot function*)


Options[weavePlot] = { PixelSize-> 4, Padding-> 1};


weavePlot[weave_?MatrixQ, opts: OptionsPattern[]] :=Block[
	{
		pixelsize = OptionValue[PixelSize],
		padding =  OptionValue[Padding]
	},
	Framed[
		Image[
			1 - weave,
			Magnification-> pixelsize
		],
		Alignment->Center,
		FrameMargins->padding,
		Background-> White
	]
]


(* ::Input:: *)
(**)


(* ::Subsubsection:: *)
(*Example*)


(* ::Text:: *)
(*Here' s a simple Twill:*)


weave[5,1]  // weavePlot


(* ::Text:: *)
(*Here' s an Atlas:*)


weave[5,3] // weavePlot


(* ::Text:: *)
(*This is not a valid weave. Why?*)


weave[8,2] // weavePlot[#, PixelSize->10]&


(* ::Section:: *)
(*Twill Weaves*)


(* ::Text:: *)
(*Twills are obtained by shifting by one step per row.*)


(* ::Text:: *)
(*We define two functions :*)


(* ::Item:: *)
(*twillZ for right-slanted twills*)


(* ::Item:: *)
(*twillS for left-slanted ones.*)


twillS[v_?VectorQ] := Weave[v, 1]


twillZ[v_?VectorQ] := Weave[v, -1]


twillS[n_Integer]:= TwillS[ PadRight[{1}, n, 0]]


twillZ[n_Integer]:= TwillZ[ PadLeft[{1}, n, 0]]


(* ::Subsection:: *)
(*Examples*)


(* ::Input:: *)
(*twillS[{1,1,0,0,0}] // weavePlot*)


(* ::Input:: *)
(*twillZ[8] // weavePlot*)


(* ::Section:: *)
(*Exploring Weaves*)


(* ::Text:: *)
(*Let' s find all weaves that start from a sequence*)


allWeaves[v_?VectorQ] := Block[
{imax = Length[v]},
Table[weave[v, i], {i,imax - 1}] 
]


allWeaves[n_Integer] :=
Table[weave[n, i], {i, n - 1}] 


(* ::Subsection:: *)
(*Example*)


weavePlot /@ allWeaves[{1,1,0,0,1,1}]


weavePlot /@ allWeaves[6] 


 weavePlot /@ Select[allWeaves[10], SquareMatrixQ]


(* ::Section:: *)
(*Weave Tables*)


(* ::Subsubsection:: *)
(*Table of Weaves of up to 12 Shafts*)


Table[
	weavePlot[#, PixelSize-> 2]&/@ allWeaves[i], {i, 12}]  // Grid[#,
	Alignment->{Left, Top},
	Background-> LightGray,
	Frame-> All,
	FrameStyle -> White, 
	Spacings->{.5,.5}
]&


(* ::Text:: *)
(*This table still contains invalid weaves, since each weave must have at least one pick per column to create a working fabric. *)
(*This is only the case for those sequences where there is at least one pick per column, i.e. the number of columns and rows is equal. *)


(* ::Subsubsection:: *)
(*Weave Table Function*)


(* ::Text:: *)
(*Let's create a function, that finds the positions of elements that are squares, and use them to create a colored weavetable*)


Options[weaveTable] = 
	{ 
		CellColor ->  LightGray, 
		HighlightColor ->  White, 
		FrameStyle ->  Gray
	} ~ Join ~\[NonBreakingSpace]Options[weavePlot];


weaveTable[n_, opts : OptionsPattern[]]:= Block[

	{
		wopts,
		positions,
		coloring,
		cellColor = OptionValue[CellColor],
		highlight = OptionValue[HighlightColor],
		frameStyle = OptionValue[FrameStyle]
	},

	wopts = FilterRules[{opts}, Options[weavePlot]];

	(* function to find the positions of elements that fullfill a criterion *)
	positions[list_, crit_] := (Position[list, #] & /@ Select[list, crit])[[All,1,1]];

	(* draw all cells containing a square matrix in a differnt color *)
	coloring = Join @@ Table[
		positions[allWeaves[i], SquareMatrixQ] /. x_Integer :>  {i, x} -> highlight,
		{i, n}
	];

   (* draw the table of cells *)
	Table[weavePlot[#, wopts]&/@ allWeaves[i], {i, n}]  // Grid[#,

		Alignment->{Center, Top} ,
		ItemStyle->Opacity[.2],
		Frame-> All,
		FrameStyle -> frameStyle, 
		Spacings->{.5,.5},

		Background->{
			None,
			cellColor,
			coloring
		}
	]&
]


(* ::Subsubsection:: *)
(*Valid Weaves up to 8 Shafts*)


weaveTable[8]


(* ::Subsubsection:: *)
(*Valid Weaves up to 16 Shafts*)


weaveTable[16, PixelSize->2, HighlightColor-> Black, FrameStyle-> White]


(* ::Subsubsection:: *)
(*Valid Weaves up to 24 Shafts*)


weaveTable[24, PixelSize->1, HighlightColor-> Black, FrameStyle-> White]


(* ::Section:: *)
(*Valid Weaves*)


(* ::Text:: *)
(*Note: *)
(*Weaves are only valid if the width of the weave n and the shift s are not co-prime,*)
(*i.e they have no common factors.*)


(* ::Subsection:: *)
(*Table of Valid Weaves*)


(* ::Text:: *)
(*This is a very compact table of the table above.*)


Table[
	If[!CoprimeQ[shift, shaft] || shift >= shaft, 1, 0],
	{shaft, 128}, {shift, 128}
] // Image[#, Magnification->2]&


(* ::Subsection:: *)
(*Weave Explorer*)


With[

	{
		shafts = 120,
		pxl = 2,
		hslider = 25
	},

	With[
		{
			slidersize =  {pxl * shafts, hslider},
			textsize = {pxl * shafts, hslider},
			panesize = {pxl * shafts, pxl * shafts}
		},

		DynamicModule[
			{
				x = 1, 
				y = 8
			},
			
			Panel @\[NonBreakingSpace]Grid[

			(* Headline *)
			{
				{
					"", 
					TextCell["Weave Explorer", "Chapter"], 
					""
				},

			{

				(* Shaft Slider *)
				VerticalSlider[Dynamic[y], {shafts, 2, -1}, ImageSize-> Reverse @ slidersize],

				(* GUI *)
				ClickPane[
					Dynamic @ ArrayPlot[
						Table[
						
							If[!CoprimeQ[shift, shaft] || shift >= shaft, 
								If[shift == x|| shaft == y, 2, 0], 
								If[shift == x|| shaft == y, 10, 1]
							],
							{shaft, shafts}, 
							{shift, shafts}
						],
						Frame-> False,
						PixelConstrained->pxl
					],
					({x, y} = Round[ {#[[1]] / pxl, shafts - #[[2]]/ pxl}] )&
				],
				
				(* Weave *)
			
				Dynamic @ If[CoprimeQ[x, y] && y >= x, weavePlot[weave[y, x], PixelSize-> pxl], ""],
			
		

			},
				{
					"",

					(* Shift Slider *)
					Slider[Dynamic[x], {1, shafts, 1}, ImageSize-> slidersize ],

					(* Input Fields *)
					Row[{
						"Shafts:", InputField[Dynamic[y], ImageSize-> 25], Spacer[10],
						"Shift:", InputField[Dynamic[x], ImageSize-> 25]
						}, 
						Spacer[2], 
						ImageSize-> textsize, 
						Alignment -> Center
					]
				}
			}
		]
	]	
	]
]
