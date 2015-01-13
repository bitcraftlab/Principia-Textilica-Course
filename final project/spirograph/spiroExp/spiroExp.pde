int lastStop = 0;
int speed = 5;
float lastX = 0.0;
float lastY = 0.0;
float scaleFactor = 1.5;

void setup(){
  size(750, 500);
}

void draw(){

  pushMatrix();  
  Trochoid t1_fix = new Trochoid(1, 42, 8, 5, 0.0);
  t1_fix.drawStep(lastStop, lastStop + speed);
  
  translate(110, 0);
  Trochoid t1 = new Trochoid(1, 42, 8, 5, 0.1);
  t1.drawStep(lastStop, lastStop + speed);
  
  //------------------------------------------------------------
  translate(-60,100);
  Trochoid t2_fix = new Trochoid(2, 65, 30, 10, 0.0);
  t2_fix.drawStep(lastStop, lastStop + speed);
  
  Trochoid t2 = new Trochoid(2, 65, 30, 10, 0.0);
  t2.drawStep(lastStop, lastStop + speed);
  
  /*
  //------------------------------------------------------------
  translate(-20,90);
  Trochoid t3 = new Trochoid(2, 60, 40, 20, 0.1);
  t3.drawStep(lastStop, lastStop + speed);
  */
  
  //============================================================
  popMatrix();
  lastStop += speed;
  //noLoop();
}


