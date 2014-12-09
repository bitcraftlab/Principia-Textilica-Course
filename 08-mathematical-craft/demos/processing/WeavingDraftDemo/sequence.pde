
/////////////////////////////////////////////////
//                                             //
//              Sequence Functions             //
//                                             //
/////////////////////////////////////////////////


// return at least n unique rows and an index sequence

int[][][] unique( int[][] s, int n) {
  
  HashMap hash = new HashMap();
  int xmax = s[0].length;
  int[][] uniq = new int[s.length][xmax];
  int[][] idx = new int[s.length][1];
  int i = 0;
  
  int[] emptyRow = new int[xmax], emptyIdx = {0};
  hash.put(Arrays.hashCode(emptyRow), emptyIdx);
  
  for(int y=0; y<s.length; y++) {
    int k = Arrays.hashCode(s[y]);
    if (!hash.containsKey(k)) {
      uniq[i] = s[y]; 
      idx[y][0] = i+1; // index starting at 1     
      hash.put(k,idx[y]);
      i++;
    } 
    else {
      idx[y] = (int[]) hash.get(k);
    }
  }
  
  int[][][] r = {subset(uniq,0,max(n,i)), idx} ; 
  
  return r;
  
}



