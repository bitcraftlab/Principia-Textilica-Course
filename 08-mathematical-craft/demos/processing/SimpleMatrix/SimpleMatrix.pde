
/////////////////////////////////////////////////
//                                             //
//              Simple Matrix                  //
//                                             //
/////////////////////////////////////////////////


void setup() {

  // a simple sequence
  int[] seq = {
    1, 2, 3, 4, 3, 2, 1, 2, 3, 4, 3, 2, 1, 2, 3
  };

  // convert sequence to matrix
  int[][] mat = seq2mat(seq, 4);

  // print matrix to console
  println(mat);

  // show matrix on screen
  PImage img = mat2img(mat);
  noSmooth();
   
  // scale + center the image
  translate(width/2, height/2);
  scale(width / img.width);
  translate(-img.width/2, -img.height/2);

  // display the image
  image(img, 0, 0);
  
}






