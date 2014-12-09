(* ::Package:: *)

(* ::Title:: *)
(*Drafting Demo *)


(* ::Section:: *)
(*Draft Grid*)


(* ::Text:: *)
(*Arrange all four parts of a weaving draft inside a grid*)


DraftGrid[

	{threading_, treadling_, drawdown_, weave_}, 
	w1_, h1_, w2_, h2_, 
	OptionsPattern[{FrameThickness -> 8}]

] := Block[
	
	{ 
		frm = OptionValue[FrameThickness]
	},

	Grid[

		{
			{ 
				Show[threading, ImageSize-> {w1, h1}], 
				Show[drawdown, ImageSize-> {h2, h1}]
			}, 
			{ 
				Show[weave, ImageSize-> {w1, w2}], 
				Show[treadling, ImageSize-> {h2, w2}]
			 }
		},

    
		FrameStyle -> Directive[AbsoluteThickness[frm], RGBColor[0.35,0.5,0.75]],
		Spacings ->  {1, 1} * frm / 20,
		Alignment -> {{Top, Top}, {Left, Left}},
		Frame ->  All

	]

]


(* ::Subsection:: *)
(*Example*)


(* ::Text:: *)
(*This is a simple example showing how the layout works*)


DraftGrid[
	Graphics[Text[#]]& /@ { "Threading", Rotate["Treadling", - Pi/2], "Drawdown", "Weave"}, 
	150, 40, 200, 60,
	FrameThickness -> 2
]


(* ::Section:: *)
(*Sequence Draft*)


Options[SequenceToMatrix] = {Alphabet-> None, Direction -> Right};


SequenceToMatrix[seq_, opts: OptionsPattern[]] := Block[
	{ 
		m = Length @ seq,
		n = Length @ Tally @ seq,
		alphabet = OptionValue[Alphabet],
		direction = OptionValue[Direction],
		elements,
		mat
	},
	
	(* get elements from the alphabet or the sequence *)
	elements = If[alphabet =!= None, alphabet, Union[seq]];

	(* add 1s to the matrix where appropriate *)
	mat = Table[If[seq[[x]] === y, 1, 0] , {x, m}, {y, elements}];

	(* possibly rotate the matrix *)
	(direction /. { 
			Down -> #,
			Up -> Reverse @ #,
			Right -> Reverse[Transpose[#]]
	})& @ mat

]


(* ::Subsection:: *)
(*Examples*)


SequenceToMatrix[{1,1,1,2,3,1,1,1}] // MatrixForm 


(* ::Text:: *)
(*Defining a Draftform*)


DraftForm[mat_, OptionsPattern[{PixelSize->8}]] := 
	ArrayPlot[mat, PixelConstrained -> OptionValue[PixelSize],  Frame-> False]


(* ::Text:: *)
(*Now we can turn a treadling sequence into a draft*)


SequenceToMatrix[{1,1,1,4,3,2,1,1,1}] // DraftForm


(* ::Text:: *)
(*Now we can turn a treadling sequence into a draft*)


SequenceToMatrix[{1,1,1,4,3,2,1,1,1}, Direction-> Down] // DraftForm


SequenceToMatrix[{1,1,1,4,3,2,1,1,1}, Direction-> Up] // DraftForm


SequenceToMatrix[{b,a,c,h,b,a,c,h},  Alphabet-> {a,b,c,h}] // DraftForm


(* ::Section:: *)
(*Weaving Draft*)


WeavingDraft[threading_?VectorQ, treadling_?VectorQ, tieup_?MatrixQ, opts: OptionsPattern[{PixelSize->4}]] := Block[

	{

		(* drafts *)
		mthreading = SequenceToMatrix[threading, Direction-> Right],
		mtreadling = SequenceToMatrix[treadling, Direction-> Up],
		
		(* dimensions *)
		w1, h1,
		w2, h2,

		pxl = OptionValue[PixelSize]

	},

	w1 = Length[threading] * pxl;
	h1 = Length[tieup] * pxl ;
	
	w2 = Length[treadling] * pxl;
	h2 = Length[tieup[[1]]] * pxl;

	DraftGrid[
		DraftForm[#, PixelSize-> pxl]& /@\[NonBreakingSpace]{
			mthreading,
			mtreadling,
			tieup,
			mtreadling . Transpose[tieup] . mthreading
		}, 
		w1, h1, w2, h2,
		FrameThickness -> pxl
	]

]


seq1 = {1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4};
seq2 = {1,2,3,4,5,6,7,1,2,3,4,5,6,7};
mat = SequenceToMatrix[{1,2,3,4,3,2,1}];


WeavingDraft[seq1, seq2, mat, PixelSize-> 12] 


(* ::Section:: *)
(*Interactive*)


(* ::Text:: *)
(*Interpret strings as numbers base 32, so we can write sequences for up to 36 shafts / treadles*)
(*(Digits 1,2,3 ... x,y,z)*)


StringToSequence[str_]:= IntegerDigits[FromDigits[str,36],36];
SequenceToString[seq_]:= StringJoin @ IntegerString[seq, 36];


With[
	{	
		seq1 = "123123123456456456789789abcabcabc",
		seq2 = "123123123456456456789789abcabcabc123123123456456456789789789abcabcabc",
		mat =  1- SequenceToMatrix[Range[12]],
		threading := StringToSequence[threadingseq],
		treadling := StringToSequence[treadleseq]
	},

	Manipulate[	
		WeavingDraft[threading, treadling, mat],
		{{threadingseq, seq2, "Thrading Sequence"}, InputField[#, String, ImageSize-> Full]& },
		{{treadleseq, seq1, "Treadling Sequence"}, InputField[#, String, ImageSize-> Full]& },
		ContentSize -> Full
	]
	
	
]
