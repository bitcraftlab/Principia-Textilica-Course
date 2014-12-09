(* ::Package:: *)

(* ::Title:: *)
(*Image Sampling Demo*)


(* ::Section:: *)
(*Interactive Gui*)


sampleGui[img_]:= With[

	{

		dim = ImageDimensions[img] ,

		(* functions for color sampling *)
		processingfns = {

			Identity -> "None",
			Binarize -> "Black/White",
			ColorQuantize[#,8, Dithering -> False]& -> "Reduce",
			ColorQuantize[#,8, Dithering -> True]& -> "Dither"

		}

	},

	Manipulate[

		Block[

		{ stretch },

		(* interpolate between four locator points, and rescale to unit rectangle *)
		stretch[ {x_, y_}]:=((1-x)( p1+ y(p2-p1)) + x (p3 + y (p4-p3))) / dim[[1]];

		Grid[
			
			{{

				Show[
					img,
					Graphics[{Opacity[.5], White, StrokeForm[Black],  Polygon[{p1, p2, p4, p3}]}],
					ImageSize-> 200
				],

				ArrayPlot [
		
					1 - ImageData @ processing @ ImageTransformation[img, stretch, {xsamples, ysamples}, PlotRange-> {{0, 1},{0, 1}}],
					Mesh -> All,
					MeshStyle -> GrayLevel[0],
					PixelConstrained -> 4
				]

			}},

			Alignment-> Top

		]
	],

	{{p1, {0, 0} dim}, {0, 0} ,dim, {1, 1}, Locator},
	{{p2, {0, 1} dim}, {0, 0} ,dim, {1, 1}, Locator},
	{{p3, {1, 0} dim}, {0, 0} ,dim, {1, 1}, Locator},
	{{p4, {1, 1} dim}, {0, 0} ,dim, {1, 1}, Locator},
	{{xsamples, 50}, 1, 100, 1},
	{{ysamples, 50}, 1, 100, 1},
	{{processing, Identity}, processingfns},

	ContinuousAction-> True

	]

]


(* ::Section:: *)
(*Photo Example 1*)


(* ::Text:: *)
(*Create an Image from the example data*)


img1= ExampleData[{"TestImage","Lena"}];


sampleGui[img1]


(* ::Section:: *)
(*Photo Example 2*)


img2= ExampleData[{"TestImage","Peppers"}];


sampleGui[img2]


(* ::Section:: *)
(*WebCam Example *)


ImageCapture["CaptureAction"->(CreateDocument[sampleGui[#]]&)]
