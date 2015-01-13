class Trochoid{
  int type = 0;
  float R = 0.0; //radius bigger circle
  float r = 0.0;  //radius smaller circle
  float d = 0.0;  //distance tracing point from center smaller circle (if d = r then Hypocycloid)
  float shiftFactor = 0.0;
  
  float lastX = 0.0;
  float lastY = 0.0;
  
  Trochoid(int t, float radiusBig, float radiusSmall, float distanceTracingPoint, float xShift){
    type = t;
    R = scaleFactor * radiusBig;
    r = scaleFactor * radiusSmall;
    d = scaleFactor * distanceTracingPoint;
    shiftFactor = xShift;
  }
  
  void drawStep(int startStep, int stopStep){

    float theta = 0.0;
    float shift = 0.0;
    for(int step = startStep; step < stopStep; ++step){
      theta = TWO_PI/360 * step;
      float x = 0.0;
      float y = 0.0;
      if(type == 1){     //Epitrochoid
        x = (R-r) * cos(theta) - d*cos((R-r)*theta/r);
        y = (R-r) * sin(theta) - d*sin((R-r)*theta/r);
      }
      else if(type == 2){//Hypotrochoid
        x = (R-r) * cos(theta) + d*cos((R-r)*theta/r);
        y = (R-r) * sin(theta) - d*sin((R-r)*theta/r);
      }
  
      shift = shiftFactor > 0.00001? (float)step*shiftFactor :0.0;
      line(lastX < 0.001? x+R+r+d + shift:lastX, lastY < 0.001? y+R+r+d: lastY, x+R+r+d + shift, y+R+r+d);
      lastX = x+R+r+d + shift;
      lastY = y+R+r+d;
  }
}
}
