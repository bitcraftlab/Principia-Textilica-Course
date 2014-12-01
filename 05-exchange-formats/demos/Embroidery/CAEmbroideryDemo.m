(* ::Package:: *)

(* ::Title:: *)
(*CA Embroidery Demo*)


(* ::Section:: *)
(*Turtle Function*)


(* ::Text:: *)
(*Here is a function that takes a sequence of numbers and turns it into a turtle track.*)


turtle[seq_, OptionsPattern[{Angle -> Pi/3, Draw -> Line}]] := 

Block[

	{
		ang = N @ OptionValue[Angle],
		draw = OptionValue[Draw],
		x,y, a, fn
	},

	x = y = a= 0;
	fn[item_] :=( a+=ang * item; {x,y}+={Sin[a],Cos[a]});
	Graphics @ draw @ (fn/@ seq)

]


(* ::Subsection:: *)
(*How does it work?*)


(* ::Item:: *)
(*Our function uses options to pass it optional values for angles and line styles.*)


(* ::Item:: *)
(*We are making use of OptionsPattern to define options and their default values*)


(* ::Item:: *)
(*We are making use of OptionValue to get the values for those options inside the function body*)


(* ::Item:: *)
(*W are using N to calculate the numeric value of the angle, to speed up computation *)


(* ::Item:: *)
(*We are using a Block to keep variables local to our function*)


(* ::Item:: *)
(*The variables x and y are used to store the position of the turtle*)


(* ::Item:: *)
(*The variable a is used to store the walking direction of the turtle*)


(* ::Item:: *)
(* fn is a function*)


(* ::Item:: *)
(*We are combining several experessions inside  fn using a CompoundExpression*)
(*Only the very last expression is returned as a result.*)


(* ::Item:: *)
(*We map the function to the seqeunce to create a list of turtle coordinates.*)


(* ::Item:: *)
(*During every mapping step the local variables are updated.*)
(*In imperative programming languages you would probably use a for loop here.*)


(* ::Item:: *)
(*We use the curve function to connect the coordinates*)


(* ::Item:: *)
(*In the end we wrap it all up with Graphics to show the result*)


(* ::Subsection:: *)
(*Random Walk*)


(* ::Text:: *)
(*Let's start with a random sequence of 0s and 1s:*)


randomSeq = Table[RandomInteger[1], {500}];
turtle @randomSeq


(* ::Subsection:: *)
(*Turtle Gui*)


(* ::Text:: *)
(*Let' s create an interactive version of this:*)


turtleGui[seq_, opts___] := Manipulate[
	Show[turtle[ seq[[1;;i]], opts], ImageSize->{300,300}],
	{{i,Length[seq], "step"} , 1,Length[seq],1}
]


turtleGui @ randomSeq


(* ::Subsection:: *)
(*Questions*)


(* ::Item:: *)
(*Which direction does the turtle walk?*)


(* ::Item:: *)
(*Why?*)


(* ::Subsection:: *)
(*Another Random Walk*)


(* ::Text:: *)
(*This is what we get when we use a random sequence of  - 1 to 1:*)


randomSeq2 = Table[RandomInteger[{-1,1}], {500}];
turtleGui @ randomSeq2


(* ::Section:: *)
(*Turtle Options*)


(* ::Subsubsection:: *)
(*Angle Option*)


turtle[randomSeq2, Angle-> Pi/2]


(* ::Subsection:: *)
(*Turtle Gui Updated*)


(* ::Text:: *)
(*Let' s add a slider for the angle to our Interface*)


turtleGui[seq_, opts___] := Manipulate[
	Show[turtle[ seq[[1;;i]], Angle-> a,opts], ImageSize->{300,300}],
		{{i,Length[seq], "step"} , 1,Length[seq],1},
		{{a, Pi/3, "angle"}, 0, Pi}
]


turtleGui @ randomSeq2


(* ::Subsubsection:: *)
(*Draw Option*)


(* ::Text:: *)
(*We can pass in any drawing function we like using the Draw option.*)


turtle[randomSeq2, Draw->  Point]


(* ::Text:: *)
(*If we want to connect the coordinates using curves we can do so using the BSplineCurve or BezierCurve.*)


turtle[randomSeq2, Draw->  BSplineCurve ]


(* ::Text:: *)
(*We can also pass in our own functions.*)
(*Here is an example with a pure function created on the fly:*)


turtle[randomSeq2, Draw-> Function[e, {Dashed, Red, Line[e]}]]


(* ::Section:: *)
(*Stipple Magic*)


(* ::Text:: *)
(*If we want to create an actual running stitch curve, where each stitch has a different color, we must split the sequence into parts and apply different functions to each of them.*)


(* ::Text:: *)
(*Let' s write a little function that takes a number of other functions and creates a single new function out of them. This newly created function will split up the list and apply the functions we passed in to the individual parts of it.*)


stipple[fns__]:=
	Function[seq,
	MapIndexed[#1 /@ Extract[Partition[seq, 2,1],Table[{i},{i,#2[[1]],Length[seq]-1,Length[{fns}]}]]&, {fns}]
]


(* ::Text:: *)
(*Here is a simple example of how it works:*)


stipple[aa,bb] @ {pt1, pt2, pt3, pt4, pt5}


(* ::Text:: *)
(*Here' s an Example that uses points and lines in alternation*)


turtle[randomSeq2, Draw->stipple[Point, Line]]


(* ::Text:: *)
(*And here a running stitch curve where the thread on the backside is shown in light gray:*)


turtle[randomSeq2, Draw->stipple[{LightGray,Line[#]}&, {Black ,Line[#]}&]]


(* ::Subsection:: *)
(*Turtle Gui Updated*)


turtleGui[seq_, opts:OptionsPattern[{Angle -> Pi/3, Draw ->  Line}]] := 

	With[

		{

			(* first let's define some stippling functions *)
			Stipple = stipple[Line, Null&],
			Stipple2 = stipple[Line, Point],
			Stipple3 = stipple[{LightGray,Line[#]}&, {Black ,Line[#]}&],

			(* we might want to pass in the angle as starting value *)
			ang = OptionValue[Angle],
			draw= OptionValue[Draw]
		},

		With[

			{ 
	
			(* create a list of functions and labels that we pass to the gui *)

				drawfns =  {
					Line -> "Linie",
					Point,
					Stipple -> "Stipple",
					Stipple2 -> "Stipple 2",
					Stipple3 ->  "Stipple 3",
					BezierCurve-> "Bezier",
					BSplineCurve-> "Splines",
					draw -> "Custom"
				}
			},
	
		(* create the actual gui *)

			Manipulate[
				Show[
					turtle[ seq[[1;;i]], Angle-> a,Draw-> d,opts], ImageSize->{300,300}],
					{{i,Length[seq], "step"} , 1,Length[seq],1},
					{{a, ang, "angle"}, 0, Pi},
					{{d,draw, "draw"}, drawfns, PopupMenu}
				]
			]
		]


turtleGui @ randomSeq


(* ::Section:: *)
(*Sequence Embroidery*)


(* ::Text:: *)
(*Let' s create a cellular automaton.*)


ca =CellularAutomaton[90,{{1},0},32];


(* ::Text:: *)
(*The CA is just a matrix filled with 0 s and 1 s.*)
(*We can display it as an image:*)


Image[ca]


(* ::Text:: *)
(*There is some structure in the CA.*)
(*So what happens if we turn the data into a sequence and pass it to the turtle?*)


turtleGui[\[NonBreakingSpace]Flatten[ca /. 0 -> -1]]


(* ::Text:: *)
(*That looks interesting. *)
(*Let's create a dynamic version to see what the other cellular automata look like!*)


turtleCA[rule_, init_, generations_, opts: OptionsPattern[]]:= Block[
	{ ca = 2 * CellularAutomaton[rule ,init , generations] - 1 },
	GraphicsGrid[
		{{
			Image[ca], 
			turtle[Flatten[ca], opts] 
		}},
		ImageSize->Large,
		Background->White,
		Frame -> All
	]	
]


(* ::Subsection:: *)
(*Rule 110*)


turtleCA[110, {{1}, 0}, 200, Angle-> Pi/3]


(* ::Section:: *)
(*CA Sequence Explorer*)


SetOptions[Slider, ImageSize-> 100];


Manipulate[

	ca = CellularAutomaton[rule, ArrayPad[{1}, cols] ,{steps}];
	seq = Flatten @ ca /. 0-> -1;
	drawfns = {
		stipple[Line, Null&] -> "Stipple Front",
		stipple[Null&, Line] -> "Stipple Back",
		Line, 
		BSplineCurve -> "Curve"
	};

	Row[{
		Show[Image[ca], ImageSize-> {300,200}, Background-> LightGray],
		Show[turtle[seq, Angle-> a, Draw-> d], ImageSize-> {300,200}]
	}],

	Grid[{{
		Control[{{rule, 99, "Rule"}, Manipulator[#, {0, 255, 1}, ImageSize->200]&}],
		Control[{{d, stipple[Line, Null&], "Draw"},PopupMenu[#, drawfns,ImageSize->200]&}]
	},
	{
		Control[{{cols, 10, "Columns"}, Manipulator[#, {1, 100, 1}, ImageSize->200]&}],
        Control[{{a, Pi/3, "Angle"}, Manipulator[#, { 0, Pi},ImageSize->200]&}]
	},{
       Control[{{steps, 20, "Steps"}, Manipulator[#, {0, 100, 1}, ImageSize->200]&}],
	   Control[{{a, Pi/4, "Angles"}, RadioButtonBar[#, { Pi/6, Pi/5, Pi/4, Pi/3, Pi/2, Pi*2/3 }]&}]
		
	}}, Spacings-> 10]
]
	
