
/////////////////////////////////////////////////
//                                             //
//                                             //
//             Code Stitching Demo             //
//                                             //
//                                             //
/////////////////////////////////////////////////

// (c) Martin Schneider 2009 - 2014
// http://www.k2g2.org/blog:bit.craft

// This is a processing interpreter for Pa++ern.

// Pa++ern is an esoteric language for embroidery
// developed by Daito Manabe and Motoi Ishibashi 
// http://www.rzm-dev.com/pattern/

// here are a couple of sample programs.
// add your own program here ...

String[] programs = {
  "(>),,,(*<<<i((o >-(>)..... >((?),.)...o >- >((?),.)...o >-(>), >(?).....o >- >(?),.),,,,....)),..",
  "(^),..(i),..((((<),),((((-(^?),,.. ^|(?>),,..(?),.)....) ((>),),)*)...)((<<v),),),",
  "iii(<^^),(>v+((>),,((?>),..)...),...*i),.",
  "?!!!f#>$$h p vvvv!!!F p >>vvvv!!!H"
};

int pp = 3;              // program pointer
String p0;               // program

// initial values
float s0 = 7.5;          // initial scale
float t0 = 0.66;         // initial thread thickness
int c0 = 0;              // initial color index
char x0 = ' ';           // initial stitch

// animation

int delay = 1;          // delay in milliseconds between stitches
int timer0 = 0;          // initial timer step
int timer;               // timer step

// deltas

float sf = 1.25;         // size increases by 125 %
float af = radians(15);  // angles rotate by 15 degrees
float cf = 1;            // color index increases by 1

// variables

String p;                // program string
float s;                 // scale or zoom
float t;                 // thread thickness
int c;                   // color index
char x = 'o';            // stitch character

int i;                   // input pointer      
int o;                   // output pointer 


// colour palette for the threads

color[] pal = { 
  #fa147f, 
  #c81000, 
  #d97400, 
  #8ef400, 
  #0ae10a, 
  #4bf4fb, 
  #00c398, 
  #0667d4, 
  #1102c6, 
  #7b03c0
};

// a stack to save our input pointer, when we enter a loop
java.util.Stack stack;

void setup() {
  
  // set up canvas
  size(340, 465); 
  noFill();
  
  // load first program
  p0 = programs[pp];
  
}


void draw() {
  
  // white background
  background(255);
  
  // pick the first color from the palette
  c = c0;
  stroke(pal[c]); 

  // reset drawing parameters
  resetMachine();
  
  // reset program parameters 
  resetProgram();

  // set the timer that controls the step-by-step drawing progress
  timer = (millis() - timer0) / delay; 

  while (i < p.length () && o < timer) {

    // get the character code at the input pointer
    char ch = p.charAt(i);

    switch(ch) {

    case 'o': 
    case '+': 
    case '-': 
    case '|': 
    case '/': 
    case ' ':
    case 'F':
    case 'f':
    case 'H':
    case 'h': 

      // draw a stitch
      x = ch; 
      drawStitch(); 
      break;

    case '?' : 
      // rotate left 
      rotate(-af); 
      break;
    case '$' : 
      // rotate right 
      rotate(af); 
      break;

    case '#':
      //empty stitch character
      x = ' ';

    case '*' : 
      // change color
      c = (c+1) % pal.length; 
      stroke(pal[c]); 
      break;

    case '<' : 
      // move left + draw a stitch
      translate(-2, 0); 
      drawStitch(); 
      break;

    case '>' : 
      // move right and draw a stitch
      translate(2, 0); 
      drawStitch(); 
      break;

    case '^' :
      // move up and draw a stitch 
      translate(0, -2); 
      drawStitch(); 
      break;

    case 'v' : 
      // move down and draw a stitch
      translate(0, 2); 
      drawStitch(); 
      break;

    case '!' : 
      // scale up
      scale(sf); 
      t /= sf; 
      strokeWeight(t); 
      break;

    case 'i' : 
      // scale down
      scale(1/sf); 
      t *= sf; 
      strokeWeight(t); 
      break;

    case 'p' : 
      // reset position to the center
      resetMachine(); 
      break;

    case '(' : 
      // begin a new loop
      openLoop(); 
      break;

    case ')' : 
      // end of loop
      closeLoop(); 
      break;
    }
    
    i++; // increase input pointer
    o++; // increase output pointer
    
  } 

}
