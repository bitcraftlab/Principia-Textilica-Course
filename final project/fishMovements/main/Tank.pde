class Tank{
  String id = String.valueOf(day()) + "-"+ String.valueOf(month())+ "-" + String.valueOf(year()) + "_" +
              String.valueOf(hour()) + "-" + String.valueOf(minute()) + "-" + String.valueOf(second());
  PVector center;
  float radius;
  color tankColor;
  PImage img;
  int numberImagesSaved = 0;
  
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
    ++numberImagesSaved;
    img.save("fishtank" + id + "_" + numberImagesSaved + ".png");
    println("Image " + numberImagesSaved +" saved.");
  }

}
