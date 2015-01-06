
// Drawing functions for the elementary stitches
// inside the region x = {-1, 1}, y = {-1, 1}

void drawStitch() {
  
  switch(x) {
    
  case ' ':; 
    // don't draw anything
    break;
    
  case '+': 
    // draw a plus shape
    line(-1, 0, 1, 0); 
    line(0, -1, 0, 1); 
    break;
    
  case '-': 
    // draw a minus shape
    line(-1, 0, 1, 0); 
    break;
    
  case '|': 
    // draw a vertical line
    line(0, -1, 0, 1); 
    break;
    
  case '/': 
    // draw a diagonal line
    line(-1, 1, 1, -1); 
    break;
    
  case 'o': 
    // draw an ellipse around the center
    ellipse(0, 0, 2, 2); 
    break;
  
  case 'F': 
    // draw an F
    line(0, -1, 0, 1);
    line(0, -1, 1, -1);
    line(0, 0, 1, 0);  
    break;
    
  case 'f': 
    // draw an f
    line(0, -0.5, 0, 1);
    bezier(0, -0.5, 0, -1, 0.5, -1, 0.5, -0.5);
    
    line(0, 0, 0.5, 0);  
    break;
    
  case 'H': 
    // draw an H
    line(0, -1, 0, 1);
    line(1, -1, 1, 1);
    line(0, 0, 1, 0);  
    break;
    
  case 'h': 
    // draw an h
    line(0, -1, 0, 1);
    bezier(0, 0.5,  1, 0,  1, 0, 1, 1);  
    break;
  }
  
}
