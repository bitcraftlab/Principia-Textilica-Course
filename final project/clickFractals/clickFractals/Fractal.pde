class Fractal{

  PShape shape;
  LinkedList<Fractal> children = new LinkedList<Fractal>();
  
  public Fractal(){
    shape = createShape();//shape = createShape(GROUP);?
    
    shape.beginShape();
    //vertex()
    shape.endShape();
  }
  
  public void drawFractal(){}

}
