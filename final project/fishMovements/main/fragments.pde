  /*public Fish copy(){
    Fish f = new Fish(this.pos.x, this.pos.y, this.isPredatory);
    f.fishColor = this.fishColor;
    f.dir.x = this.dir.x;
    f.dir.y = this.dir.y;
    f.id = this.id;
    f.hometank = this.hometank;
    return f;
  }*/

    //just for testing:
    //if(!startled) startled(random(0.0, 1.0) <0.0005);
    
   /*public void turn(float alpha){
    float x = dir.x*cos(alpha) - dir.y*sin(alpha);
    float y = dir.x*sin(alpha) + dir.y*cos(alpha);
    dir.x = x;
    dir.y = y;
    dir = normalize(dir);
  }*/
    
  //-------------------------------------------------------------------------------------------
  //for rectangular tank...
  /*public boolean updateDirectionRegardingRectangularWalls(){
    
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
  }*/
  
  //-------------------------------------------------------------------------------------------
  //fishColor = color(random(35,65), random(90,100), random(40,80));
