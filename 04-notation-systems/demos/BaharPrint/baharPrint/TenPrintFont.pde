
/////////////////////////////////////////////////////////////////////////////////
//                                                                             //
//              10 Print Font (using the Fontastic Library)                    //
//                                                                             //
/////////////////////////////////////////////////////////////////////////////////

// >>> Principia Textilcia Course @ bauhaus-uni weimar <<<<<<<<<<<<<<<<<<<<<<< //



//////////////////////////// Creating the Font //////////////////////////////////

// import the library
import fontastic.*;
int size = 1024;
Fontastic f = new Fontastic(this, "BaharPRINT");
f.setVersion("1.0");
f.setAdvanceWidth(size);

PVector[] points = new PVector[5];

/*points[0] = new PVector(0.0, 0.0);
points[1] = new PVector(0.0, 0.2);
points[2] = new PVector(0.8, 1.0);
points[3] = new PVector(1.0, 1.0);
points[4] = new PVector(1.0, 0.8);
points[5] = new PVector(0.2, 0.0);*/

points[0] = new PVector(0.0, 0.0);
points[1] = new PVector(0.0, 0.25);
points[2] = new PVector(0.0, 0.50);
points[3] = new PVector(0.0, 0.75);
points[4] = new PVector(0.0, 1.0);

PVector[] points2 = new PVector[points.length*4];

// scale the glyph to 1024 x 1024 units used by Fontastic
for(int i = 0; i < points.length; i++) {
  points[i].mult(size);
  PVector original = points[i];
  
  
  PVector p1 = new PVector(original.x-0.5, original.y-0.5);
  PVector p2 = new PVector(original.x-0.5, original.y+0.5);
  PVector p3 = new PVector(original.x+0.5, original.y+0.5);
  PVector p4 = new PVector(original.x+0.5, original.y-0.5);
  
  points2[i*4]   = PVector.mult(p1, size);
  points2[i*4+1] = PVector.mult(p2, size);
  points2[i*4+2] = PVector.mult(p3, size);
  points2[i*4+3] = PVector.mult(p4, size);

}

// add the slash glyph and assign the contour to it
f.addGlyph('o').addContour(points2);

// build the font
f.buildFont();

// it's always nice to clean up.
// Just in case you are going to use the fontastic object again.
f.cleanup();



//////////////////////////// Using the Font    //////////////////////////////////

// varible fontsize...
// change this if you feel adventurous!
int fontsize = 20;

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
String mytext = "o o o o o \n o o o o o \n o o o o o \n o o o o o \n o o o o o \n";

// Add a random sequence of slashes
/*for(int y = 0; y < height/fontsize; y++) {
  for(int x = 0; x < width/fontsize; x++) {
      mytext += (random(1) > 0.5) ? "/" : "\\";
  }
  mytext += "\n";
}*/

// Make sure to set the textleading to the font size
textLeading(fontsize);

// Now show it on the canvas
text(mytext, 0, fontsize);


