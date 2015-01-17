//import java.awt*;

Fish[] fish = new Fish[20];
PVector tankDim = new PVector(600,600);

void setup(){
  size(700, 700);
  ellipseMode(CENTER);
  
  for(int i = 0; i < fish.length; ++i){
    fish[i] = new Fish(random(100, width-100), random(100, height-100));
    fish[i].id = i;  
  }

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
