
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
/*for(int i = 15, int r = 0, int w = 10; 
    i>0; 
    --i, ++r, w+=10){*/
    rect(0,0,10,10,0);
//}


///////// Hello World /////////

fill(#000000);
textAlign(CENTER);
text("Feli", cx, cy + ty);
