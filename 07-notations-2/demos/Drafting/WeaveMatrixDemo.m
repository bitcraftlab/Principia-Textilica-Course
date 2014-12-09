(* ::Package:: *)

(* ::Title:: *)
(*Weave Matrix Demo*)


(* ::Chapter:: *)
(*Matrix Multiplication*)


(* ::Text:: *)
(*Let' s create two matrices*)


ma = Array[Subscript[a, #1 * 10 + #2] &, {3, 2}]


mb = Array[Subscript[b, #1*10 + #2] &, {2, 4}]


ma // MatrixForm


mb // MatrixForm


(* ::Text:: *)
(*Dot Product for Matrices*)


ma . mb // MatrixForm


(* ::Text:: *)
(*Eqivalent to Inner Product using Multiplication and Addition*)


Inner[Times, ma , mb, Plus] // MatrixForm


(* ::Text:: *)
(*Custom Multiplication Operator for Boolean Matrices*)


Inner[And, ma , mb, Or]  // TraditionalForm


(* ::Chapter:: *)
(*Weave Multiplication*)


(* ::Subsection:: *)
(*Creating TieUp and Sequences*)


(* ::Text:: *)
(*Let' s create some random thrading, treadling and tieup matrices*)


RandomMatrix[x_, y_] :=  Table[RandomInteger[], {x}, {y}] 


threading = RandomMatrix[4, 15] 


treadling = RandomMatrix[20, 3]


tieup = RandomMatrix[4, 3]


weave = Table[0, {20}, {15}]


(* ::Subsection:: *)
(*Displaying the Matrices*)


(* ::Text:: *)
(*Arrange Matrices like in a Weaving draft*)


WeaveMatrixForm[{m1_, m2_, m3_, m4_}, form_: MatrixForm] := TableForm[Map[form, {{m1, m2}, {m3, m4}}, {2}], TableSpacing -> {2, 1}]


{ threading, tieup, weave, treadling} // WeaveMatrixForm


(* ::Text:: *)
(*Show me some pixels!*)


WeavePlotForm[matrices_] := WeaveMatrixForm[matrices, Framed[ArrayPlot[#, PixelConstrained -> 10, Frame -> False], FrameMargins -> 1] &]


{ threading, tieup, weave, treadling} // WeavePlotForm


(* ::Subsection:: *)
(*Multiplying the Matrices*)


(* ::Text:: *)
(*Check if Matrix Kernels are compatible*)


Dimensions /@\[NonBreakingSpace]{treadling , tieup, threading}


Dimensions /@\[NonBreakingSpace]{treadling , Transpose[tieup], threading}


(* ::Text:: *)
(*Create a Function to multiply weaves*)


weaveMult[ma_, mb_] := Inner[BitAnd, ma , mb, BitOr] 


weave = treadling ~weaveMult~ Transpose[tieup] ~weaveMult~ threading;


{ threading, tieup, weave, treadling} // WeavePlotForm
