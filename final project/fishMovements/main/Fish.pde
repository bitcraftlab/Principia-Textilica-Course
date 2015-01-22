class Fish{
  public int id;
  public color fishColor; 
  public boolean selected = false;
  public boolean startled = false;
  public boolean isPredatory = false;
  
  public float privateRadius  = 30.0;
  public float startleRadius  = 40.0;
  public float companyRadius  = 70.0;
  public float distanceToSeeWall = 20.0;
  
  public float wallFactor     = 0.4;
  public float neighborFactor = 0.1;
  public float followFactor   = 0.2;
  public float avoidFactor    = 0.1;
  
  public int maxTimeToCalmDown = 1500; //ms
  public int maxEnergy = 1500;
  public float startledSpeed  = 1.3;
  public float maxSpeed = 0.6;
  public float minSpeed = 0.4;
  public int maxTimeBetweenTraces = 100;
  public int maxNumberOfTracedPos = 150;
  public int traceWeight          = 7;
  
  private boolean leaveTrace = true;
  private boolean isAvoidingWall = false;
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

//-------------------------------------------------------------------------------------------
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

public void setSpeed(boolean startled, boolean wallAhead, boolean neighborIsVisible){
  if(startled)                speed = speed > startledSpeed? startledSpeed : speed*1.05;
  else if(wallAhead)          speed = speed <= minSpeed? minSpeed : speed*0.95;
  //else if(neighborIsVisible)  speed = speed >= maxSpeed? maxSpeed : speed*1.05;
  //else if(!neighborIsVisible) speed = speed >= maxSpeed? maxSpeed : speed*1.05;
  else speed = speed >= maxSpeed? maxSpeed : speed*1.05;
}

//-------------------------------------------------------------------------------------------

  public void update(Fish[] fish, int timeElapsed){  
    
    leaveTrace(true, timeElapsed); 
    
    PVector wallComponent = getDirectionRegardingCircularWalls();
    PVector neighborComponent = getDirectionRegardingNeighbors(fish);
    //PVector randomComponent ?
    PVector sumComponents = new PVector(wallComponent.x * wallFactor + neighborComponent.x * neighborFactor,
                                        wallComponent.y * wallFactor + neighborComponent.y * neighborFactor);
    
    if(lengthVector(sumComponents) > 0.01){
      sumComponents = normalize(sumComponents);
      //if(id == 1) println(sumComponents);
      dir = normalize(interpolate(sumComponents, dir, 0.2));
    }
    
    
    if(startled){ //calm down?
      checkCalmDown(timeElapsed);
    }
    
    //setSpeed(startled, isAvoidingWall, neighborIsVisible);
    
    if(!startled && energy < maxEnergy) energy += 0.5*timeElapsed;
    
    updatePos();
  }
  
//-------------------------------------------------------------------------------------------
  public PVector getDirectionRegardingCircularWalls(){
    PVector refl = new PVector(0,0);
    PVector cv = new PVector((-this.pos.x+tank.center.x), (-this.pos.y+tank.center.y));
    boolean atWall = lengthVector(cv)>(tank.radius-distanceToSeeWall);
    
    if(atWall){// && !isAvoidingWall){
      isAvoidingWall = true; 
      refl = getReflectionVector(dir, cv);
    }
    else if(!atWall && isAvoidingWall){
      isAvoidingWall = false;
    }
    
    return refl;
  }

//-------------------------------------------------------------------------------------------

  public boolean canSeeOther(Fish f){
    //check if f lies within field of view (fov) of this
    PVector relativePosition = new PVector(f.pos.x-this.pos.x, f.pos.y-this.pos.y);
    boolean result = ( getScalarProduct(dir, relativePosition)>0 && (getAngle(dir, relativePosition) <= fov*0.5));
    return result;
  }
  
  /*public void turnAwayFrom(Fish f){
    dir.x += withdrawFactor*(this.pos.x - f.pos.x + f.dir.x);
    dir.y += withdrawFactor*(this.pos.y - f.pos.y + f.dir.y);
  }*/
  
//-------------------------------------------------------------------------------------------
  
  public PVector getDirectionRegardingNeighbors(Fish[] fish){
    PVector dirNew = new PVector(0,0);
    boolean neighborIsVisible = false;
    float distance = -1.0;
    
    //check all neighbor distances
    for(Fish f: fish){
      if(f.id != this.id){ //exclude self
        
        neighborIsVisible = canSeeOther(f);
        distance = distance(this.pos, f.pos);
        
        if(neighborIsVisible && f.isPredatory && distance < companyRadius){
          //turnAwayFrom(f);
          dirNew = add(dirNew, interpolate(new PVector(pos.x-f.pos.x, pos.y-f.pos.y), dir, avoidFactor));
          startled(true);
          break;
        }
        else if(neighborIsVisible && distance < privateRadius){
          //too close, turn away from neighbor
          dirNew = add(dirNew, interpolate(new PVector(pos.x-f.pos.x, pos.y-f.pos.y), dir, avoidFactor));
        }
        else if(neighborIsVisible && distance < companyRadius){
          //follow
          dirNew = add(dirNew, interpolate(dir, f.dir, followFactor));
        }
        /*else if(!neighborIsVisible){
          //turn(0.002*random(-1,1)*180/PI);
        }*/
        
        
        if(distance < startleRadius && f.startled){
          startled(true);
        }
      }
    }
    //dirNew = normalize(dirNew); //nope
    return dirNew;
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


