import java.util.LinkedList;

Tank tank;
LinkedList<Fish> fish = new LinkedList<Fish>();
int predators = 0;
int numberOfStarterFish = 1;
int lastMillis = 0;
float radius = 300;

void setup(){
  size(1400,900);
  
  tank  = new Tank(width/2 - radius, height/2, radius);

  for(int i = 0; i < numberOfStarterFish; ++i){
    Fish f = new Fish(tank.center.x, tank.center.y, false);
    
    colorMode(HSB, 100);
    f.fishColor = color(random(0,100), 80.0, 100.0); // test
    f.id = i;
    f.hometank = tank;
      
    if(i < predators){
      f.fishColor = color(random(45,65), 0.0, 0.0);
      f.privateRadius  = -1.0;
      f.startleRadius  = -1.0;
      f.companyRadius  = 70.0;
      f.maxSpeed = 0.3;
      f.isPredatory = true;
    }
    fish.add(f); 
  }
}

void draw(){
  strokeJoin(ROUND);
  colorMode(HSB, 100);
  background(60,30,30);
  tank.drawTank();
  //tank2.drawTank();
  
  int time = millis();
  
  // tank 1------------------------------//
  for(Fish f : fish){
    f.update(fish, time-lastMillis);
    f.drawTrace();
  }
  
  for(Fish f : fish){
    f.drawBody();
    tank.updateBackupImage(f);
  }

  lastMillis = time;
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
    tank.saveBackupImage("A");
  }
}
