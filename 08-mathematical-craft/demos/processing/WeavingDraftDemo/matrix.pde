
/////////////////////////////////////////////////
//                                             //
//              Matrix Functions               //
//                                             //
/////////////////////////////////////////////////

// functions to create, transform and combine matrices

// create a unit matrix of size n

int[][] unitMatrix(int n) {
  
  int[][] m = new int[n][n];
  
  for(int i = 0; i < n; i++) {
    m[i][i] = 1;
  }
  
  return m;
  
}


// multiply matrix M1(a,b) and M2(b,c): N1(a,b) o M2(b,c) => M3(a,c)

int[][] multiply(int[][] m1, int[][] m2) {  
  
  int a = m1.length;
  int c = m2[0].length;
  int b = m1[0].length;
  int b2 = m2[0].length;
  
  int[][] m3 = new int[a][c];
  for(int i = 0; i < a; i++) {
    for(int j = 0; j < c; j++) {
      for(int k = 0; k < b; k++) {
        m3[i][j] += m1[i][k] * m2[k][j];
      }
    }
  }
  
  return m3;
  
}


// transpose a matrix, by exchanging columns and rows: M(a,b) => M'(b,a)

int[][] transpose(int[][] m) {
  
  int ymax = m.length;
  int xmax = m[0].length;
  int[][] m2 = new int[xmax][ymax];
  
  for(int y = 0; y < ymax; y++) {
    for(int x = 0; x < xmax; x++) {
      m2[x][y] = m[y][x];
    }
  }
  
  return m2;
  
}


// flip matrix rows: M(a,b) => Mf(a,b)

int[][] flipX(int[][] m) {
  
 for(int y = 0; y < m.length; y++) {
   m[y] = reverse(m[y]);
 }
 
 return m;
 
}
  
  
// factorize matrix (AxC => AxB o BxC)

int[][][] yfactor(int[][] m) {
  
 int[][][] u = unique(m, 1);
 int[][][] yf = {u[0], seq2mat(u[1], u[0].length)};
 
 return yf;
 
}


int[][][] xfactor(int[][] m) {
  
 int[][][] xft = yfactor(transpose(m));
 int[][][] xf = {transpose(xft[0]), xft[1] };
 
 return xf;
 
}


// return a triangle matrix of size n

int[][] triangleMatrix(int n) {
  
  int[][] m = new int[n][n];
  for(int i=0; i<n; i++) for(int j=0; j<=i; j++) m[i][j] = 1;
  
  return m;
  
}

// TODO: color the matrix based on warp + weft color sequences

int[][] colorMat(int[][] m, int[][] cs1, int[][] cs2) {
  
  return m;
  
}


