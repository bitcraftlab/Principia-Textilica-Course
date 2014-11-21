class Braid{
  //member
  Cord[] cords;
  int[] pattern;
  int step = 0;
  
  //constructor
  Braid(int[] input, int noCords){
    pattern = input;
    
    cords = new Cord[noCords];
    for(int i = 0; i<noCords; ++i){
      color c = color(i*50, i*i*20, 255-(i*50));
      cords[i] = new Cord(str(i), i, c);
    }

  }
  
  //methods
  void braid(int rep){
    //repeat input pattern until... it's enough
    for(int i = 0; i< rep; ++i){
      for(int s = 0; s < pattern.length; ++s){
        for(Cord c : cords){
          c.updateStateWithBraidWord(pattern[s], step);
        }
        ++step;
      }
    }
  }
  
  void drawCordStates(){
    //cords[0].drawAllCordStates();
    for(Cord c : cords){
        c.drawAllCordStates();
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
        //txt += (str(c.lanes.get(i).toLane) + " ");    //if done properly, would check step value in cordstate obj...
      }
      
      for(String n : ordered){
        txt += (n + " ");
      }
      txt+="\n";
    }
    return txt;
  }
}
