import java.util.ListIterator;

void setup(){
  //initialize
  size(400, 400);
  background(255);
  
  int[] input = new int[]{1,-4,2,-3};
  Braid b = new Braid(input, 5);
  doStuff(b);
  
  //take input and create cords accordingly
}

void doStuff(Braid b){
  b.braid(2);
  println(b.toString());
}

void draw(){
  println("Ready to braid?");
  
  noLoop();
}
