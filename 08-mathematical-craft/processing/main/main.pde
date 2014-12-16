// SimpleWeave
PImage img;
int scaleFactor = 10;

//-------------------------------------------------------------------------------------------------------//

void setup(){
  int[] seq = {1,2,3,4,1,2,3,4,10,2,3,4,1,2,3,100,1,2,3,4,1,2,3,40,1,2,30,4,1,2,3,4,1,2,3,4,1,2,3,4};  //4*8 matrix
  int[][] mat = new int[100][seq.length];

  mat = seq2mat(seq, 100, seq.length);
  
  img = mat2img(mat);
  size(img.width*scaleFactor, img.height*scaleFactor);
  
  //test 
  /*
  int[] seq2 = {3,1,2};
  int[][] mat2 = new int[3][seq2.length];
  mat2 = seq2mat(seq2, 3, seq2.length);
  printMat(mat2);
  
  int[] seq3 = {1,3,2};
  int[][] mat3 = new int[3][seq3.length];
  mat3 = seq2mat(seq3, 3, seq3.length);
  printMat(mat3);
  println();
  printMat(mult(mat3, mat2));
  
  img = mat2img(mat2);
  size(img.width*scaleFactor, img.height*scaleFactor);
  //test end */
}
//-------------------------------------------------------------------------------------------------------//

void draw(){  
  noSmooth();
  scale(scaleFactor);
  image(img, 0,0);
  noLoop();
}
//-------------------------------------------------------------------------------------------------------//
