class Fish{
  public int id;
  public color fishColor; 
  public boolean selected = false;
  public boolean startled = false;
  public boolean isPredatory = false;
  
  public float privateRadius  = 30.0;
  public float startleRadius  = 40.0;
  public float companyRadius  = 70.0;
  
  public int maxTimeToCalmDown = 1500; //ms
  public int maxEnergy = 1500;
  public float withdrawFactor = 0.1;
  public float followFactor   = 0.1;
  public float obstacleForce  = 0.01;
  public float startledSpeed  = 1.3;
  public float maxSpeed = 0.4;
  public float minSpeed = 0.2;
  public int maxTimeBetweenTraces = 100;
  public int maxNumberOfTracedPos = 150;
  public int traceWeight          = 20;
  
  private boolean leaveTrace = true;
  private LinkedList<PVector> tracePositions = new LinkedList<PVector>();
  private int sizeTracePositions = 0;
  private PVector pos = new PVector(100.0, 100.0);
  private PVector dir = new PVector(1.0, 1.0); 
  private int timeToCalmDown   = maxTimeToCalmDown; //ms
  public int timeBetweenTraces = maxTimeBetweenTraces;
  private int energy  = 0;
  private float fov   = 90 * 180/PI; 
  private float speed = random(minSpeed, maxSpeed);

//-------------------------------------------------------------------------------------------

  public Fish(float x, float y, boolean predator){
    pos.x = x;
    pos.y = y;
    isPredatory = predator;
    //fishColor = color(random(35,65), random(90,100), random(40,80));
    colorMode(HSB, 100.0, 100.0, 100.0); 
    fishColor = color(random(45,65), 80.0, 100.0);
  }
  
  public void turn(float alpha){
    float x = dir.x*cos(alpha) - dir.y*sin(alpha);
    float y = dir.x*sin(alpha) + dir.y*cos(alpha);
    dir.x = x;
    dir.y = y;
    dir = normalize(dir);
  }
  
  public void leaveTrace(boolean lt, int timeElapsed){
    leaveTrace = lt;
    if(leaveTrace) timeBetweenTraces -= timeElapsed;
    if(timeBetweenTraces <= 0){
      timeBetweenTraces = maxTimeBetweenTraces;
      tracePositions.addFirst(new PVector(pos.x, pos.y)); //add position to head of list
      ++sizeTracePositions;
      if(sizeTracePositions > maxNumberOfTracedPos) {
        tracePositions.removeLast();
        --sizeTracePositions;
      }
    }
  }
  
  public void startled(boolean s){
    
    if(!startled && s) {  // only startle if calm
      startled = s;
      timeToCalmDown = maxTimeToCalmDown;
    }
    else if(!s){  // calming always works
      startled = s;
      timeToCalmDown = maxTimeToCalmDown;
    }
  }
  
  public void checkCalmDown(int millis){
    timeToCalmDown -= millis;
    energy -= millis;
    if(timeToCalmDown <= 0 || energy <= 0) {
      energy = 0;
      startled(false);
    }
  }

//-------------------------------------------------------------------------------------------

  public void update(Fish[] fish, int timeElapsed){  
     // leave trace
     // startled?
     // wall?
     // neighbors?
     // eat?
     // move
    
    leaveTrace(true, timeElapsed); 
    boolean wallAhead = updateDirectionRegardingWalls();
    

    /*else*/ if(!wallAhead){
      speed = speed >= maxSpeed? maxSpeed : speed*1.05;
      
      boolean neighborIsVisible = updateDirectionRegardingNeighbors(fish);
      if (!neighborIsVisible){
        speed = speed >= maxSpeed? maxSpeed : speed*1.05;
      }
    }
    else{
      speed = speed <= minSpeed? minSpeed : speed*0.95;
    }
    
    if(startled){
      print(timeToCalmDown + " " + speed + " ");
      speed = speed > startledSpeed? startledSpeed : speed*1.05;
      println(speed);
      //calm down?
      //startled(random(0.0, 1.0) <0.2);
      checkCalmDown(timeElapsed);
      //turn(0.002*random(-1,1)*180/PI);
    }
    
    if(!startled && energy < maxEnergy) energy += 0.5*timeElapsed;
    
    updatePos();
    
    //just for testing:
    //if(!startled) startled(random(0.0, 1.0) <0.0005);
  }
  
//-------------------------------------------------------------------------------------------
  
  public boolean updateDirectionRegardingWalls(){
    
    float signX = dir.x <0? -1 :1;
    float signY = dir.y <0? -1 :1;
    boolean seeLeft =   pos.x < (width-tankDim.x)*0.5 + 20        && signX < 0;
    boolean seeRight =  pos.x > (width-(width-tankDim.x)*0.5 -20) && signX > 0;
    boolean seeTop =    pos.y < (height-tankDim.y)*0.5 + 20       && signY < 0;
    boolean seeBottom = pos.y > height-(height-tankDim.y)*0.5 -20 && signY > 0;
    float awaySpeed = 0.025;
    
    if(seeLeft){
      dir.x += awaySpeed;
      if(pos.x < 0) dir.x = 0.5 + random(0.5, 1.0);
      //turn(turnSpeed*signY*180/PI);
    }
    else if(seeRight){
      dir.x -= awaySpeed;
      if(pos.x > width) dir.x = -0.5 - random(0.5, 1.0);
      //turn(turnSpeed*(-signY)*180/PI);
    }

    if(seeTop){
      dir.y += awaySpeed;
      if(pos.y < 0) dir.y = 0.5 + random(0.5, 1.0);
      //turn(turnSpeed*signX*180/PI);
    }
    else if(seeBottom){
      dir.y -= awaySpeed;
      if(pos.y > height) dir.y = -0.5 - random(0.5, 1.0);
      //turn(turnSpeed*(-signX)*180/PI);
    }
    
    //if(selected) println(id + " " + dir.x + " " + dir.y);
    dir = normalize(dir);
    return (seeLeft || seeRight || seeTop || seeBottom);
  }

//-------------------------------------------------------------------------------------------

  public boolean canSeeOther(Fish f){
    //check if f lies within field of view (fov) of this
    PVector relativePosition = new PVector(f.pos.x-this.pos.x, f.pos.y-this.pos.y);
    boolean result = ( getScalarProduct(dir, relativePosition)>0 && (getAngle(dir, relativePosition) <= fov*0.5));
    if(selected) println(result + " " + f.id);
    return result;
  }
  
  public void turnAwayFrom(Fish f){
    dir.x += withdrawFactor*(this.pos.x - f.pos.x + f.dir.x);
    dir.y += withdrawFactor*(this.pos.y - f.pos.y + f.dir.y);
  }
  
//-------------------------------------------------------------------------------------------
  
  public boolean updateDirectionRegardingNeighbors(Fish[] fish){
    boolean neighborIsVisible = false;
    float distance = -1.0;
    
    //check all neighbor distances
    for(Fish f: fish){
      if(f.id != this.id){ //exclude self
        
        neighborIsVisible = canSeeOther(f);
        distance = distance(this.pos, f.pos);
        if(neighborIsVisible && f.isPredatory && distance < companyRadius){
          turnAwayFrom(f);
          startled(true);
        }
        else if(distance < startleRadius && f.startled){
          startled(true);  //may lead to problems--> startle stop/restart cycles?
        }
        else if(neighborIsVisible && distance < privateRadius){
          //too close, turn away from neighbor
          turnAwayFrom(f);
        }
        else if(neighborIsVisible && distance < companyRadius){
          //follow
          dir.x += (followFactor* f.dir.x);
          dir.y += (followFactor* f.dir.y);
        }
        else if(!neighborIsVisible){
          turn(0.002*random(-1,1)*180/PI);
        }
        
      }
    }
    dir = normalize(dir);
    return neighborIsVisible;
  }
  
//-------------------------------------------------------------------------------------------
  
  public void updatePos(){
      //check for collisions?    
      pos.x += speed*dir.x;
      pos.y += speed*dir.y;
  }

//-------------------------------------------------------------------------------------------

  public void drawBody(){
    stroke(fishColor);
    
    if(selected || startled) stroke(95, 100, 100);
    fill(color(hue(fishColor), saturation(100*energy/maxEnergy), brightness(100*energy/maxEnergy)));
    ellipseMode(CENTER);
    ellipse(pos.x, pos.y, 20, 20);
    //line(pos.x, pos.y, pos.x+(10*dir.x), pos.y+(10*dir.y));  //direction vector vis
  }
  
//-------------------------------------------------------------------------------------------  
  public void drawTrace(){
    if(leaveTrace){
      stroke(fishColor);
      strokeWeight(traceWeight);
      noFill();
      beginShape();
      //vertex(pos.x, pos.y);
      for(PVector p : tracePositions){
        vertex(p.x, p.y);
      }
      endShape();
      strokeWeight(1);
    }
  }
  
//-------------------------------------------------------------------------------------------  
  public void drawFish(){
    drawTrace();
    drawBody();
  }
}


