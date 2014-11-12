(* ::Package:: *)

(* ::Subsubsection:: *)
(*Create a Sequence of 30 zeros*)


list = Table[0, {30}]


(* ::Subsubsection:: *)
(*Add a one right in the middle*)


list[[15]] = 1;


(* ::Subsubsection:: *)
(*Now show the first line*)


ArrayPlot[{list}]


(* ::Subsubsection:: *)
(*Define our rule table for Rule 110 (1101110)*)


rules = {
{0,0,0} -> 0,
{0,0,1} -> 1, 
{0,1,0} -> 1, 
{0,1,1} -> 1, 
{1,0,0} ->\[NonBreakingSpace]0, 
{1,0,1} -> 1,
{1,1,0} -> 1,
{1,1,1} -> 0
}


(* ::Subsubsection:: *)
(*Chop up the list and apply the rules*)


Partition[list, 3, 1] /. rules


(* ::Subsubsection:: *)
(*Pad the list with zeros on both sides*)


Join[{0}, %, {0}]


(* ::Subsubsection:: *)
(*Create a function to do this*)


step[seq_] := Join[{0}, Partition[seq, 3, 1] /. rules, {0}]


(* ::Subsubsection:: *)
(*Apply the function twice *)


step[step[list]]


(* ::Subsubsection:: *)
(*Apply the function 30 times*)


Nest[step, list, 30]


(* ::Subsubsection:: *)
(*Show the evolution of the sequence*)


NestList[step, list, 30]


ArrayPlot [%]
