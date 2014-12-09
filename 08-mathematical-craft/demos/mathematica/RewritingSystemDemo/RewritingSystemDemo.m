(* ::Package:: *)

(* ::Title:: *)
(*Rewriting Systems Demo*)


(* ::Chapter:: *)
(*Simple Demo*)


Manipulate[
	Pane[
		Image[
			Nest[
				ArrayFlatten[#/.{
					0->{{1,1,1},{1,1,1},{1,1,1}},
					1->{{0,1,0},{1,0,1},{0,1,0}}
				}
			]&,{{1}},i],
		ImageSize -> d
		],
		{1,1} * 3^5 + 15,
		Scrollbars->True
	],

	{{i, 5,"iterations"},Range[6], Setter},
	{{d, 3^6, "zoom"},3^5,3^6}

]


(* ::Chapter:: *)
(*Advanced Demo*)


(* ::Section:: *)
(*Using Toggles*)


(* ::Subsection:: *)
(*Simple Toggle*)


(* ::Text:: *)
(*Click the little box!*)


{ Toggler[Dynamic[x], {0->Black,1-> White}], Dynamic[x]}


(* ::Subsection:: *)
(*Matrix Toggle*)


(* ::Text:: *)
(*Creating a 3 x 3 Matrix*)


mat = Table[RandomInteger[],{5},{5}]


(* ::Text:: *)
(*Click any of the little boxes!*)


{
	Array[ Toggler[Dynamic[mat[[##]]], {0-> Style["\[FilledSquare]", 30],1-> Style["\[EmptySquare]", 30]}]&,Dimensions[mat]]  //Grid[#, Spacings->{0,-1}]&, Dynamic[ MatrixForm[mat]]
}


(* ::Section:: *)
(*Matrix Setter*)


Options[MatrixSetter] = {
	BlackBox-> Graphics[{StrokeForm[Black],Black,Rectangle[]},ImageSize->12],
	WhiteBox->Graphics[{StrokeForm[Black],White,Rectangle[]},ImageSize->12]
};


MatrixSetter[dm: Dynamic[mat_], {min_?MatrixQ, max_?MatrixQ}, opts: OptionsPattern[] ] := 
Block[
	{
		black = OptionValue[BlackBox],
		white = OptionValue[WhiteBox] 
	},
	Row[{Array[ Toggler[Dynamic[mat[[##]]], {min[[##]]-> black,max[[##]]->white}]&,Dimensions[min]]  //Grid[#, Spacings->{-.2,-.2}]&}]
]


MatrixSetter[dm: Dynamic[mat_], {min_Integer, max_Integer,dim: {rows_Integer,cols_Integer}} ]:= 
	MatrixSetter[dm,{ConstantArray[min,dim], ConstantArray[max,dim]}]


(* ::Section:: *)
(*The Demo*)


DynamicModule[

	{
		mat0 ={{1,1,1},{1,1,1},{1,1,1}},
		mat1 ={{0,1,0},{1,0,1},{0,1,0}}
	},

	Manipulate[

		Pane[
			Image[
				Nest[ArrayFlatten[#/.{0->mat0,1->mat1}]&,{{1}},i],
				ImageSize -> d
			],
			Dynamic[ dp] * 3^5 
			(* + 15, Scrollbars \[Rule] True *)
		],

		(* Hiding the pane selector *)
		{{dp,{1,1}, "Pane"},{{1,1}-> "Small",{3,1}-> "Wide",{3,2}-> "Large", {3,3}-> "Huge"}, None},

		{{d, 3^6, "Size"},3^5,3^6, Manipulator, ImageSize-> 220},
		{{i, 5,"Steps"},Range[6],Manipulator, ImageSize->220},

		(*(* Column Layout *)
		{{rule1,{{1,1,1},{1,0,1},{1,1,1}} ,Style["\[FilledSquare] \[Rule] ", 20]},0,1,{3,3}, MatrixSetter [##]&},
		{{rule2,{{1,1,1},{1,1,1},{1,1,1}} , Style["\[EmptySquare] \[Rule] ", 20]},0,1, {3,3}, MatrixSetter[##]&}, *)

		(* Row Layout *)
		Row[{
			Spacer[20],Style["\[FilledSquare] \[Rule] ", 20], MatrixSetter[Dynamic[mat0], {0,1, {3,3}}],
			Spacer[20], Style["\[EmptySquare] \[Rule] ", 20], MatrixSetter[Dynamic[mat1], {0,1, {3,3}}]
		}],

		ControlPlacement->Bottom,

		(* Let the user change the pane size via bookmarks *)
		Bookmarks-> { 
			"Medium Pane":> (dp= {2,2}),
			"Large Pane":> (dp= {3,2})
		}
	]
]
