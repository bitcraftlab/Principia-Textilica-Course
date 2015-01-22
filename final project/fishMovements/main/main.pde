//import java.awt*;
import java.util.LinkedList;

Tank tank;
Fish[] fish = new Fish[50];
Fish predator;
//PVector tankDim = new PVector(700,700);
//PVector tankCenter = new PVector(tankDim.x*0.5,tankDim.y*0.5);
int lastMillis = 0;

void setup(){
  size((int)(700), (int)(700));
  
  tank = new Tank(width/2, height/2, width/2);

  predator = new Fish(width/2, height/2, true);
  predator.fishColor = color(random(45,65), 0.0, 0.0);
  predator.privateRadius  = -1.0;
  predator.startleRadius  = -1.0;
  predator.companyRadius  = 70.0;
  predator.maxSpeed = 0.3;
  
  for(int i = 0; i < fish.length-1; ++i){
    fish[i] = new Fish(random(100, width-100), random(100, height-100), false);
    fish[i].id = i;  
  }
  fish[fish.length-1] = predator;

}

void draw(){
  strokeJoin(ROUND);
  colorMode(HSB, 100);
  background(60,30,30);
  /*stroke(0,0,0);
  noFill();
  ellipseMode(RADIUS);
  ellipse(tankCenter.x+50, tankCenter.y+50, tankDim.x*0.5, tankDim.y*0.5);*/
  tank.drawTank();
  
  
  for(Fish f : fish){
    f.update(fish, millis()-lastMillis);
    f.drawTrace();
  }
  
  for(Fish f : fish){
    f.drawBody();
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
