import org.philhosoft.p8g.svg.*;


// Saving SVG with the P8gGraphicsSVG library


void setup() {
  size(200, 200);
}


void draw() {
  background(255);
  drawShape(); 
}

// let's draw 
void drawShape() {
  
  noFill(); 
  stroke(0);

  // move to the center
  translate(width/2, height/2);

  // let's draw a star shape :)
  beginShape();
  vertex(0, -50);
  vertex(14, -20);
  vertex(47, -15);
  vertex(23, 7);
  vertex(29, 40);
  vertex(0, 25);
  vertex(-29, 40);
  vertex(-23, 7);
  vertex(-47, -15);
  vertex(-14, -20);
  endShape(CLOSE);
  
}


void keyPressed() {
  // call export function when the dialog is done
  selectOutput("Save to SVG", "export");
}

// export to the selected file (callback function)
void export(File selection) {

  // get the path of the selected file  
  String path = selection.getAbsolutePath();

  // create a custom SVG renderer
  P8gGraphicsSVG svg = (P8gGraphicsSVG) createGraphics(width, height, P8gGraphicsSVG.SVG, path);
  
  // start recording the drawing
  beginRecord(svg); svg.beginDraw(); 
  
  // draw the actual shape
  drawShape();
  
  // stop drawing and recording
  svg.endDraw(); endRecord();
  
}

