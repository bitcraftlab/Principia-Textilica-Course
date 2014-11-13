
/////////////////////////////////////////////////////////////////////////////////
//                                                                             //
//              10 Print Font (using the Fontastic Library)                    //
//                                                                             //
/////////////////////////////////////////////////////////////////////////////////

// >>> Principia Textilcia Course @ bauhaus-uni weimar <<<<<<<<<<<<<<<<<<<<<<< //



//////////////////////////// Creating the Font //////////////////////////////////

// import the library
import fontastic.*;

// create a new Fontastic font called "10PRINT"
Fontastic f = new Fontastic(this, "10PRINT");

// we can set a version
f.setVersion("1.0");

// set the default width / kerining for a glyph
f.setAdvanceWidth(1024);


// create an array that holds six values of type PVector
PVector[] points = new PVector[6];

// Fill the array with values that correspond to the points of the forward slash
// We are using the unit square as a reference. 
// The origin is in the bottom left corner

//          __
//         /  |
//        /   |
//       /   /
//      /   /
//     /   /
//    /   /
//   |   /
//   |__/
//

points[0] = new PVector(0.0, 0.0);
points[1] = new PVector(0.0, 0.2);
points[2] = new PVector(0.8, 1.0);
points[3] = new PVector(1.0, 1.0);
points[4] = new PVector(1.0, 0.8);
points[5] = new PVector(0.2, 0.0);

// scale the glyph to 1024 x 1024 units used by Fontastic
for(int i = 0; i < 6; i++) {
  points[i].mult(1024); 
}

// add the slash glyph and assign the contour to it
f.addGlyph('/').addContour(points);

// let's flip the coordinates around the y-axis so we get a backslash!
for(int i = 0; i < 6; i++) {
  points[i].x = 1024 -  points[i].x;
}

// add the backslash glyph and assign the contour to it
// Note that the backslash is used as escape character, so you need to use it twice to get the actual backslash.
// See: https://en.wikipedia.org/wiki/Escape_character
f.addGlyph('\\').addContour(points);

// build the font
f.buildFont();

// it's always nice to clean up.
// Just in case you are going to use the fontastic object again.
f.cleanup();



//////////////////////////// Using the Font    //////////////////////////////////

// varible fontsize...
// change this if you feel adventurous!
int fontsize = 8;

// Create a new font from the temporary TTF file, that fontastic has created
PFont myFont = createFont(f.getTTFfilename(), fontsize);

// Tell processing to use the font for rendering text
textFont(myFont);

// Create a canvas sized 800 x 600 px
size(400, 400);

// Black background
background(0);

// White fill color
fill(255);

// Create some text
String mytext = "";

// Add a random sequence of slashes
for(int y = 0; y < height/fontsize; y++) {
  for(int x = 0; x < width/fontsize; x++) {
      mytext += (random(1) > 0.5) ? "/" : "\\";
  }
  mytext += "\n";
}

// Make sure to set the textleading to the font size
textLeading(fontsize);

// Now show it on the canvas
text(mytext, 0, fontsize);


