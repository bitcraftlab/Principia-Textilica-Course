
/////////////////////////////////////////////////
//                                             //
//                     Draft                   //
//                                             //
/////////////////////////////////////////////////

class Draft {
 
  // dobby or treadle loom
  boolean dobby;
  
  // dimensions of the draft
  int warp;
  int weft;
  int shafts;
  int treadles;
  
  // matrices
  int[][] threading;
  int[][] treadling;
  int[][] straight;
  int[][] tieup;
  int[][] liftplan; 
  int[][] drawdown;
  int[][] colorDrawdown;
  
  // colors
  color[] palette = { #ffffff, #000000 };
  int[][] warpColors;
  int[][] weftColors;
  int colorRange;
  
  // WIF reader
  WIF wif = new WIF();
  
  // load a WIF file
  void load(String name) {
    wif.load(name);
    readWif();
    completeData();
  }
  
  // parse the WIF file
  void readWif() {
    
    // read draft dimensions
    warp = wif.getInt("WARP", "Threads");
    weft = wif.getInt("WEFT", "Threads");
    shafts = wif.getInt("WEAVING", "Shafts");
    treadles = wif.getInt("WEAVING", "Treadles");
    
    // get threading matrix
    threading = getMatrix("THREADING", warp, shafts);
    
    // check wether the data is for a dobby loom (liftplan) or a treadle loom (treadling) 
    // and load the respective data
    if (wif.getBool("CONTENTS", "LIFTPLAN")) {
      dobby = true;
      liftplan = getMatrix("LIFTPLAN", weft, shafts);
    } else {
      dobby = false;
      tieup = getMatrix("TIEUP", treadles, shafts);
      treadling = getMatrix("TREADLING", weft, treadles);     
    }
    
    // get the sequence of warp colors
    warpColors = wif.getArray("WARP COLORS", warp, wif.getInt("WARP", "Color", 0));
   
    // get the sequence of weft colors
    weftColors = wif.getArray("WEFT COLORS", weft, wif.getInt("WEFT", "Color", 1));    
  
    // check if we have a color palette
    if (wif.getBool("CONTENTS", "COLOR PALETTE")) {
      
      // get the size of the palette
      int entries = wif.getInt("COLOR PALETTE", "Entries");
      palette = new color[entries];
      
      // get the colors entries
      int[][] ct = wif.getArray("COLOR TABLE", entries);
      
      // get the color range and adapt the Processing color mode accordingly
      int[] range = int(split(wif.getVal("COLOR PALETTE", "Range"),","));
      g.colorMode(RGB, range[1]-range[0]);
      
      // create colors and assign them to the palette
      for(int i=0; i<entries; i++) {
        palette[i] = color(ct[i][0]-range[0], ct[i][1]-range[0], ct[i][2]-range[0]);  
      }
    } 

  }
  
  // get array from the wif reader, and turn it into a matrix
  int[][] getMatrix(String name, int ymax, int xmax ) {
    return seq2mat(wif.getArray(name, ymax), xmax);
  }
  
  // compute data that was not specified in the WIF file
  void completeData() {
    
    if(dobby) {
     // compute treadling and tieup from the liftplan
     int[][][] u = yfactor(liftplan); 
     tieup = u[0]; 
     treadling = u[1];
    } else {
      // compute liftplan from treadling and tieup
      liftplan = multiply(treadling, tieup); 
    }
  
    if (drawdown == null) {   
      // compute the drawdown from the liftplan and the threading
      drawdown = multiply(liftplan, transpose(threading));  
    }
    
    if (warpColors != null && weftColors != null) {
      //use warp and weft colors to color the drawdown
      colorDrawdown = colorMat(drawdown, warpColors, weftColors);
    }
    
    straight = unitMatrix(shafts); 
    
  }
   
}


