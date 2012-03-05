//getting nullpointer with new data figure out why - have to say something
//like if values.length>0?, voltage>0?

import processing.opengl.*;
PFont writing;
int scalint;
boolean zoom;
VoltGraph[] voltages;
float writX ;
 float[] values;

void setup() {
  size(700,300, OPENGL);
  smooth();
  writing = loadFont("SansSerif-48.vlw");
  textFont(writing, 8);
    colorMode(HSB, 360, 100, 100, 100);
  // Load text file as an array of Strings
  String[] data = loadStrings("DATA.txt");
 // println(data.length);
  
  
  // The size of the array of Bubble objects is determined by the total number of lines in the text file.
  voltages = new VoltGraph[data.length]; 
  for (int i = 0; i < voltages.length; i ++ ) {
    // Each line is split into an array of floating point numbers.
     values = float(split(data[i], "," )); 
    // println(values.length);
  if(values.length>=2){
   float vals = map(values[2], 0,5, 0, height);
//println(vals);
    // The values in the array are passed into the Bubble class constructor.
    float newI = map(i, 0, data.length, 0, width);
   if(vals>=0){
    voltages[i] = new VoltGraph(vals, newI, data.length, data[i], random(50,150)); 
  }
 // println(voltages[i]);
 // println(data[i]);
  //  println("length"+data.length);
    //print("i"+i);
  }
}
}
void draw() {
  
  background(255);
  translate(width/2, height/2);

  if (zoom==true){
    scal(mouseX, mouseY);
//    if(mouseX>
//    text(writing, 
    //scale(scalint);
}

  translate(-width/2, -height/2);
  // Display and move all bubbles
 
   // if(data.length>0){
   //  println(voltages.length);
  for (int i = 0; i < voltages.length; i ++ ) {
    voltages[i].display();
    //voltages[i].drift();
 // }
  }
bool();


}


void scal(int xScal, int yScal){
  scalint=2;
  scale(scalint);
  //pushMatrix();
   
        translate(width/2- xScal, height/2-yScal);
      //  popMatrix();

}

void bool(){
 if (mousePressed){
  zoom=true;

      
  for (int i = 0; i < voltages.length; i ++ ) {
    voltages[i].info();
            //translate(width/2- mouseX);
  }


 } 
 else{zoom=false;}
}
