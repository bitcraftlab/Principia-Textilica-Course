import java.util.ListIterator;

public static final int OFFSET_X = 50;
public static final int OFFSET_Y = 50;

void setup(){
  //initialize
  size(400, 400);
  background(255);
  
  int[] input = new int[]{1,-4,2,-3};
  Braid b = new Braid(input, 5);
  doStuff(b);
  draw(b);
  
  //take input and create cords accordingly
}

void doStuff(Braid b){
  b.braid(3);
  println(b.toString());
}

void draw(Braid b){
  println("Ready to braid?");
  
  b.drawCordStates();

  
  noLoop();
}
