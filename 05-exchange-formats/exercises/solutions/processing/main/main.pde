import java.util.ListIterator;
import java.util.LinkedList;

public static final int OFFSET_X = 50;
public static final int OFFSET_Y = 0;
public static final int GAP_X = 10;
public static final int GAP_Y = 12;

String typed = "";
Braid b = null;

void setup(){
  //initialize
  size(400, 600);
  background(255);
  strokeWeight(8);
  
  color[] colors = new color[]{#EE4357, #851E2A, #D9A96A, #85581E, #6A9AD9 };
  
  int[] input1 = new int[]{1,-4,-2, 3};
  int[] input2 = new int[]{1,-4,-2, 3, 5,-8,-6,7};
  b = new Braid(input1, 5, null);
  //b = new Braid(input1, 9, null);
  b.braid(2);
  draw();
}

void draw(){  
  b.drawCordStates();
  noLoop();
}

void keyPressed(){
  if(key == '\n'){
    int flipLane = Integer.parseInt(typed);
    if(flipLane != 0 && flipLane > -(b.cords.length) && flipLane < b.cords.length) b.flipCordsAtLane(flipLane);
    redraw();
    typed = "";
  }
  else if(key == 'p' || key == 'P'){
    //println(b.toString());
    println(b.getWord());
    typed = "";
  }
  else if(key == 's' || key == 'S'){
    println(b.toString());
    typed = "";
  }
  else{
    typed += key;
  }
}
