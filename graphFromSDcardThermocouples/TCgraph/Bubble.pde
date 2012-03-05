

class VoltGraph {
  float V;
  float I;
  float stuffLength;
  String dat;
  float WX;//=random(50,150);
  float col;

  // The constructor initializes size and name
  // Location is filled randomly
  VoltGraph(float _V, float _I, float SL, String _dat, float W, float _col) {
    V = _V;
    I=_I;
    SL=stuffLength;
    dat=_dat;
    WX=W;
    col = _col;
  }

  // Display the obj
  void display() {
    //stroke(0);
    fill(V/2, 75);
  float ht=map(height, 0, height, 0, 255);
    stroke(0,col,0);
   line(I, height-V, I, height+V/4);

  }

  // Move the obj
  void drift() {

  }
  void info() {
    fill(0);
    float myMouse = map(mouseX, 0, width, -width/4, width+width/4);
    
    
    //if (mouseX>I-.1&&mouseX<I+.1) {
   if (myMouse>I-.1&&myMouse<I+.1) {
      //scale(0.5);
      //translate(-width/2+ mouseX,0);
      
     text(dat, I, mouseY);
       
    }
  }
}

