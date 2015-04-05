

class LSystem {

  String axiom = "X";
  String ruleX = " F-[[X]+X]+F[+FX]-X";
  String ruleF = "FF";

  float d = 1;
  float ang = TWO_PI/360.0 * 25.0;
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

      case 'F':
        output += ruleF;
        break;

      default:
        output += ch;
        
      }
    }
    return output;
  }

  // interpretation
  void render() {

    float x = 20;//width * 2/3;
    float y = height * 1/2;
    FloatList angles = new FloatList();
    FloatList posX = new FloatList();
    FloatList posY = new FloatList();
    float currentAngle = 0.0;
    
    for (int i = 0; i < seq.length(); i++) {

      char ch = seq.charAt(i);
      
      switch(ch) {

      case 'F':
        line(x, y, x += cos(currentAngle)*d, y += sin(currentAngle)*d);
        break;

      case '+':
        currentAngle += ang;
        break;

      case '-':
      currentAngle -= ang;
        break;
        
      case '[':
        angles.append(currentAngle);
        posX.append(x);
        posY.append(y);
        break;
        
      case ']':
        int sizeA = angles.size();
        int sizeXY = posX.size();
        
        currentAngle = angles.get(sizeA-1);
        angles.remove(sizeA-1);
        
        x = posX.get(sizeXY-1);
        y = posY.get(sizeXY-1);
        posX.remove(sizeXY-1);
        posY.remove(sizeXY-1);
        println(seq.length());
        
        break;
      }
    }

  }

}

