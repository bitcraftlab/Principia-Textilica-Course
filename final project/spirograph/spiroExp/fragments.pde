void drawFigure1(){

  float repeat = 3;
  float shiftFactor = 0.0;
  //Hypotrochoid: small circle inside bigger circle

  float R = 65;  //radius bigger circle
  float r = 30;  //radius smaller circle
  float d = 45;  //distance tracing point from center smaller circle (if d = r then Hypocycloid)
  float theta = 0.0;
  float shift = 0.0;

  noFill();
  beginShape();
  for(int i = 0; theta < repeat*TWO_PI; ++i){
    float x = (R-r) * cos(theta) + d*cos((R-r)*theta/r);
    float y = (R-r) * sin(theta) - d*sin((R-r)*theta/r);
    shift = shiftFactor > 0.00001? (float)i*shiftFactor :0.0;
    vertex(x+R + shift, y+R);
    theta += TWO_PI/360;
  }
  endShape();
  
}

//--------------------------------------------------------------------------


void drawHypotrochoid(int startStep, int stopStep){

  //float repeat = 3;
  float scale = 1.5;
  float shiftFactor = 0.0;
  //Hypotrochoid: small circle inside bigger circle

  float R = scale*65;  //radius bigger circle
  float r = scale*30;  //radius smaller circle
  float d = scale*5;  //distance tracing point from center smaller circle (if d = r then Hypocycloid)
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

//--------------------------------------------------------------------------

void drawTrochoid(int type, int startStep, int stopStep, float R, float r, float d, float xShift){
  
  float scale = 1.5;
  float shiftFactor = xShift;
  //Hypotrochoid: small circle inside bigger circle

  //float R = scale*42;  //radius bigger circle
  //float r = scale*8;  //radius smaller circle
  //float d = scale*5;  //distance tracing point from center smaller circle (if d = r then Hypocycloid)
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
    //point(x+R+r+d + shift, y+R+r+d);
    line(lastX < 0.001? x+R+r+d + shift:lastX, lastY < 0.001? y+R+r+d: lastY, x+R+r+d + shift, y+R+r+d);
    lastX = x+R+r+d + shift;
    lastY = y+R+r+d;
  }
}

