
/////////////////////////////////////////////////
//                                             //
//                 Image Draft                 //
//                                             //
/////////////////////////////////////////////////

class ImageDraft extends Draft {
  
  // image to hold the drawdown
  PGraphics g;

  // simple black and white palette
  color[] bwpalette = { #ffffff, #000000 };
  
  PImage getDraft() {  
    
    // compute image dimensions
    int gap = 1;
    int off1 = dobby ? shafts : treadles;
    int off2 = shafts;
    int w = warp + off1 + gap;
    int h = weft + off2 + gap;
 
    int[][] showDrawdown = drawdown;
    if (colorDrawdown != null) showDrawdown = colorDrawdown;
        
    g = createGraphics(w, h, JAVA2D);
    g.beginDraw();
    
    // gray background
    g.background(#cccccc);
    
    // shift origin
    g.translate(g.width-off1-gap, off2+gap); 
    
    
    g.scale(+1,+1); 
    image(dobby ? liftplan : treadling, + gap, 0); 
    
    g.scale(-1,+1); 
    image(showDrawdown, palette, 0, 0);
    
    // exchange x and y
    g.applyMatrix(0,1,0,1,0,0);   
    g.scale(-1,+1); image(threading, gap, 0); 
    g.scale(+1,-1);image(dobby ? straight : tieup, gap, gap); 
    
    g.endDraw();
    return g;
  }

  // matrix to image
  void image(int[][] m, int x, int y) {
    g.image(mat2img(m, bwpalette), x, y);
  }

  // matrix to image with palette
  void image(int[][] m, color[] palette, int x, int y) {;
    g.image(mat2img(m, palette), x, y);
  }
  
  // load drawdown from image file
  void loadDrawdown(String name) {
    loadDrawdown(name, true, true);
  }
  
  // load drawdown from imagefile and compute threading + treadling sequences
  void loadDrawdown(String name, boolean doTreadling, boolean doThreading) {
    
    PImage img = loadImage(name);
    tieup = flipX(img2mat(img, bwpalette));
    drawdown = tieup;
    
    // compute treadling sequence
    if(doTreadling) {
      int[][][] f = yfactor(tieup); 
      tieup = f[0]; treadling = f[1];
    } else {
      treadling = unitMatrix(tieup.length);
    }

    // compute threading sequence
    if(doThreading) {
       int[][][] f = xfactor(tieup); 
       tieup = f[0]; threading = f[1];
    } else {
     threading = unitMatrix(tieup[0].length);
    }
    
    // assign dimensions
    weft = drawdown.length;
    warp = drawdown[0].length; 
    treadles = treadling[0].length;
    shafts = tieup[0].length;
    dobby = false;
    
    // fill in the gaps
    completeData();
    
  }
  
  void saveDrawdown(String name) {
    
    // flip the drawdown matrix and save it as an image
    PImage img = mat2img(flipX(drawdown), bwpalette);
    img.save(name); 
    
  }
  
}

