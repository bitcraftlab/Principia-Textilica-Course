
/////////////////////////////////////////////////
//                                             //
//              Interaction                    //
//                                             //
/////////////////////////////////////////////////

void mouseDragged() {
  
  xoffset += (mouseX - pmouseX);
  yoffset += (mouseY - pmouseY);
  
}


void keyPressed() {
  
  switch(key) {
    
    case '+': 
      zoom += 1;
      break;
      
    case '-':
      if (zoom>1) zoom -= 1;
      break;
      
    case 'd':
      w.dobby = !w.dobby;
      img = w.getDraft();
      break;
      
    case 's':
      selectInput("Save Drawdown", "saveDrawdown");
      break;
      
    case 'l':
      selectInput("Load Drawdown", "loadDrawdown");
      break;
      
  }
}


void saveDrawdown(File select) {
  
  if (select != null) {
    String path = select.getAbsolutePath();
    println("Saving draft to " + path);
    w.saveDrawdown(path);
  }
  
}


void loadDrawdown(File select) {
  
  if (select != null) {
    String path = select.getAbsolutePath();
    println("Loading draft from " + path);
    w.loadDrawdown(path);
  }
  
}

