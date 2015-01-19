//import java.awt*;

Fish[] fish = new Fish[50];
PVector tankDim = new PVector(700,700);
int lastMillis = 0;

void setup(){
  size((int)(tankDim.x + 100), (int)(tankDim.y+100));

  
  for(int i = 0; i < fish.length; ++i){
    fish[i] = new Fish(random(100, width-100), random(100, height-100));
    fish[i].id = i;  
  }

}

void draw(){
  colorMode(HSB, 100); 
  background(60,30,30);
  stroke(0,0,0);
  noFill();
  rect((width-tankDim.x)*0.5, (width-tankDim.x)*0.5, tankDim.x, tankDim.y);
  
  
  for(Fish f : fish){
    f.update(fish, millis()-lastMillis);
    f.drawFish();
  }
  lastMillis = millis();
}

void mouseClicked() {
  for(Fish f : fish){
    if(f.pos.x > mouseX-10 && f.pos.x < mouseX+10 &&
       f.pos.y > mouseY-10 && f.pos.y < mouseY+10){
       f.selected = true;
    }
    else{
      f.selected = false;
    }
  }
}
