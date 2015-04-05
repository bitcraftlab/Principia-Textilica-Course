// SimpleWeave
PImage imgTieUp;
PImage imgThreading;
PImage imgTreadling;
PImage imgDrawdown;
int scaleFactor = 20;

//-------------------------------------------------------------------------------------------------------//

void setup(){
  //int[] seq = {1,2,3,4,1,2,3,4,10,2,3,4,1,2,3,100,1,2,3,4,1,2,3,40,1,2,30,4,1,2,3,4,1,2,3,4,1,2,3,4};  //4*8 matrix
  //int[][] mat = new int[100][seq.length];
  //mat = seq2mat(seq, 100, seq.length);
  
  int[][] tieUp = {{0,0,4,4},
                   {0,3,3,0},
                   {2,2,0,0},
                   {1,0,0,1}};
  int[][] treadling = {{1,0,0,0},
                       {0,1,0,0},
                       {0,0,1,0},
                       {0,0,0,1},
                       {1,0,0,0},
                       {0,1,0,0},
                       {0,0,1,0},
                       {0,0,0,1},
                       {1,0,0,0},
                       {0,1,0,0},
                       {0,0,1,0},
                       {0,0,0,1},
                       {1,0,0,0},
                       {0,1,0,0},
                       {0,0,1,0},
                       {0,0,0,1}};
  int[][] threading = {{0,4,0,0,4,0,0,0,0,4,0,0,4,0,0,0},
                       {3,0,0,0,0,3,0,0,3,0,0,0,0,3,0,0},
                       {0,0,0,2,0,0,2,0,0,0,0,2,0,0,2,0},
                       {0,0,1,0,0,0,0,1,0,0,1,0,0,0,0,1}};
                         
  int[][] temp = mult(treadling, tieUp);                         
  int[][] drawdown = mult(temp, threading);
  
  imgTieUp = mat2img(tieUp);
  imgThreading = mat2img(threading);
  imgTreadling = mat2img(treadling);
  imgDrawdown = mat2img(drawdown);
  size((imgThreading.width + imgTieUp.width)*scaleFactor, (imgThreading.height + imgDrawdown.height)*scaleFactor);
  
  
}
//-------------------------------------------------------------------------------------------------------//

void draw(){  
  noSmooth();
  scale(scaleFactor);
  strokeWeight(1/scaleFactor);
  noFill();
  image(imgThreading, 0,0);
  rect(0,0,imgThreading.width, imgThreading.height);
  
  image(imgTieUp, imgThreading.width, 0);
  rect(imgThreading.width,0,imgTieUp.width, imgTieUp.height);
  
  image(imgDrawdown, 0,imgThreading.height);
  rect(0,imgThreading.height,imgDrawdown.width, imgDrawdown.height);
  
  image(imgTreadling, imgThreading.width,imgThreading.height);
  rect(imgThreading.width,imgThreading.height,imgTreadling.width, imgTreadling.height);
  noLoop();
}
//-------------------------------------------------------------------------------------------------------//
