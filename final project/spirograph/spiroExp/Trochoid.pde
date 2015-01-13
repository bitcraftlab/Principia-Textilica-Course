class Trochoid{
  int type = 0;
  float R = 0.0; //radius bigger circle
  float r = 0.0;  //radius smaller circle
  float d = 0.0;  //distance tracing point from center smaller circle (if d = r then Hypocycloid)
  float shiftFactor = 0.0;
  
  float lastX = 0.0;
  float lastY = 0.0;
  
  Trochoid compositionTrochoid = null;
  int compositionDirection = 0; // -1 or 1
  
  Trochoid(int t, float radiusBig, float radiusSmall, float distanceTracingPoint, float xShift){
    type = t;
    R = scaleFactor * radiusBig;
    r = scaleFactor * radiusSmall;
    d = scaleFactor * distanceTracingPoint;
    shiftFactor = xShift;
  }
  
  float computeX(float theta){
    float x = 0.0;
    if(type == 1){
      x = (R-r) * cos(theta) - d*cos((R-r)*theta/r);
    }
    else if(type == 2){
      x = (R-r) * cos(theta) + d*cos((R-r)*theta/r);
    }
    return x;
  }
  
  float computeY(float theta){
    // no if needed really
    float y = 0.0;
    if(type == 1){
      y = (R-r) * sin(theta) - d*sin((R-r)*theta/r);
    }
    else if(type == 2){
      y = (R-r) * sin(theta) - d*sin((R-r)*theta/r);
    }
    return y;
  }
  
  void drawStep(int startStep, int stopStep){

    float theta = 0.0;
    float shift = 0.0;
    for(int step = startStep; step < stopStep; ++step){
      theta = TWO_PI/360.0 * (float)step;
      float x = 0.0;
      float y = 0.0;
      if(compositionTrochoid != null){
        x = this.computeX(compositionTrochoid.computeX(theta));
        y = this.computeY(compositionTrochoid.computeY(theta));
      }
      else{
        x = this.computeX(theta);
        y = this.computeY(theta);
      }
      
  
      shift = shiftFactor > 0.00001? (float)step*shiftFactor :0.0;
      line(lastX < 0.001? x+R+r+d + shift:lastX, lastY < 0.001? y+R+r+d: lastY, x+R+r+d + shift, y+R+r+d);
      lastX = x+R+r+d + shift;
      lastY = y+R+r+d;
  }
}
}
