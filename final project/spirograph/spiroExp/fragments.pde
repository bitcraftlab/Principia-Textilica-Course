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
