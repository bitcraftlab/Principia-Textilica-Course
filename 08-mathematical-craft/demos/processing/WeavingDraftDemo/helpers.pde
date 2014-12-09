
/////////////////////////////////////////////////
//                                             //
//             Helper Functions                //
//                                             //
/////////////////////////////////////////////////

// Extend Processing's subset function to 2d-arrays

int[][] subset(int[][] a, int o, int l) {
  
  int[][] a2 = new int[l][];
  
  arraycopy(a, a2, l);
  
  return a2; 
  
}


// Processing equivalent of Java's Math.sign()

float sgn(float x) {
  
  return (x>0 ? 1 : ( x<0 ? -1 : 0 ));
  
}

