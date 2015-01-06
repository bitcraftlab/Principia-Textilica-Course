
void resetMachine() {

  // reset stitch character
  // x = x0;     

  // reset transformation
  resetMatrix(); 
  translate(width/2, height/3); 

  // reset scaling
  s = s0;    
  scale(s);  

  // reset thread thickness
  t = t0/s0; 
  strokeWeight(t);
}


void resetProgram() {
 
  // reset stack, stitch, input and output pointers
  stack = new java.util.Stack(); 
  p = p0; 
  x = x0;
  i = 0; 
  o = 0;
  
}
