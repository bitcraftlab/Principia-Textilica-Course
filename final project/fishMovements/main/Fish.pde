class Fish{
  
  //variating for documentation:
  // 1/how many ms to reach 100% of interpolation range 
  // when changing current direction to target direction
  // = speed of turns
  public float interpolationSpeed = 1.0/100.0;
  public float privateRadius  = 30.0;
  public float companyRadius  = 70.0;
  public int timeToSpawn = 6000;//ms
  public float[] spawnAnglesDegree = {135, -135};
  

  public float[] spawnAngles = {spawnAnglesDegree[0] * 180/PI, spawnAnglesDegree[1] * 180/PI};    
    
  public int id;
  public color fishColor; 
  public boolean selected = false;
  public boolean startled = false;
  public boolean isPredatory = false;
  
  //public float privateRadius  = 40.0;
  public float startleRadius  = 40.0;
  //public float companyRadius  = 75.0;
  public float distanceToSeeWall = 20.0;
  
  //These factors describe how important the different 
  //environment elements are for the direction change of the fish.
  //chase and imitate are both subparts of the neighbor part. 
  public float wallFactor     = 0.9;
  public float neighborFactor = 0.1;
  //chase and imitate model the company-behaviour of the fish:
  //when they seek the company of other fish they can adapt their direction to be the same as the other fish (imitate)
  //or they can change their direction towards the position of the other fish (chase)
  //the ratio of both factors determines the behaviour
  //NOT USED RIGHT NOW
  public float chaseFactor      = 0.1;
  public float imitateFactor    = 0.9;
  
  public int maxTimeToCalmDown = 1500; //ms
  public int maxEnergy = 1500;
  public float startledSpeed  = 1.0;
  public float maxSpeed = 0.5;
  public float minSpeed = 0.3;
  public int maxTimeBetweenTraces = 50; //ms
  public int maxNumberOfTracedPos = 20;
  public int traceWeight          = 10; //stroke weight
  
  private PVector pos = new PVector(100.0, 100.0);
  private PVector dir = new PVector(0, -1);
  private int age = 0; //ms
  private int generation = 0;
  private LinkedList<Fish> children = new LinkedList<Fish>();
  public int maxChildren = 2;
  private boolean isStopped = false;
  
  public Tank hometank; 
  private int energy  = 0;
  private float fov   = 360 * 180/PI; 
  private float speed = minSpeed;
  private int timeToCalmDown   = maxTimeToCalmDown; //ms
  public int timeBetweenTraces = maxTimeBetweenTraces;
  private boolean isAvoidingWall = false;
  private LinkedList<PVector> tracePositions = new LinkedList<PVector>();
  private int sizeTracePositions = 0;  // just a helper to avoid iterating over the list multiple times


//-------------------------------------------------------------------------------------------

  public Fish(int id, float x, float y, boolean predator){
    pos.x = x;
    pos.y = y;
    isPredatory = predator;
    colorMode(HSB, 100);
    //fishColor = color(random(0,100), 80.0, 100.0);
    fishColor = color(50, 80.0, 100.0);
    dir = normalize(dir);
    this.id = id;
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
    if(!isPredatory){
      if(!startled && s) {  // only startle if calm
        startled = s;
        timeToCalmDown = maxTimeToCalmDown;
      }
      else if(!s){  // calming always works
        startled = s;
        timeToCalmDown = maxTimeToCalmDown;
      }
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

  public void setSpeed(boolean startled, boolean wallAhead){
    //if(!isStopped){
      if(startled)                speed = speed > startledSpeed? startledSpeed : speed*1.05;
      else if(wallAhead)          speed = speed <= minSpeed? minSpeed : speed*0.95;
      else speed = speed >= maxSpeed? maxSpeed : speed*1.05;
    /*}
    else{
      speed = 0.0;
    }*/
  }

  public void spawnChildren(){
    Fish f = new Fish(fish.size()+childrenQueue.size(), this.pos.x, this.pos.y, false);
    PVector cDir = turn(this.dir, spawnAngles[children.size()]);
    f.dir.x = cDir.x;
    f.dir.y = cDir.y;
    colorMode(HSB, 100);
    f.fishColor = color((hue(this.fishColor)+4)%100, 80.0, 100.0);
    
    f.hometank = this.hometank;
    f.generation = this.generation +1;
    this.children.add(f);
    childrenQueue.add(f);
    
    //f.printFish(textOutput, "born");
    
  }
//-------------------------------------------------------------------------------------------

  public void update(int timeElapsed){  
    age += timeElapsed;
    if(!isStopped /*|| isStopped*/){  
      if(children.size() < maxChildren && age >= timeToSpawn) {
        isStopped = true;
        while(children.size() < maxChildren){
          spawnChildren();
        }
        printFish(textOutput, "died");
      }
      
      leaveTrace(leaveTrace, timeElapsed); 
      
      PVector wallComponent = normalize(getDirectionRegardingCircularWalls());
      PVector neighborComponent = normalize(getDirectionRegardingNeighbors(timeElapsed));
      PVector sumComponents = new PVector();
      
      if(wallComponent != null){
        sumComponents.x += (wallComponent.x * wallFactor);
        sumComponents.y += (wallComponent.y * wallFactor);
      }
      if(neighborComponent != null){
        sumComponents.x += (neighborComponent.x * neighborFactor);
        sumComponents.y += (neighborComponent.y * neighborFactor);
      }
      
      sumComponents = normalize(sumComponents);
      if(sumComponents != null){
        dir = normalize(interpolate(dir, sumComponents, interpolationSpeed*timeElapsed));
      }
      
      if(startled){ //calm down?
        checkCalmDown(timeElapsed);
      }
      
      setSpeed(startled, isAvoidingWall);
      
      if(!startled && energy < maxEnergy) energy += 0.5*timeElapsed;
      
      if(dir != null){// && !isStopped){
        PVector cv = new PVector((-this.pos.x-speed*dir.x+hometank.center.x), (-this.pos.y-speed*dir.y+hometank.center.y));
        if(lengthVector(cv) <= hometank.radius){ // inside
          pos.x += speed*dir.x;
          pos.y += speed*dir.y;
        }
        else{
          dir.x = -dir.x;
          dir.y = -dir.y;
          pos.x += speed*dir.x;
          pos.y += speed*dir.y;      
        }
      }
    }
  }
  
//-------------------------------------------------------------------------------------------
  public PVector getDirectionRegardingCircularWalls(){
    PVector refl = new PVector(0,0);
    PVector cv = new PVector((-this.pos.x+hometank.center.x), (-this.pos.y+hometank.center.y));
    boolean atWall = lengthVector(cv)>(hometank.radius-distanceToSeeWall);
    
    if(atWall){
      isAvoidingWall = true; 
      refl = getReflectionVector(dir, cv);
      cv = normalize(cv);
      refl.x += cv.x;
      refl.y += cv.y;
      if(selected) println("refl: " + refl.x + " " + refl.y);
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
    boolean result = ( /*getScalarProduct(dir, relativePosition)>0 &&*/ (getAngle(dir, relativePosition) <= fov*0.5));
    return result;
  }
  
//-------------------------------------------------------------------------------------------
  
  public PVector getDirectionRegardingNeighbors(int timeElapsed){
    PVector dirNew = new PVector(0,0);
    boolean neighborIsVisible = false;
    float distance = -1.0;
    
    //check all neighbor distances
    for(Fish f: fish){
      if(f.id != this.id){ //exclude self
        
        neighborIsVisible = canSeeOther(f);
        distance = distance(this.pos, f.pos);
        if(distance < 10){  // very close
          neighborIsVisible = true;
          if(distance < privateRadius*0.2){  // directly on top
            PVector dir2 = new PVector();
            if(this.id < f.id) dir2 = turn(dir, -0.0001*180/PI);// turn left
            else               dir2 = turn(dir, 0.0001*180/PI); // turn right
            dirNew = add(dirNew, interpolate(dir, dir2, interpolationSpeed*timeElapsed)); 
          }
        }
        
        if(neighborIsVisible && f.isPredatory && distance < companyRadius){
          //run away
          dirNew = add(dirNew, interpolate(dir, new PVector(pos.x-f.pos.x, pos.y-f.pos.y), interpolationSpeed*timeElapsed));
          startled(true);
          break;
        }
        else if(neighborIsVisible && distance < privateRadius){
          //too close, turn away from neighbor
          if(selected) println(distance);
          dirNew = add(dirNew, interpolate(dir, new PVector(pos.x-f.pos.x, pos.y-f.pos.y), interpolationSpeed*timeElapsed));
          //dirNew = add(dirNew, interpolate(dir, new PVector(f.pos.x-pos.x, f.pos.y-pos.y), interpolationSpeed*timeElapsed));
        }
        else if(neighborIsVisible && distance < companyRadius){
          //follow
          dirNew = add(dirNew, interpolate(dir, f.dir, interpolationSpeed*timeElapsed));
        }       
        
        if(distance < startleRadius && f.startled){
          startled(true);
        }
      }
    }
    
    if(lengthVector(dirNew) < 0.00001){
      dirNew.x = dir.x;
      dirNew.y = dir.y;
    }
    return dirNew;
  }
  
//-------------------------------------------------------------------------------------------
  public void updatePos(){
      //check for wall collision    
      PVector cv = new PVector((-this.pos.x+hometank.center.x), (-this.pos.y+hometank.center.y));
      if(lengthVector(cv) < hometank.radius){
        pos.x += speed*dir.x;
        pos.y += speed*dir.y;
      }
      else{
        //reevaluate wall reflection component ?
      }
  }

//-------------------------------------------------------------------------------------------

  public void drawBody(){
    stroke(fishColor);
    
    if(selected || startled) stroke(95, 0, 50);
    if(!isPredatory){
      fill(color(hue(fishColor), saturation(100*energy/maxEnergy), brightness(100*energy/maxEnergy)));
    }
    else{
      fill(fishColor);
    }
    if(drawTriangularShape){
      float s = 10.0; //scale
      float t = 0.75;
      beginShape();
      vertex(pos.x+dir.x*s , pos.y+dir.y*s);
      vertex(pos.x-dir.x*s+dir.y*s*t , pos.y-dir.y*s-dir.x*s*t);  //cross product
      vertex(pos.x-dir.x*s-dir.y*s*t , pos.y-dir.y*s+dir.x*s*t); 
      endShape(CLOSE);
    }
    else{
      stroke(0);
      ellipseMode(CENTER);
      ellipse(pos.x, pos.y, 2,2);
      stroke(fishColor);
    }
    if(drawID && isStopped){
      textSize(8);
      text(id ,pos.x+1, pos.y);
    }
    
    
    //test
    /*noFill();
    ellipseMode(CENTER);
    ellipse(pos.x, pos.y, companyRadius,companyRadius);*/
  }
  
//-------------------------------------------------------------------------------------------  
  public void drawTrace(){
    if(leaveTrace){
      stroke(color(hue(fishColor), saturation(fishColor)*0.75, brightness(fishColor)*0.75));
      strokeWeight(traceWeight);
      noFill();
      beginShape();
      for(PVector p : tracePositions){
        vertex(p.x, p.y);
      }
      endShape();
      strokeWeight(1);
    }
  }

//-------------------------------------------------------------------------------------------  
  public void drawConnection(){
    if(drawConnection && !children.isEmpty()){
      stroke(color(hue(fishColor), saturation(fishColor)*0.75, brightness(fishColor)*0.75));
      strokeWeight(int((maxGenerations-this.generation)*2));
      noFill();
      for(Fish c : children){
        line(pos.x, pos.y, c.pos.x, c.pos.y);
      }
      stroke(0);
      strokeWeight(0.5);
      for(Fish c : children){
        line(pos.x, pos.y, c.pos.x, c.pos.y);
      }
    }
  }
  
//-------------------------------------------------------------------------------------------  
  public void drawFish(){
    drawTrace();
    drawConnection();
    drawBody();

  }
  
//-------------------------------------------------------------------------------------------
  public void printFish(PrintWriter out, String action){
    
    String childrenTxt = " c: ";
    for(Fish c : children){
      childrenTxt += (c.id + " ");
    }
    out.println(id + " g:" + generation + " " + action + " " + pos.x + " " + pos.y + " : " + round(pos.x*mapTo/(2*radius)) + " " + round(pos.y*mapTo/(2*radius))+ childrenTxt);
  }

}


