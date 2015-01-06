
// begin a new loop
void openLoop() {
  
  // push the input pointer to the stack
  stack.push(new Integer(i));
  
}

// finalize the current loop
void closeLoop() {
  
  // don't do anything if there is no current loop
  if (stack.isEmpty()){
    return;
  }
  
  // get new input pointer from the stack
  int i0 = ((Integer) stack.pop()).intValue();
  
  // part 0: code before the current loop
  String p0 = p.substring(0, i0);
  
  // part 1: code of the current loop
  String p1 = p.substring(i0+1, i);
  
  // part 2: code after the current loop
  String p2 = i+1 < p.length() ? p.substring(i+1, p.length()) : "";
  
  // calculate the loop counter ('.' = 1, ',' = 5)
  int k = 0;
  
  while (p2.length () > 0) {
    
    // get the next character
    char cc = p2.charAt(0);
    
    // abort if we encounter characters other than ',' or '.'
    if (cc != '.' && cc!= ',') break;
    
    // increase the loop counter
    k += (cc=='.') ? 1 : 5;
    
    // pop first character off of p2
    p2 = p2.substring(1, p2.length());
    
  }
  
  // Let's unfold / flatten the loop into a sequence of repeated instructions
  
  // Start with he part before the loop plus the commands of the loop, that were already executed
  p = p0 + p1; 
  
  // set the input pointer to the end of the current program
  i = p.length()-1;
  
  // now add repetitions of the loop, which are still ahead of us
  while (k-- > 1) {
    p += p1;
  }
  
  // add the part after the loop
  p += p2;
  
}
