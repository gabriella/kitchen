//import Serial communication library
import processing.serial.*;

//init variables
Serial commPort;
float tempC;
float tempF;
int yDist;
PFont font12;
PFont font24;
float[] tempHistory = new float[100];



void setup()
{
  //setup fonts for use throughout the application
  font12 = loadFont("Verdana-12.vlw"); 
  font24 = loadFont("Verdana-24.vlw"); 
  println(Serial.list());
  //set the size of the window
  size(210, 200);

  //init serial communication port
  String portName = Serial.list()[0];
  commPort = new Serial(this, portName, 9600);
  commPort.clear();
  commPort.bufferUntil('\n');



  //fill tempHistory with default temps
  for(int index = 0; index<100; index++)
    tempHistory[index] = 0;
}

void draw()
{
}
void serialEvent(Serial myPort) {

  String inString = commPort.readStringUntil('\n');
  //get the temp from the serial port
  //  while (commPort.available() > 0) 
  {

    if(inString !=null) {
      inString = trim(inString);
      float incomingValues[] = float(split(inString, ","));
      println(incomingValues);
      tempF= incomingValues[1]; 
      
      println(incomingValues[1]); 
      //tempC = commPort.read();

      //refresh the background to clear old data
      background(123);

      //draw the temp rectangle
      colorMode(RGB, 160);  //use color mode sized for fading
      stroke (0);
      rect (49,19,22,162);
      //fade red and blue within the rectangle
      for (int colorIndex = 0; colorIndex <= 160; colorIndex++) 
      {
        stroke(160 - colorIndex, 0, colorIndex);
        line(50, colorIndex + 20, 70, colorIndex + 20);
      }

      //draw graph
      stroke(0);
      fill(255,255,255);
      rect(90,80,100,100);
    
      for (int index = 0; index<100; index++)
      {  
        if(index == 99)
          tempHistory[index] = tempF;
        else
          tempHistory[index] = tempHistory[index + 1];
        point(90 + index, 180 - tempHistory[index]);
      }

      //write reference values
      fill(0,0,0);
      textFont(font12); 
      textAlign(RIGHT);
      text("212 F", 45, 25); 
      text("32 F", 45, 187);

      //draw triangle pointer
      yDist = int(((160 - (160 * (tempF * 0.01)))*9)/5+32);
           // line(0, yDist, width, yDist);
         // text(yDist, width/2, height/2);
      stroke(0);
      triangle(75, yDist + 20, 85, yDist + 15, 85, yDist + 25);
colorMode(RGB);
      fill(255,255,255);
      
      rect(49, 12, 22, yDist+7);

      //write the temp in C and F
      fill(0,0,0);
      textFont(font24); 
      textAlign(LEFT);
      text(str(int(tempF)) + " F", 115, 37);
//     tempF = ((tempC*9)/5) + 32;
//     text(str(int(tempF)) + " F", 115, 65);
    }
  }
}

