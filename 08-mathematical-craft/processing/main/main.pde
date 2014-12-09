// SimpleWeave
PImage img;

void setup(){
  int[] seq = {1,2,3,4,1,2,3,4,10,2,3,4,1,2,3,100,1,2,3,4,1,2,3,40,1,2,30,4,1,2,3,4,1,2,3,4,1,2,3,4};  //4*8 matrix
  int[][] mat = new int[5][2];

  //printMat(mat);
  mat = seq2mat(seq);
  printMat(mat);
  
  img = mat2img(mat);
}

void draw(){
  size(img.width*5, img.height*5);
  noSmooth();
  scale(5);
  image(img, 0,0);
}

int[][] seq2mat(int[] seq){
  int rows = maxInArray(seq);
  int[][] mat = new int[rows][(int)(seq.length)];

  for(int i = 0; i < seq.length; ++i){  //n
    mat[seq[i]-1][i]= seq[i];    
  }
  return mat;
}

int maxInArray(int[] a){
  int result = a[0];
  for(int i = 1; i < a.length; ++i){
    result = max(result, a[i]);
  }
  return result;
}

void printMat(int[][] mat){
    for(int m = 0; m < mat.length;++m){
      for(int n = 0; n < mat[m].length; ++n){
        print(mat[m][n] + " ");
      }
    print('\n');
  }
}

PImage mat2img(int[][] mat){
  
  PImage img = createImage(mat.length, mat[0].length, RGB);
  img.loadPixels();
  
  int i = 0;
  for(int m = 0; m < mat.length; ++m){
    for(int n = 0; n < mat[m].length; ++n){
      //println(m + " " + n);
      img.pixels[i] = mat[m][n] != 0 ? color(255, 0, 0) : color(255, 255, 255);
      ++i;
    }
  }
  return img;
}
