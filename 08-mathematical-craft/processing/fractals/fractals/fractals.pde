int repeat = 3;
int[] cPointsX;
int[] cPointsY;

void setup(){
  size(600, 600);
  
  //cPointsX = new int[]{100, 100, 20,  20, 100+80, 100+80, 20+80, 20+80};
  //cPointsY = new int[]{ 20,  70,100, 150, 150, 100, 70, 20};
  cPointsX = new int[]{80,80, 0,  0, 80+80, 80+80, 80, 80};
  cPointsY = new int[]{ -130,  -80,-50, 0, 0, -50, -80, -130};
}

void draw(){

  
  noFill();  
  
  /*for(int i = 0; i < cPointsX.length; ++i){
    stroke(25*(i+1),0,0);
    ellipse(cPointsX[i], cPointsY[i],2,2);
  }*/
  
  //1. rotate
  
  //2. shift
  translate(350, 0);
  scale(0.95);
  
  for(int i = 0; i < 250;++i){
    //translate(100, 0);
    rotate(radians(25));
    bezier(cPointsX[0], cPointsY[0], cPointsX[1], cPointsY[1], cPointsX[2], cPointsY[2], cPointsX[3], cPointsY[3]);
    bezier(cPointsX[4], cPointsY[4], cPointsX[5], cPointsY[5], cPointsX[6], cPointsY[6], cPointsX[7], cPointsY[7]);
    translate(160, 0);
    scale(0.98);
  }
  
  
  noLoop();

}
