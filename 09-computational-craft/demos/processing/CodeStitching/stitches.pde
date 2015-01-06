
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
  }
  
}
