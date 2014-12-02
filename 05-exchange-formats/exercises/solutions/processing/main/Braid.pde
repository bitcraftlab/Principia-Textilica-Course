class Braid{
  //member
  Cord[] cords;
  int[] pattern;
  int step = 0;
  LinkedList<Integer> words = new LinkedList<Integer>();
  
  //constructor 
  Braid(int[] input, int noCords, int[] colors){
    if(colors == null){
      colors = new color[noCords];
      for(int i = 0; i<noCords; ++i){
        colors[i] = color(random(256), random(256), random(256));
      }
    }
    pattern = input;
    
    cords = new Cord[noCords];
    for(int i = 0; i<noCords; ++i){
      cords[i] = new Cord(str(i), i, colors[i]);
    }
  }
  
  //methods
  void braid(int rep){
    
    //repeat input pattern until... it's enough
    for(int i = 0; i< rep; ++i){
      for(int s = 0; s < pattern.length; ++s){
        int stepIncrease = 0;
        for(Cord c : cords){
          //check for every cord if step has to be increased
          //stepIncrease can be 1 or 0, don't let it reset to 0 if it already was 1
          stepIncrease = max(stepIncrease, c.updateStateWithBraidWord(pattern[s], step));
        }
        words.add(pattern[s]);
        step += stepIncrease;
      }
    }
  }
  
  Cord getCordOnLane(int lane){
    //find cord with current tolane at lane 
  }
  
  void drawCordStates(){
    for(Cord c : cords){
        c.drawAllCordStates(false);
    }
    for(Cord c : cords){
        c.drawAllCordStates(true);
    }
  }
  
  String toString(){
    String txt = "";
    int laneLength = cords[0].states.size();
    String[] ordered = new String[cords.length];  //order by lane instead of cords
    for(int i = 0; i<laneLength; ++i){
      //sort by lane for that step, put in name
      for(Cord c : cords){
        ordered[c.states.get(i).toLane] = c.name;
      }
      
      for(String n : ordered){
        txt += (n + " ");
      }
      txt+="\n";
    }
    return txt;
  }
  
  void flipCordsAtLane(int w){
    words.add(w);
    
    for(Cord c : cords){
      c.updateStateWithBraidWord(w, step);
    }
    ++step;
  }
  
  String getWord(){
    String completeWord = "";
    ListIterator<Integer> iter = words.listIterator();
    while(iter.hasNext()){
      completeWord += (iter.next() + " ");   
    }
     return completeWord; 
  }
}
