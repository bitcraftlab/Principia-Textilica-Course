import java.util.LinkedList;

int lastMillis = 0;


public void setup(){
  size(700, 700);
  strokeJoin(ROUND);
  colorMode(HSB, 100);
}

public void draw(){
  background(60,30,0);
  //update(millis()-lastMillis);
  lastMillis = millis();
}

void mouseClicked() {
  //mouseX
  //mouseY
  startFractal(mouseX, mouseY);
}

void startFractal(float x, float x){
  
}
