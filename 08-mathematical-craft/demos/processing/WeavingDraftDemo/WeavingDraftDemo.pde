
/////////////////////////////////////////////////
//                                             //
//              Weaving Draft Demo             //
//                                             //
/////////////////////////////////////////////////

// (c) Martin Schneider (bitcraftlab) 2009 - 2014


/// params ///
float zoom = 2;
float xoffset = 0;
float yoffset = 0;

/// globals ///
ImageDraft w = new ImageDraft();
PImage img = new PImage();


void setup() {

  size(600, 600);
  
  // load a draft
  
  // w.loadDrawdown("57002.gif");
  //w.load("57002-liftplan.wif");
  // w.load("57002.wif");
  w.load("57002-xmas.gif");
  img = w.getDraft();
  
  // coordinate system origin in top right corner
  xoffset = width;
  
}

void draw() {

  background(255);
  
  // move center of the coordinate system
  translate(xoffset, yoffset);
  
  // scale by zoom factor
  scale(zoom, zoom);
  
  // display image flipped to the left
  image(img, -img.width, 0);
  
}


