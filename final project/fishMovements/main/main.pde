import java.util.LinkedList;

Tank tank;
Fish[] fish = new Fish[100];
int predators = 0;
int numberOfStarterFish = 100;
int lastMillis = 0;
float radius = 300;

void setup(){
  size(1400,900);
  
  tank  = new Tank(width/2 - radius, height/2, radius);

  for(int i = 0; i < numberOfStarterFish; ++i){
    fish[i] = new Fish(tank.center.x, tank.center.y, false);
    colorMode(HSB, 100);
    fish[i].fishColor = color(random(0,100), 80.0, 100.0); // test
    fish[i].id = i;
    fish[i].hometank = tank;
      
    if(i < predators){
      fish[i].fishColor = color(random(45,65), 0.0, 0.0);
      fish[i].privateRadius  = -1.0;
      fish[i].startleRadius  = -1.0;
      fish[i].companyRadius  = 70.0;
      fish[i].maxSpeed = 0.3;
      fish[i].isPredatory = true;
    } 
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
