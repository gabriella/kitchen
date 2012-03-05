//not as tall, range 
//heat map, mouseover

import processing.opengl.*;
PFont writing;
int scalint;
boolean zoom;
float MYvalues;
float[]values;
VoltGraph[] voltages;
float writX ; 
PrintWriter output;
void setup() {

  size(1200,500, OPENGL);
  smooth();
  writing = loadFont("SansSerif-48.vlw");
  textFont(writing, 8);
  // Load text file as an array of Strings
  String[] data = loadStrings("DATA.txt");
    output = createWriter("dataClean.txt"); 
 // String[]data = loadStrings("DATADATA_apr14.txt");
 // println(data);
  for(int j=0;j<data.length;j++) {
    data[j] = data[j].trim();
  }

  // The size of the array of Bubble objects is determined by the total number of lines in the text file.
  // if(data[]=!"null"){

  voltages = new VoltGraph[data.length]; 
  for (int i = 1; i < voltages.length; i ++ ) {
    // Each line is split into an array of floating point numbers.
//println(voltages.length);
    values = float(split(data[i], "," ));
   // data = trim(data);

//    if(values.length>4) {
   // println(i);

 MYvalues = values[2];
String myvalues = str(MYvalues);
//println(myvalues);
myvalues = trim(myvalues);
float myfloatvalues = float(myvalues);

     output.println(int(myfloatvalues)); // Write the coordinate to the file




//if(values.length>1){
  
 // println(values[5]);
float vals = map(values[5], 70, 95, 0 , height);
float vals1 = map(values[3], 70, 95, 0 , height);
float vals2 = map(values[4], 70, 95, 0 , height);
float vals3 = map(values[2], 70, 95, 0 , height);
float vals4 = map(values[6], 70, 95, 0 , height);
float vals5 = map(values[7], 70, 95, 0 , height);
float vals6 = map(values[8], 70, 95, 0 , height);
float vals7 = map(values[9], 70, 95, 0 , height);

     // float vals = map(values[2], -1,6, 0, height);
      float colorVals = map(values[5], 70,90,0,255);

      // The values in the array are passed into the  class constructor.
      float newI = map(i, 7000, data.length, 0, width);

    //  voltages[i] = new VoltGraph(vals, vals1, vals2, vals3, vals4, vals5, vals6, vals7, newI, data.length, data[i], random(50,150), colorVals); 

       // println("length"+data.length);
      //print("i"+i);
    //}
   // }
  }
}


void draw() {

  background(255);
  translate(width/2, height/2);

  if (zoom==true) {
    scal(mouseX, mouseY);
    //    if(mouseX>
    //    text(writing, 
    //scale(scalint);
  }

  translate(-width/2, -height/2);
  // Display and move all bubbles
 
  for (int i = 7000; i < voltages.length; i ++ ) {
     
    if(values.length>1) {
      voltages[i].display();
    
  }
  }
  bool();
}


void scal(int xScal, int yScal) {
  scalint=2;
  scale(scalint);

  translate(width/2- xScal, height/2-yScal);
}

void bool() {
  if (mousePressed) {
    zoom=true;


    for (int i = 7000; i < voltages.length; i ++ ) {
      if(values.length>1) {
        voltages[i].info();
      }
   
    }
  } 
  else {
    zoom=false;
  }
}
void keyPressed() {
  println("written");
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
  //exit(); // Stops the program
}

