
import controlP5.*;
 
LSystem lsys;
ControlP5 controlP5;
int iterations = 3;
 
void setup()
{
  size(600, 600);
  frameRate(24);
   
  controlP5 = new ControlP5(this);
  controlP5.addSlider("iterations", 0, 12, iterations, 20, 20, 300, 10);
 
  lsys = new LSystem(iterations);

}
 
void iterations(int newIteration) {
  lsys.generate(newIteration);
}
 
void draw()
{
  stroke(255);
  background(0);
  lsys.render();
}
 
 
