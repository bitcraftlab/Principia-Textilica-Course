//-------------------------------------------------------------------------------------------------------//

int[][] seq2mat(int[] seq){
  int rows = maxInArray(seq);
  int[][] mat = new int[rows][(int)(seq.length)];

  for(int i = 0; i < seq.length; ++i){  //n
    mat[seq[i]-1][i]= seq[i];    
  }
  return mat;
}
//-------------------------------------------------------------------------------------------------------//

int maxInArray(int[] a){
  int result = a[0];
  for(int i = 1; i < a.length; ++i){
    result = max(result, a[i]);
  }
  return result;
}
//-------------------------------------------------------------------------------------------------------//

void printMat(int[][] mat){
    for(int m = 0; m < mat.length;++m){
      for(int n = 0; n < mat[m].length; ++n){
        print(mat[m][n] + " ");
      }
    print('\n');
  }
}
//-------------------------------------------------------------------------------------------------------//

PImage mat2img(int[][] mat){
  
  PImage img = createImage(mat.length, mat[0].length, RGB);
  img.loadPixels();
  
  int i = 0;
  for(int m = 0; m < mat.length; ++m){
    for(int n = 0; n < mat[m].length; ++n){
      img.pixels[i] = mat[m][n] != 0 ? color(255, 0, 0) : color(255, 255, 255);
      ++i;
    }
  }
  return img;
}
//-------------------------------------------------------------------------------------------------------//
