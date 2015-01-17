//import java.awt*;

Fish[] fish = new Fish[20];
PVector tankDim = new PVector(400,400);

void setup(){
  for(int i = 0; i < fish.length; ++i){
    fish[i] = new Fish(100, 100);
    fish[i].id = i;  
  }
  
  size(500, 500);
  ellipseMode(CENTER);
}

void draw(){
  background(100);
  rect((width-tankDim.x)*0.5, (width-tankDim.x)*0.5, tankDim.x, tankDim.y);
  
  
  for(Fish f : fish){
    f.update(fish);
    f.drawFish();
  }
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
