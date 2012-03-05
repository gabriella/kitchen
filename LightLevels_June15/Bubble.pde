

class VoltGraph {
  float V;
  float I;
  float stuffLength;
  String dat;
  float WX;//=random(50,150);

  // The constructor initializes color and size
  // Location is filled randomly
  VoltGraph(float _V, float _I, float SL, String _dat, float W) {
    V = _V;
    I=_I;
    SL=stuffLength;
    dat=_dat;
    WX=W;
  }

  // Display the Bubble
  void display() {
   
    float v = map(V,0,height, 0, 200);
   stroke(v);

line(I, height-V, I, height);
  //  rect(I, height, 1, -V);
  
beginShape(LINES);
stroke(0,0,0,0);
//vertex(

}

 
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

