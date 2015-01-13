import controlP5.*;

ControlP5 cp5;

int lastStop = 0;
int speed = 2;
float lastX = 0.0;
float lastY = 0.0;
float scaleFactor = 1.5;

float goal = 0.0;


Trochoid t1_fix;
Trochoid t1;

void setup(){
  size(900, 900);
  cp5 = new ControlP5(this);
  // name, minValue, maxValue, defaultValue, x, y, width, height
  cp5.addSlider("slider_R", 1, 200, 50, 10, 10, 200, 14)
     .setTriggerEvent(Slider.RELEASE);
  
  t1_fix = new Trochoid(1, 42, 8, 5, 0.0);
  t1 = new Trochoid(1, 42, 8, 5, 0.1);
  goal = 42.0;
   
}

void slider_R(int val) {
  goal = val;
}

void draw(){

  pushMatrix();  

  t1_fix.drawStep(lastStop, lastStop + speed);
  translate(120, 200);
  t1.drawStep(lastStop, lastStop + speed);
  
  //-------------------------
  if(abs(t1.R - goal) > 0.005){
    t1.R += t1.R-goal >0? -0.02 : 0.02;
  }
     
  //============================================================
  popMatrix();
  lastStop += speed;
  //noLoop();
}


