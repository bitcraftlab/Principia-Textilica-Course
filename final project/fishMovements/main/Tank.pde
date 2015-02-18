class Tank{
  String id = String.valueOf(day()) + "-"+ String.valueOf(month())+ "-" /*+ String.valueOf(year()) + "_"*/ +
              String.valueOf(hour()) + "-" + String.valueOf(minute()) + "-" + String.valueOf(second());
  public PVector center;
  float radius;
  color tankColor;
  PImage imgTraces;
  PImage imgFrequency;
  public int numberImagesSaved = 0;
  
  public Tank(float cx, float cy, float r){
    center = new PVector(cx, cy);
    radius = r;
    imgTraces    = createImage((int)(cx+r+10), (int)(cy+r+10), RGB);
    imgFrequency = createImage((int)(cx+r+10), (int)(cy+r+10), RGB);
  }
  
  public void drawTank(){
    stroke(0,0,0);
    noFill();
    ellipseMode(RADIUS);
    ellipse(center.x, center.y, radius, radius);
  }
  
  public void updateBackupImage(Fish f){
    imgTraces.loadPixels();
    int pos = (int)(f.pos.y)*imgTraces.width+(int)(f.pos.x);
    if(pos > 0 && pos < width*height-1) imgTraces.pixels[pos] = f.fishColor;
    imgTraces.updatePixels();
    
    imgFrequency.loadPixels();
    int pos2 = (int)(f.pos.y)*imgFrequency.width+(int)(f.pos.x);
    if(pos2 > 0 && pos2 < width*height-1) imgFrequency.pixels[pos2] += 1;
    imgFrequency.updatePixels();
  }
  
  public void saveBackupImage(String sth){
    ++numberImagesSaved;
    imgTraces.save("tank" + sth + "_" + "trace" + "_" + id + "_" + numberImagesSaved + ".png");
    println("Image " + numberImagesSaved +" saved.");
    
    ++numberImagesSaved;
    stretchValues(imgFrequency).save("tank" + sth + "_" + "freq" + "_" + id + "_" + numberImagesSaved + ".png");
    println("Image " + numberImagesSaved +" saved.");
    
  }

  public PImage stretchValues(PImage in){
    
    PImage out = createImage(in.width, in.height, RGB);
    out.copy(in, 0,0, in.width, in.height, 0,0, out.width, out.height);
    out.loadPixels();
    int max = max(out.pixels);
    //stretch all values prop. to max
    for(int i = out.pixels.length-1; i >= 0; --i){
      int value = 100/max* out.pixels[i];
      out.pixels[i] = color(0,0,value);
    }
    out.updatePixels();
    return out;
  }

}
