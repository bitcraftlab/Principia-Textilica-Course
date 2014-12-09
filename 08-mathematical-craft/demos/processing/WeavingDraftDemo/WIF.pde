
/////////////////////////////////////////////////
//                                             //
//                  W. I. F.                   //
//                                             //
/////////////////////////////////////////////////


// Reader/Writer for WIF files (Weaving Interchange Format)
// See: http://www.mhsoft.com/wif/wif.html
// This class can currently only *read* WIF files

class WIF  {

  HashMap sections = new HashMap();

  void load(String name) {

    // get all the lines as an array of strings
    String[] lines = loadStrings(name);
    HashMap keys = null;   
    String title = "";
  
    for(int i=0; i<lines.length; i++) {
      
      // get key value pairs
      String km[] = match(lines[i], "(.*?)=(.*)");
      if(km != null && keys != null) {
        keys.put(km[1], km[2]);
        continue;
      }
      
      // get the comment lines
      String cm[] = match(lines[i],  "^;.*");
      if(cm != null) continue;
      
      // get section header
      String sm[] = match(lines[i], "\\[(.*)\\]");
      if(sm != null) {
        if (keys != null) sections.put(title, keys);
        title = sm[1]; 
        keys = new HashMap();
      }
      
    }
    
    sections.put(title, keys);
    
  }
  
  // get section by title
  HashMap getSection(String title) {
    return (HashMap) sections.get(title);
  }
  
  
  // get value by section + key
  String getVal(String section, String theKey) {
    return (String) getSection(section).get(theKey);  
  }
  
  
  // get value by section + key (with default value)
  String getVal(String section, String theKey, String defaultVal) {
    Object val = getSection(section).get(theKey);
    return (val==null) ? defaultVal : (String) val;
  }
  
  // get value as integer
  int getInt(String title, String theKey) {
    return getInt(title, theKey, 0);
  }
  
  int getInt(String title, String theKey, int defaultVal) {
    return int(getVal(title, theKey, str(defaultVal)));
  }
  
  // get value as boolean
  boolean getBool(String title, String theKey) {
    String val = getVal(title, theKey, "0");
    return (val.equals("yes") || val.equals("true") || val.equals("on") || val.equals("1"));
  }
  
  // get value as array
  int[][] getArray(String title, int fields) {
    return getArray(title, fields, 0);
  }
  
  int[][] getArray(String title, int fields, int defaultVal) {
    HashMap hm = getSection(title);
    int[][] a = new int[fields][];
    for(int i=1; i<=fields; i++) {
      String s = (hm != null) && hm.containsKey(str(i)) ? (String) hm.get(str(i)) : str(defaultVal);
      a[i-1] = int(split((String) s,","));
    }
    return a;
  }
  
}
