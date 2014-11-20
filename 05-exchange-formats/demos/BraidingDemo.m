(* ::Package:: *)

(* ::Title:: *)
(*Braiding Demo*)


(* ::Section:: *)
(*A Simple Cord*)


(* ::Text:: *)
(*Let' s assume that the flow of a cord is represented by a sequence of integers.*)


(* ::Subsection:: *)
(*Creating a Sequence*)


(* ::Text:: *)
(*Let' s create a randomly ordered sequence.*)
(*  Note that this sequence is different every time you run this package / notebook*)


seq = RandomSample[Range[6]]


(* ::Subsection:: *)
(* Drawing a Cord*)


(* ::Text:: *)
(*To draw the cord, we turn this the sequence into a continuous line, and display it as a graphic*)


cord[seq_]:= Block[
	{ pos2, fn},
	seq2 = Riffle[seq, seq] ;   (* take every list item twice *)
	fn[y_,{x_}]:=  {x,y};       (* function to turn the result of MapIndexed into coordinates *)
	MapIndexed[fn, seq2]        (* wrapping coordiantes into a line *)
]


showCord[seq_]:= Graphics @ Line @ cord[seq]


(* ::Text:: *)
(*Now drawing a cord is as simple as:*)


showCord[seq]


(* ::Subsection:: *)
(*Draw two Cords*)


(* ::Text:: *)
(*Showing a cord corresponding to a sequence and its mirror sequence.*)


Show @ { showCord[seq] , showCord[Reverse[seq]] }


(* ::Text:: *)
(*A braid function to show several cords together:*)


showBraid[seq_] := showCord /@ seq // Show


(* ::Section:: *)
(*A Braid of Cords*)


(* ::Subsection:: *)
(*Rotating the Cord Sequence*)


(* ::Text:: *)
(*In this example every cord sequence is obtained from rotating the original cord sequence.*)
(*This works nicely because every position occurs in the cord sequece exactly once.*)
(*The function below creates a table of totated cords:*)


rotateCord[seq_, n_] :=  Table[RotateRight[seq, i], {i, 0, n - 1}]


showBraid @ rotateCord[seq, 2]


Manipulate[showBraid @\[NonBreakingSpace]rotateCord[seq, n], {n, 1, Length[seq], 1}]


(* ::Subsection:: *)
(*Rotating Cord Positions*)


(* ::Text:: *)
(*Instead of modifying individual cord sequences, we may want to control the position of all the threads during a single braiding step. Here the braiding step n corresponds to the n'th element of each cord-sequence, or the column of our braiding matrix.*)
(*(Note the use of the Transpose function).*)


rotateBraid[seq_, n_] := Transpose @ Table[RotateRight[seq, i], {i, n}]


(* ::Text:: *)
(*We can create an infinitely long braid by rotating the cord positions continouosly.*)


showBraid @\[NonBreakingSpace]rotateBraid[seq, 20]


Manipulate[ Show[ showBraid[ rotateBraid[seq, n]], ImageSize->{600, 150}], {n, 1, 12}]


(* ::Subsection:: *)
(*A Random Braid*)


(* ::Text:: *)
(*Instead of rotating the braid positions, we can also randomize them...*)


randomBraid[seq_, n_] := (Transpose @ Table[RandomSample[seq], {i, n}])


showBraid @\[NonBreakingSpace]randomBraid[seq, 20] 


(* ::Text:: *)
(*Here' s an interactive version that lets you manipulate the number of cords and braiding steps:*)


 Manipulate[SeedRandom[0]; Show[ {showBraid @ randomBraid[Range[cords], n]}, ImageSize->{600, 200}], {cords, 2, 9},  {n, 1, 100}]


(* ::Subsection:: *)
(*Functional Braiding*)


(* ::Text:: *)
(*There is no need to hardcode the permutation function that generates the braid.*)
(*We can also pass the  function into our braid geneator like this:*)


functionBraid[seq_, fn_, n_: 20] :=  (Transpose @ NestList[fn, seq, n])


(* ::Text:: *)
(*Lets pass in a function that rotates the sequence to the right*)


showBraid @\[NonBreakingSpace]functionBraid[seq, RotateRight[#,1]&]


(* ::Text:: *)
(*Another one to rotate it to the left*)


showBraid @ functionBraid[seq, RotateLeft[#,1]&]


(* ::Text:: *)
(*Or pass in a function that randomizes the sequence*)


showBraid @ functionBraid[seq, RandomSample[#]&]


(* ::Text:: *)
(*Now let' s create a table of braids ...*)


fns = {
	RotateRight[#1, 1]&,
	RotateRight[#1, 2]&,
	RotateLeft[#1, 1]&,
	RotateLeft[#1, 2]&,
	RandomSample[#1]&
};


GraphicsColumn @  Outer[showBraid @ functionBraid[seq, #]& , fns]


(* ::Subsection:: *)
(*Flipping Cords*)


(* ::Text:: *)
(*The braids we created look very complex and messy because we cross several cords at a time ...*)
(*So how about creating a function that only flips two cords at a time?*)
(*To do this we just need to exchange their values:*)


cordFlip[seq_, crd_] :=  Block[
	{ 
		cord1 = crd, 
		cord2 = crd + 1 
	},
    seq /. {cord1 -> cord2, cord2 -> cord1}
]


(* ::Text:: *)
(*Here we are flipping the central cords:*)


showBraid @ functionBraid[seq, cordFlip[#, 3]&, 50]


(* ::Text:: *)
(*Okay, so this is a bit boring. *)
(*Let' s create a function that flips cords randomly ...*)


randomFlip[seq_] := cordFlip[seq, RandomInteger[{1, Length[seq] - 1}]]


showBraid @ functionBraid[Range[20], randomFlip, 50]


(* ::Subsection:: *)
(*Functional Cord Flipping*)


(* ::Text:: *)
(*Of course we may also want to control the sequence in which the cords are flipped ...*)
(*To be able to do this we need to extend our functionBraid to take a sequence of flips.*)


indexedFunctionBraid[seq_, fn_, idx_] := (Transpose @ FoldList[fn, seq, idx])


flippingBraid[idx_, n_] := indexedFunctionBraid[Range[n], cordFlip, idx]


(* ::Text:: *)
(*So to cross pairs of braids starting with the very first braid, we just need to pass in the range from 1 to 9*)


 showBraid @\[NonBreakingSpace]flippingBraid[Range[9], 10]


(* ::Text:: *)
(*We can easily create more complex braiding patterns by passing in nested ranges:*)


showBraid @ flippingBraid[Flatten @\[NonBreakingSpace]Range[Range[9]], 10]


(* ::Text:: *)
(*As always you can easily turn this into an interactive version using Manipulate*)


Manipulate[
	Show[
		showBraid [
			flippingBraid[Flatten @\[NonBreakingSpace]Range[Range[n - 1]], n]
		], 
		ImageSize->{600, 100}, 
		AspectRatio -> 1/6], {n, 2, 12}
	]


(* ::Section:: *)
(*Colorful Braids*)


(* ::Text:: *)
(*So far our braids look pretty unspectacular.*)
(*Let's change this!*)


(* ::Text:: *)
(*First let' s create a simple braid :*)


myBraid = flippingBraid[Range[9], 10];


(* ::Text:: *)
(*Here is the matrix form of our braid.*)
(*Each row corresponds to one thread:*)


myBraid // MatrixForm


(* ::Text:: *)
(*And this is what it looks like using the simple showBraid function*)


showBraid @\[NonBreakingSpace]myBraid


(* ::Text:: *)
(*Now let' s create some really nice and powerful drawing functions, that we can control using options!*)


(* ::Subsection:: *)
(*The ShowBraid  Function*)


(* ::Text:: *)
(*These are the default options:*)


Options[ShowBraid] = Join[
	{ 
		DrawingStyle -> Outline,
		Style -> {Lighter[Blue], AbsoluteThickness[8]}, 
		OuterStyle ->  {Black, AbsoluteThickness[12]},
		OuterCordStyles ->  {{}},
		CordStyles -> {{}},
		CurveStyle -> Straight
	}
	, Options[Graphics]
];


(* ::Text:: *)
(*The ShowBraid Function picks the appropriate style for each braid and shows it*)


ShowBraid[seq_, opts: OptionsPattern[]]:= Block[

	{
		(* getting various options values *)
		drawingStyle = OptionValue[DrawingStyle],
		style = OptionValue[Style],
        outerStyle = OptionValue[OuterStyle],
		cordStyles = OptionValue[CordStyles],
		curveStyle = OptionValue[CurveStyle],
		outerCordStyles = OptionValue[OuterCordStyles],
		
		(* filtering options for passing them on *)
		copts = FilterRules[{opts}, Options[ShowCord]],
		gopts = FilterRules[{opts}, Options[Graphics]],

		(* function to get the style for individual cords *)
		getCordStyle
	},
	
	getStyle[styles_, default_, {idx_}] := Block[
		{ n = Length[styles] },
		Flatten @\[NonBreakingSpace]{ default, styles[[ 1 + Mod[idx - 1, n] ]] } 
	];

	MapIndexed[ ShowCord[#1, Style -> getStyle[cordStyles, style, #2], OuterStyle -> getStyle[outerCordStyles, outerStyle, #2], copts ] &, seq] 
	// Show[#, gopts] &

]


(* ::Subsection:: *)
(*The ShowCord  Function*)


(* ::Text:: *)
(*Here we are using the same options we defined for ShowBraid:*)


Options[ShowCord] = Options[ShowBraid];


(* ::Text:: *)
(*Now we use the DrawingStyle option to let the user pick one of various rendering styles.*)


ShowCord[seq_, opts: OptionsPattern[]]:= Block[

		{
			style = Flatten @ { OptionValue[Style] },
			outerstyle =  Flatten @ { OptionValue[OuterStyle] },
			connect =  OptionValue[CurveStyle] /. { Curvy -> BSplineCurve, Straight -> Line }
		},

		drawingStyle /.  { 

			(* connecting all points with a single line or curve *)
			Line :>  Graphics @ {Sequence @@\[NonBreakingSpace]style, connect @ cord[seq]},

			(* drawing a thin line on top of a thicker line *)
			Outline :>  Graphics @ {  Sequence @@ outerstyle, connect @ cord[seq], Sequence @@\[NonBreakingSpace]style, connect @ cord[seq] },
			
			(* using the tube function to connect the points via a 3d tube *) 
			Tube :>  Graphics3D[ { Sequence @@\[NonBreakingSpace]style, Tube[connect @ ( cord[seq] /. {x_, y_ } ->  {x, y, 0}), 0.3] }, Lighting -> "Neutral"]
	
		}
			
	]


(* ::Subsection:: *)
(*Drawing Styles*)


(* ::Text:: *)
(*We have defined three different styles, the most simple one is the Line style:*)


ShowBraid[
	myBraid,
	DrawingStyle -> Line
] 


(* ::Subsection:: *)
(*CordStyles*)


(* ::Text:: *)
(*Here' s an example that assigns different styles to individual cords*)


ShowBraid[
	myBraid,
	CordStyles-> { Red, Lighter[Red, .3], Darker[Red, .3]}
] 


(* ::Subsection:: *)
(*CurveStyle*)


ShowBraid[
	myBraid,
	CurveStyle -> Curvy
] 


(* ::Subsubsection:: *)
(*OuterStyle*)


(* ::Text:: *)
(*We can use the OuterStyle option to change the style of the outline for each cord*)


Manipulate[
	ShowBraid[
		flippingBraid[Range[i], i + 1],   
		Style-> {Opacity[1], Black, AbsoluteThickness[4]},
		OuterStyle -> {Opacity[.5], Darker[Red], AbsoluteThickness[10]},
		Background -> White,
		PlotRangePadding -> 1
	],
	{i, 2, 10}
]


(* ::Subsubsection:: *)
(*Draw the cords as 3D tubes*)


ShowBraid[myBraid, DrawingStyle -> Tube, ImageSize -> {300,300}]


(* ::InheritFromParent:: *)
(**)


(* ::Subsubsection:: *)
(*Highlighting individual Cords*)


Manipulate[
	ShowBraid[
		flippingBraid[Range[n - 1], n],
		CordStyles -> ReplacePart[Table[White, {n}], Red, Min[i, n]],
		ImageSize -> {600, 200}
	],
	{n, 1, 10, 1},
	{i, 1, n, 1}
]
	


Manipulate[
	ShowBraid[
		flippingBraid[Range[n - 1], n],
		CordStyles -> ReplacePart[Table[White, {n}], Red, Min[i, n]],
		DrawingStyle -> Tube,
		Background -> GrayLevel[.4],
		ImageSize -> {400, 400}
	],
	{n, 2, 10, 1},
	{i, 1, n, 1}
]
	


(* ::Subsection:: *)
(*Using Color Schemes*)


Manipulate[
	ShowBraid[
		flippingBraid[Range[n-1], n],
		CordStyles -> Table[ColorData[c][i / n] , {i, n}],
		Background -> RGBColor[0.2, 0.2, 0.2],
		ImageSize -> {400, 200},
		PlotRangePadding -> 1
	],
	{c, ColorData["Gradients"]},
	{n, 2, 10, 1}
	
]
	


(* ::Section:: *)
(*Things to Do*)


(* ::Subsection:: *)
(*Compact Braids*)


(* ::Text:: *)
(*The flip operation allows us to create all possible braids, one thread crossing at a time.*)
(*But we might want more a compact braid representation, with several neigboring threads are crossing in parallel.*)


compactBraid = {{1, 2, 3}, {2, 1, 1}, {3, 4, 4}, {4, 3, 2}};
showBraid @ compactBraid


(* ::Subsection:: *)
(*Using the 3rd Dimension*)


(* ::Text:: *)
(*So far our braids are living in flatland. *)
(*They are crossing each other without moving move up or down.*)
(*Let's fix this, shall we?*)


(* ::Subsection:: *)
(*Braid Words*)


(* ::Text:: *)
(*Up to now we have been using flip sequences to create braids.*)
(*Let's add the direction of the flip to describe wich cord is on top!*)


(* ::Subsection:: *)
(*Braid Algebra*)


(* ::Text:: *)
(*Once we got a representation for braids, we want to be able to use the computer,*)
(*to generate, combine and modify braiding sequences.*)


(* ::Text:: *)
(*For example we might want operators to create repeats and mirror repeats like this:*)


longBraid = Flatten[Table[{#, Reverse[#]}, {3}]]& /@ compactBraid;
showBraid @ longBraid


(* ::Text:: *)
(*Opearators to combine braids side by side like this:*)


wideBraid = Join[ longBraid + 4, longBraid];
showBraid @ wideBraid


(* ::Text:: *)
(*Or even operators that create braids of braids ...*)


(* ::Subsection:: *)
(*Braid Embeddings*)


(* ::Text:: *)
(*So far we have just looked at flat braids.*)
(*We may also want to consider tubular braids and their embedding in space*)


(* ::Subsection:: *)
(*Braiding Trajectories*)


(* ::Text:: *)
(*We have abstracted the braiding process into discrete functions, using integers to denote positions and so on. We might want to have a look at representing the threads as continuous functions.*)
(**)
(*Periodic functions and cycloids can give rise to interesting braiding structures. *)
(*Trajectories made of piecewise circular arcs are used in braiding machines, and they also form the base for the braiding track diagram developed by Noemi Speiser. *)


(* ::Subsection:: *)
(*Braiding Diagrams*)


(* ::Text:: *)
(*We would like to create different kinds of output, such as pictures, animations, braid diagrams and so on...*)
