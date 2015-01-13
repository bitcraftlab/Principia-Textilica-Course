

class LSystem {

  String axiom = "XF";
  String ruleX = "X+YF+";
  String ruleY = "-FX-Y";

  float d = 3;
  float ang = HALF_PI;
  String seq;

  LSystem(int iter) {
    generate(iter);
  }

  void generate(int iter) {
    seq = axiom;
    for (int i = 0; i < iter; i++) {
      seq = iterate(seq);
    }
  }


  String iterate(String input) {

    String output = "";     

    for (int i = 0; i < input.length (); i++) {
      char ch = input.charAt(i);

      // hard coding the rules here, to simplify things
      switch(ch) {

      case 'X': 
        output += ruleX;
        break;

      case 'Y':
        output += ruleY;
        break;

      default:
        output += ch;
        
      }
    }
    return output;
  }

  // interpretation
  void render() {

    float x = width * 2/3;
    float y = height * 1/2;
    float dir = 0;
    
    for (int i = 0; i < seq.length(); i++) {

      char ch = seq.charAt(i);
      
      switch(ch) {

      case 'F':
        line(x, y, x += cos(ang * dir) * d , y += sin(ang * dir) * d);
        break;

      case '+':
        dir += 1;
        break;

      case '-':
        dir -= 1;
        break;
        
      }
    }

  }

}

