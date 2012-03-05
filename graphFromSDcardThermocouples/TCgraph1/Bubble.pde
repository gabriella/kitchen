

class VoltGraph {
  float V, V1, V2, V3, V4, V5, V6, V7;

  float I;
  float stuffLength;
  String dat;
  float WX;//=random(50,150);
  float col;

  // The constructor initializes size and name
  // Location is filled randomly
  VoltGraph(float _V,float _V1,float _V2,float _V3,float _V4,float _V5,float _V6,float _V7, float _I, float SL, String _dat, float W, float _col) {
    V = _V;
    V1 = _V1;
    V2 = _V2;
    V3 = _V3;
    V4 = _V4;
    V5 = _V5;
    V6 = _V6;
    V7 = _V7;

    I=_I;
    SL=stuffLength;
    dat=_dat;
    WX=W;
    col = _col;
  }

  // Display the obj
  void display() {
    //stroke(0);
   
    float ht=map(height, 0, height, 0, 255);
    stroke(0,col,0, 100);
    line(I, height-V, I, height+V/4);


    //DO AN ARRAY HERE!!



fill(0, 20);
    line(I, height-V1, I, height+V/4);
    stroke(50, 80);
    line(I, height-V2, I, height+V/4);
        stroke(80,255, 9, 80);
   
    line(I, height-V3, I, height+V/4);
            stroke(0,255, 9, 80);
    line(I, height-V4, I, height+V/4);
            stroke(255,255, 9, 80);
    line(I, height-V5, I, height+V/4);
            stroke(80,180, 255, 80);
    line(I, height-V6, I, height+V/4);
            stroke(200,1, 9, 80);
    line(I, height-V7, I, height+V/4);
        stroke(0,255, 180, 80);  
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

