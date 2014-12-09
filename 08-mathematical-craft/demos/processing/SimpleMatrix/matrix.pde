

// print a matrix on the console
void println(int[][] mat) {
  
  int m = mat.length;
  int n = mat[0].length;
  
  println("Dimensions: ", m, " x ", n);
  
  for (int y = 0; y < n; y++) {
    for (int x = 0; x < m; x++) {
      print(mat[x][y], " ");
    }
    println();
  }
  
}

// turn a sequence to a matrix
int[][] seq2mat(int[] seq, int elements) {

  int n = seq.length;
  int[][] mat = new int[n][elements];

  for (int x = 0; x < n; x++) {
    int y = seq[x] - 1;
    mat[x][y] = 1;
  }

  return mat;
  
}

// turn a matrix to an image
PImage mat2img (int[][] mat) {
  
  int n = mat.length;
  int m = mat[0].length;
  
  PImage img = createImage(n, m, RGB);
  img.loadPixels();
  
  int i = 0;
    for(int y = 0; y < m; y++) {
      for(int x = 0; x < n; x++) {
       if(mat[x][y] == 1) {
         img.pixels[i] = color(255);
       } else {
         img.pixels[i] = color(0);
       }
       i++;
    }
  }
  
  img.updatePixels();
  return img;
  
}
