import java.util.LinkedList;

PrintWriter textOutput;
Tank tank;
LinkedList<Fish> fish           = new LinkedList<Fish>();
LinkedList<Fish> childrenQueue  = new LinkedList<Fish>();
int predators = 0;
int numberOfStarterFish = 1;
int maxGenerations = 7;
int lastMillis = 0;
float radius = 300;
int fixedFrameTime = 16; //fixed "time" value used to compute the updates of the fish (instead of the actual elapsed time)
boolean isPaused = false;

public boolean leaveTrace = false;
public boolean drawConnection = true;
public boolean drawTriangularShape = false;

// true = updates take elapsed time into account, 
//false = updates have a fixed "time" no matter the actual elapsed time
public boolean frameRateIndependent = false; 

void setup(){
  size(1400,900);
  
  //tank  = new Tank(width/2 - radius, height/2, radius);
  tank  = new Tank(radius, radius, radius);
  textOutput = createWriter("param"+"_"+ tank.id +".txt");
  textOutput.println("tank:");
  textOutput.println("cx,cy,radius: " + tank.center.x + " " + tank.center.y + " " + tank.radius);
  textOutput.println("starter fish: " + numberOfStarterFish);
  textOutput.println("maxGenerations "+ maxGenerations);

  Fish tmp = new Fish(-1, tank.center.x, tank.center.y, false);
  textOutput.println("maxChildren " + tmp.maxChildren);
  textOutput.println("spawnTime " + tmp.timeToSpawn + "ms");
  textOutput.println("turnSpeed " + tmp.interpolationSpeed + "1/ms");
  textOutput.println("follow/avoid " + tmp.followFactor + "/" + tmp.avoidFactor);
  textOutput.println("wall/neighbor " + tmp.wallFactor + "/" + tmp.neighborFactor);
  textOutput.println();

  textOutput.println("fish:");
  for(int i = 0; i < numberOfStarterFish; ++i){
    Fish f = new Fish(i, tank.center.x, tank.center.y, false);
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
    f.printFish(textOutput, "born"); 
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
      f.update(frameRateIndependent? time-lastMillis : fixedFrameTime);
      f.drawTrace();
      f.drawConnection();
    }
    
    for(Fish f : fish){
      f.drawBody();
      tank.updateBackupImage(f);
    }
  
    fish.addAll(childrenQueue);
    childrenQueue.clear();
    
    if(fish.getLast().generation >= maxGenerations) {
      isPaused = true;
      println("Maximum generation reached: " + maxGenerations);
      textOutput.flush();
      textOutput.close();
    }
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
