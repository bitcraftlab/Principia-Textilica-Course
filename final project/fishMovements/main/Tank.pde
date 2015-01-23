class Tank{

  PVector center;
  float radius;
  color tankColor;
  PImage img;
  
  public Tank(float cx, float cy, float r){
    center = new PVector(cx, cy);
    radius = r;
    img = createImage(width, height, RGB);
  }
  
  public void drawTank(){
    stroke(0,0,0);
    noFill();
    ellipseMode(RADIUS);
    ellipse(center.x, center.y, radius, radius);
  }
  
  public void updateBackupImage(Fish f){
    img.loadPixels();
    //println(pixels[].length());
    int pos = (int)(f.pos.y)*img.width+(int)(f.pos.x);
    if(pos > 0 && pos < width*height-1) img.pixels[pos] = f.fishColor;
    img.updatePixels();
  }
  
  public void saveBackupImage(){
    img.save("test05.png");
  }

}
