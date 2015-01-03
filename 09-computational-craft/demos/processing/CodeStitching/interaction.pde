

void keyPressed() {

  switch(key) {

  case ' ': 
    // proceed to the next program + reset timer
    pp = (pp + 1) % programs.length;
    p0 = programs[pp];

  case 'r':
    // reset timer, i.e. redraw
    timer0 = millis();
    break;

  case 's':
    // save embroidery to external file 
    output = true;
    break;
    
  }
}
