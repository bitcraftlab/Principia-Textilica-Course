
/////////////////////////////////////////////////
//                                             //
//                  Palette                    //
//                                             //
/////////////////////////////////////////////////

// Class to manage indexed colors

class Palette {
  
  // We are using a hashmap  (Color -> Idx)
  // so we can look up the index for a given color
  
  HashMap idx = new HashMap();
  color[] pal;
  
  Palette(color[] _pal) {
    
    // get the palette
    pal = _pal;
    
    // create a hashmap of colors, so we can access them by index
    for(int i=0; i<pal.length; i++) {
      idx.put(new Integer(pal[i]), new Integer(i));
    }
    
  }
  
  // get color by index
  color getColor(int i) {
    return pal[i];
  }
  
  // get the index of
  int getIndex(color i) {
    
    // look up the index for the color
    Object k = idx.get(new Integer(i));
    
    // return color value (or 0 if the color is not in the index)
    return k != null ? ((Integer) k).intValue() : 0;
  }
  
} 

