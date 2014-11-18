
/////////////////////////////////////////////////////////////////////////////////
//                                                                             //
//              10 Print Font (using the Fontastic Library)                    //
//                                                                             //
/////////////////////////////////////////////////////////////////////////////////

// >>> Principia Textilcia Course @ bauhaus-uni weimar <<<<<<<<<<<<<<<<<<<<<<< //



//////////////////////////// Creating the Font //////////////////////////////////

// import the library
import fontastic.*;
int size = 2000;
float gap = 0.07;
Fontastic f = new Fontastic(this, "BaharPRINT");
f.setVersion("1.0");
f.setAdvanceWidth(size);

PVector[] points = new PVector[5];

points[0] = new PVector(0.0, 0.0);
points[1] = new PVector(0.0, 0.25);
points[2] = new PVector(0.0, 0.50);
points[3] = new PVector(0.0, 0.75);
points[4] = new PVector(0.0, 1.0);

PVector[] points2 = new PVector[points.length*4];
PVector[] square = new PVector[4];
f.addGlyph('i');

// scale the glyph to 1024 x 1024 units used by Fontastic
for(int i = 0; i < points.length; i++) {
  //points[i].mult(size);
  PVector original = points[i];

  PVector p1 = new PVector(original.x-gap, original.y-gap);
  PVector p2 = new PVector(original.x-gap, original.y+gap);
  PVector p3 = new PVector(original.x+gap, original.y+gap);
  PVector p4 = new PVector(original.x+gap, original.y-gap);

  square[0] = PVector.mult(p1, size);
  square[1] = PVector.mult(p2, size);
  square[2] = PVector.mult(p3, size);
  square[3] = PVector.mult(p4, size);
  /*
  points2[i*4]   = p1;
  points2[i*4+1] = p2;
  points2[i*4+2] = p3;
  points2[i*4+3] = p4;*/
  f.getGlyph('i').addContour(square);
}

/*println(square.length);
String tst = "";
for(int i = 0; i < square.length;++i){
  if(i%4 == 0){
    println(tst);
    tst = "";
  }
  tst += (square[i] + " ");
}
println(tst);*/

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
String mytext = "\n \n i i i i i";// \n o o o o o \n o o o o o \n o o o o o \n o o o o o \n";

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


