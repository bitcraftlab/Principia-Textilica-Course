
/////////////////////////////////////////////////
//                                             //
//              Conversion Functions           //
//                                             //
/////////////////////////////////////////////////

// functions to convert between sequences, matrices and images

import java.util.Arrays;

// Convert from sequence to matrix

int[][] seq2mat(int[][] seq, int xmax) {
  
  // create the matrix xmax * ymax
  int ymax = seq.length ;
  int[][] mat = new int[ymax][xmax]; 
 
  // fill the matrix with values 
  for(int y=0; y<ymax; y++) { 
    for(int i = 0; i<seq[y].length; i++) {
      int x = seq[y][i]-1;
      if(x>=0 && x<xmax) mat[y][x] = 1; 
    }
  }
  return mat;
}


// convert from  matrix to image using the palette

PImage mat2img(int[][] m, color[] pal) {
  
  // create an image of xmax * ymax
  int ymax = m.length, xmax = m[0].length;
  int pmax = pal.length, pxls = ymax*xmax;
  PImage img = createImage(xmax, ymax, RGB);
  
  // set the pixels 
  img.loadPixels();
  for(int i = 0; i < pxls; i++) {
    img.pixels[i] = pal[m[i/xmax][i%xmax]%pmax];
  }
  img.updatePixels();
  return img;
}


// convert image to matrix using the palette

int[][] img2mat(PImage img, color[] pal) {
  int ymax = img.height, xmax = img.width;
  int [][] m = new int[ymax][xmax];
  Palette ppal = new Palette(pal);
  img.loadPixels();  
  for(int y = 0; y < ymax; y++) {
    for(int x=0; x<xmax; x++) {
      m[y][x] = ppal.getIndex(img.pixels[y*xmax+x]);
    }
  }
  return m;
}

