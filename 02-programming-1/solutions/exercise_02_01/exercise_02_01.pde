
///////// Parameters ///////// 

int fontsize = 40;
int d_sketch = 800;
int d_circle = 300;
int d_stroke = 10;
int n_stroke = 5;


///////// Parameters ///////// 

size(d_sketch, d_sketch);
background(#333399);
textFont(createFont("Arial Bold", fontsize));


///////// Dependent Variables /////////

int cy = height/ 2;
int cx = width / 2;
int ty =  int(textAscent() - textDescent()) /2 ;


///////// Concentric Circles /////////

fill(#ffffff);
stroke(#000000);
strokeWeight(d_stroke);

/*for(int i = n_stroke; i > 0; --i) {
	int d = d_circle + 4 * i * d_stroke;
	ellipse(width/2, height/2, d, d);
}*/
int distance = 20;
int colorStep = 15;
int maxWidth = 800;
int maxHeight = 800;
for(int i = 0, r = 0;
    i<18; 
    ++i, r+=4){
      stroke(i*colorStep,i*colorStep,i*colorStep);
    rect(i*distance, i*distance, maxWidth-2*i*distance, maxHeight-2*i*distance,r);
}


///////// Hello World /////////

fill(#000000);
textAlign(CENTER);
text("Feli", cx, cy + ty);
