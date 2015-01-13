int lastStop = 0;
int speed = 2;
float lastX = 0.0;
float lastY = 0.0;
float scaleFactor = 1.5;


Trochoid t1_fix;
Trochoid t1;
Trochoid t2_fix;
Trochoid t2;
Trochoid t3_fix;
Trochoid t3;
Trochoid t4_fix;
Trochoid t4;

void setup(){
  size(750, 800);
    t1_fix = new Trochoid(1, 42, 8, 5, 0.0);
    t1 = new Trochoid(1, 42, 8, 5, 0.1);
    
    t2_fix = new Trochoid(2, 65, 30, 10, 0.0);
    t2 = new Trochoid(2, 65, 30, 10, 0.1);
    
    t3_fix = new Trochoid(2, 60, 40, 20, 0.0);
    t3 = new Trochoid(2, 60, 40, 20, 0.1);

    t4_fix = new Trochoid(2, 60, 40, 20, 0.0);    
    t4_fix.compositionTrochoid = t2_fix;
    t4 = new Trochoid(2, 60, 40, 20, 0.1);
    
}

void draw(){

  pushMatrix();  

  t1_fix.drawStep(lastStop, lastStop + speed);
  translate(120, 0);
  t1.drawStep(lastStop, lastStop + speed);
  
  //------------------------------------------------------------
  translate(-180,100);
  t2_fix.drawStep(lastStop, lastStop + speed);
  translate(160,0);
  t2.drawStep(lastStop, lastStop + speed);
  
  //------------------------------------------------------------
  translate(-200,110);
  t3_fix.drawStep(lastStop, lastStop + speed);
  
  translate(150,0);
  t3.drawStep(lastStop, lastStop + speed);
  
  //-Composition-Experiment-------------------------------------
  translate(-170,130);
  t4_fix.drawStep(lastStop, lastStop + speed);
  translate(150,0);
  t4.compositionTrochoid = t2_fix;
  t4.drawStep(lastStop, lastStop + speed);
  
  //------------------------------------------------------------
  translate(-40,250);
  Trochoid t5_fix = new Trochoid(2, 50, 5, 5, 0.0);
  t5_fix.drawStep(lastStop, lastStop + speed);
  
  translate(150,0);
  Trochoid t5 = new Trochoid(2, 50, 5, 5, 0.1);
  println(t5.lastX + " start");
  t5.drawStep(lastStop, lastStop + speed);
  println(t5.lastX);
    
  //============================================================
  popMatrix();
  lastStop += speed;
  //noLoop();
}


