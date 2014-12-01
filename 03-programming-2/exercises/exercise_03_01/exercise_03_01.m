(* ::Package:: *)

(* ::Title:: *)
(*Working with Mathematica*)


(* ::Subsubsection:: *)
(*Create a sequence of directions*)


 directions = Table[ RandomInteger[3], {100}] 


(* ::Subsubsection:: *)
(*Create rules that map direction numbers to direction vectors*)


rules = { 0 -> {0,1}, 1-> {1,0}, 2-> {0,-1} , 3-> {-1,0}}


(* ::Subsubsection:: *)
(*Create a table of direction vectors*)


table = directions/. rules


(* ::Subsubsection:: *)
(*Accumulate them to a sequence of coordinates*)


coordinates = FoldList[Plus, {0, 0}, table]


(* ::Subsubsection:: *)
(*Plot the coordinates*)


 ListLinePlot[coordinates, AspectRatio->Automatic]


(* ::Subsubsection:: *)
(*Animate the Plot*)


Animate[
	ListLinePlot[
		coordinates[[1;;i]], 
		PlotRange->{{-10,10},{-10,10}}, 
		AspectRatio-> Automatic, 
		GridLines->Automatic
	],
	{i, 1, 50,1},
	AnimationRunning->False
]


(* ::Input:: *)
(**)


(* ::Subsubsection:: *)
(*Create an Interactive Demonstration*)


Manipulate[

	ListLinePlot[
	
		(* Plot all coordinates from 1 to i  *)
		coordinates[[1;;i]],

		(* use all kinds of options to customize our demo *)
		PlotRange -> 20 / zoom * {{-1,+1},{-1,+1}},
		AspectRatio-> Automatic,
		GridLines -> grid, 
		Axes -> axes,
		Background -> bg, 
		Frame -> frame,
		PlotStyle-> st
		
	],
	
	(* 
		The general syntax for manipulators is:
		{{name, default, label}, min, max, step}
	*)

	{{i, 50, "Steps"}, 1, 50,1},
	{{zoom, 10, "Zoom"}, 1, 20},

	(* We can also pass a list of values to pick from *)

	{{bg, White, "Background Color"}, {White, GrayLevel[0.3], Black}},
	{{st, Null, "Plot Style"}, {Null-> "Normal", AbsoluteThickness[10]-> "Fat"}},


	{{frame, False, "Show Frame"},  {True-> Yes, False-> No}},
	{{axes, False, "Show Axes"}, {True-> Yes, False-> No}},
	{{grid, Automatic, "Show Grid"}, {Automatic -> Yes, None-> No}},

	(* add the controls at the bottom of the demo *)

	ControlPlacement -> Bottom,

	(* you can also add a nice label like this *)

	FrameLabel-> {
		None, 
		None, 
		Pane[Style["Our First Demo", "Chapter"], {Automatic, 60}], 
		None
	}

]
