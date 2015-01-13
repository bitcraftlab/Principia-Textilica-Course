int lastStop = 0;
int speed = 5;
float lastX = 0.0;
float lastY = 0.0;
float scaleFactor = 1.5;

void setup(){
  size(750, 800);
}

void draw(){

  pushMatrix();  
  Trochoid t1_fix = new Trochoid(1, 42, 8, 5, 0.0);
  t1_fix.drawStep(lastStop, lastStop + speed);
  
  translate(120, 0);
  Trochoid t1 = new Trochoid(1, 42, 8, 5, 0.1);
  t1.drawStep(lastStop, lastStop + speed);
  
  //------------------------------------------------------------
  translate(-180,100);
  Trochoid t2_fix = new Trochoid(2, 65, 30, 10, 0.0);
  t2_fix.drawStep(lastStop, lastStop + speed);
  
  translate(160,0);
  Trochoid t2 = new Trochoid(2, 65, 30, 10, 0.1);
  t2.drawStep(lastStop, lastStop + speed);
  
  //------------------------------------------------------------
  translate(-200,110);
  Trochoid t3_fix = new Trochoid(2, 60, 40, 20, 0.0);
  t3_fix.drawStep(lastStop, lastStop + speed);
  
  translate(150,0);
  Trochoid t3 = new Trochoid(2, 60, 40, 20, 0.1);
  t3.drawStep(lastStop, lastStop + speed);
  
  //-Composition-Experiment-------------------------------------
  translate(-170,130);
  Trochoid t4_fix = new Trochoid(2, 60, 40, 20, 0.0);
  t4_fix.compositionTrochoid = t2_fix;
  t4_fix.drawStep(lastStop, lastStop + speed);
  
  translate(150,0);
  Trochoid t4 = new Trochoid(2, 60, 40, 20, 0.1);
  t4.compositionTrochoid = t2_fix;
  t4.drawStep(lastStop, lastStop + speed);
    
  //============================================================
  popMatrix();
  lastStop += speed;
  //noLoop();
}


