class Cord{

  //member
  ArrayList<CordState> states = new ArrayList<CordState>();
  CordState currentState;
  String name;
  color stringColor = color(255, 0, 0);
  
  //constructor
  Cord(String n, int pos){
    name = n;
    addState(new CordState(pos, pos, 0, false));
    currentState = states.get(states.size()-1);
  }
  
  //methods
  void updateStateWithBraidWord(int word, int step){
    //check if relevant lane change
    if(currentState.toLane == abs(word)-1){  //left to right (compare start index and target index)
      addState(new CordState(currentState.toLane, currentState.toLane+1,step, word>=0));
    }
    else if(currentState.toLane == abs(word)){  //right to left
      addState(new CordState(currentState.toLane, currentState.toLane-1,step, word<0));
    }
    else{  //add "empty" state change
      addState(new CordState(currentState.toLane, currentState.toLane, step, false));
    }
  }
  
  void addState(CordState state){
    states.add(state);
    currentState = new CordState(state);
  }
  
  void drawCordState(int i){
    states.get(i);
  }
  
  void drawAllCordStates(){
    ListIterator<CordState> iter = states.listIterator();
    while(iter.hasNext()){  
      iter.next().drawCordState(stringColor);
    } 
  }
}

//--------------------------------------------------------------------

class CordState{
  //member
  int fromLane;
  int toLane;
  int step;
  boolean isTopCord;
  
  //constructor
  CordState(int fL, int tL, int s, boolean top){
    fromLane = fL;
    toLane = tL;
    step = s;
    isTopCord = top; 
  }
  
  CordState(CordState cs){
    fromLane = cs.fromLane;
    toLane = cs.toLane;
    step = cs.step;
    isTopCord = cs.isTopCord;
  }
  
  //methods
  void drawCordState(color c){
    stroke(c);
    line(fromLane*5, step*10, toLane*5, step*10);  
    //5 px x-difference between lanes and 10 px y-difference between steps
  }
}
