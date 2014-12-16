//-------------------------------------------------------------------------------------------------------//

int[][] seq2mat(int[] seq, int rows, int columns){
  int[][] mat = new int[rows][columns];

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

void printMat(int[][] mat){
    for(int m = 0; m < mat.length;++m){
      for(int n = 0; n < mat[m].length; ++n){
        print(mat[m][n] + " ");
      }
    print('\n');
  }
}
//-------------------------------------------------------------------------------------------------------//

int[][] mult(int[][] left, int[][] right){
  int[][] result = new int[left.length][right[0].length]; // result dim: m1 * n2
  if(left[0].length != right.length){
    System.err.print("Matrix dimensions (" + left[0].length + " and " + right.length+  ") don't match.");//error: n1 must equal m2
    result = null;
  }
  else{
    //transpose right for easier access to columns
    int[][] rightT = transpose(right);
    for(int m = 0; m < result.length; ++m){
      int[] leftRow = left[m];
      for(int n = 0; n < result[m].length; ++n){
        int[] rightColumn = rightT[n];
        result[m][n] = dotProduct(leftRow, rightColumn);        
      }
    }
  } 
  return result;
}
//-------------------------------------------------------------------------------------------------------//

int dotProduct(int[] a, int[] b){
  int result = 0;
  if(a.length != b.length){
    System.err.print("Vector dimensions (" + a.length + " and " + b.length+  ") don't match.");
  }
  else{
    for(int i = 0; i < a.length; ++i){
      result += a[i]*b[i];
    }
  }
  return result;
}
//-------------------------------------------------------------------------------------------------------//

int[][] transpose(int[][] mat){
  int[][] result = new int[mat[0].length][mat.length];
  
  for(int m = 0; m< mat.length; ++m){
    for(int n = 0; n < mat[m].length; ++n){
      result[n][m] = mat[m][n];
    }
  } 
  return result;
}
//-------------------------------------------------------------------------------------------------------//
