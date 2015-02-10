import java.util.LinkedList;

Tank tank;
LinkedList<Fish> fish           = new LinkedList<Fish>();
LinkedList<Fish> childrenQueue  = new LinkedList<Fish>();
int predators = 0;
int numberOfStarterFish = 1;
int lastMillis = 0;
float radius = 300;
boolean isPaused = false;

public boolean leaveTrace = false;
public boolean drawConnection = true;
public boolean drawTriangularShape = false;

void setup(){
  size(1400,900);
  
  tank  = new Tank(width/2 - radius, height/2, radius);

  for(int i = 0; i < numberOfStarterFish; ++i){
    Fish f = new Fish(tank.center.x, tank.center.y, false);
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
  int time = millis();
  
  if(!isPaused){
    strokeJoin(ROUND);
    colorMode(HSB, 100);
    background(60,30,30);
    tank.drawTank();
    
    
    
    for(Fish f : fish){
      f.update(time-lastMillis);
      f.drawTrace();
      f.drawConnection();
    }
    
    for(Fish f : fish){
      f.drawBody();
      tank.updateBackupImage(f);
    }
  
    fish.addAll(childrenQueue);
    childrenQueue.clear();
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
  if(key == 'c'){
    drawConnection = !drawConnection;
  }
  if(key == 't'){
    leaveTrace = !leaveTrace;
  }
  if(key == 'b'){
    drawTriangularShape = !drawTriangularShape;
  }
  if(key == ' '){
    isPaused = !isPaused;
    if(isPaused) println("Fish" + fish.size());
  }
}
