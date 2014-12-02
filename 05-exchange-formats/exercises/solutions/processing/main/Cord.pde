class Cord{

  //member
  ArrayList<CordState> states = new ArrayList<CordState>();
  CordState currentState;
  String name;
  color stringColor;
  Braid braid;
  
  //constructor
  Cord(Braid b, String n, int pos, color c){
    braid = b;
    name = n;
    stringColor = c;
    addState(new CordState(-1, pos, 0, false));
    currentState = states.get(states.size()-1);
  }
  
  //methods
  void updateStateWithBraidWord(int word, int step){    
    //check if relevant lane change
    Cord neighbor = null;
    if(currentState.toLane == abs(word)-1){  //left to right (compare start index and target index)
      //if(currentState.step == step) stepChange = 1;
      neighbor = braid.getCordOnLane(currentState.toLane+1); //right of
      addState(new CordState(currentState.toLane, currentState.toLane+1,currentState.step+1, word>=0));
    }
    else if(currentState.toLane == abs(word)){  //right to left
      //if(currentState.step == step) stepChange = 1;
      neighbor = braid.getCordOnLane(currentState.toLane-1); //left of
      addState(new CordState(currentState.toLane, currentState.toLane-1,currentState.step+1, word<0));
    }
    else{  //add "empty" state change //new: do nothing
      //addState(new CordState(currentState.toLane, currentState.toLane, currentState.step, false));
    }
  }
  
  void addState(CordState state){
    states.add(state);
    currentState = new CordState(state);
  }
  
  void drawAllCordStates(){
    ListIterator<CordState> iter = states.listIterator();
    while(iter.hasNext()){  
      iter.next().drawCordState(stringColor);
    } 
  }
  
  void drawAllCordStates(boolean onTopValue){
    ListIterator<CordState> iter = states.listIterator();
    while(iter.hasNext()){
      CordState cs = iter.next();   
      if(cs.isTopCord == onTopValue) cs.drawCordState(stringColor);
    } 
  }
}

//--------------------------------------------------------------------

class CordState{
  //member
  int fromLane;
  int toLane;
  int step;  // = y-pos ?
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
    if(fromLane != -1){
      stroke(c);
      float x1 = fromLane*GAP_X + OFFSET_X;
      float x2 = toLane*GAP_X   + OFFSET_X;
      float y1 = (step)*GAP_Y   + OFFSET_Y;
      float y2 = (step+1)*GAP_Y + OFFSET_Y;
      line(x1, y1, x2, y2);
    }
  }
}
