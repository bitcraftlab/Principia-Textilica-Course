int lastStop = 0;
int speed = 5;
float lastX = 0.0;
float lastY = 0.0;

void setup(){
  size(750, 500);
}

void draw(){
  //drawFigure1();
  //if(frameCount % 5 == 0) 
  drawFigure2(lastStop, lastStop + speed);
  lastStop += speed;
  //noLoop();
}

void drawFigure2(int startStep, int stopStep){

  //float repeat = 3;
  float scale = 1.5;
  float shiftFactor = 0.02;
  //Hypotrochoid: small circle inside bigger circle

  float R = scale*65;  //radius bigger circle
  float r = scale*30;  //radius smaller circle
  float d = scale*45;  //distance tracing point from center smaller circle (if d = r then Hypocycloid)
  float theta = 0.0;
  float shift = 0.0;
  for(int step = startStep; step < stopStep; ++step){
    theta = TWO_PI/360 * step;
    float x = (R-r) * cos(theta) + d*cos((R-r)*theta/r);
    float y = (R-r) * sin(theta) - d*sin((R-r)*theta/r);
    
    shift = shiftFactor > 0.00001? (float)step*shiftFactor :0.0;
    //point(x+R+r+d + shift, y+R+r+d);
    line(lastX < 0.001? x+R+r+d + shift:lastX, lastY < 0.001? y+R+r+d: lastY, x+R+r+d + shift, y+R+r+d);
    lastX = x+R+r+d + shift;
    lastY = y+R+r+d;
  }
}
