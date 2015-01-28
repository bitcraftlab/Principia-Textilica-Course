import java.util.LinkedList;

Tank tank;
Fish[] fish = new Fish[50];
Fish predator;
int lastMillis = 0;

void setup(){
  size(900,900);
  
  tank = new Tank(width/2, height/2, width/2-70);

  predator = new Fish(width/2+ random(-50,50), height/2+ random(-50,50), true);
  predator.fishColor = color(random(45,65), 0.0, 0.0);
  predator.privateRadius  = -1.0;
  predator.startleRadius  = -1.0;
  predator.companyRadius  = 70.0;
  predator.maxSpeed = 0.3;
  
  for(int i = 0; i < fish.length-1; ++i){
    //fish[i] = new Fish(random(100, width-150), random(100, height-150), false);
    fish[i] = new Fish(width/2 + random(-50,50), height/2 + random(-50,50), false);
    fish[i].id = i;  
  }
  fish[fish.length-1] = predator;

}

void draw(){
  strokeJoin(ROUND);
  colorMode(HSB, 100);
  background(60,30,30);
  tank.drawTank();
  
  
  for(Fish f : fish){
    f.update(fish, millis()-lastMillis);
    //f.drawTrace();
  }
  
  for(Fish f : fish){
    f.drawBody();
    tank.updateBackupImage(f);
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

void keyReleased(){
  if(key == 's') {
    tank.saveBackupImage();
  }
  //
}
