class Tank{

  PVector center;
  float radius;
  color tankColor;
  
public Tank(float cx, float cy, float r){
  center = new PVector(cx, cy);
  radius = r;
}

public void drawTank(){
  stroke(0,0,0);
  noFill();
  ellipseMode(RADIUS);
  ellipse(center.x, center.y, radius, radius);
}

}
