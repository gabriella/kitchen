import processing.core.*; 
import processing.xml.*; 

import processing.serial.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class graphhhhh extends PApplet {

/*
  Serial Graphing Sketch
 by Tom Igoe
 language: Processing
 
 This sketch takes ASCII values from the serial port 
 at 9600 bps and graphs them.
 The values should be comma-delimited, with a newline 
 at the end of every set of values.
 The expected range of the values is between 0 and 1023.
 
 Created 20 April 2005
 Updated 27 June 2008
 */



int x=0;

int maxNumberOfSensors = 8;       // Arduino has 6 analog inputs, so I chose 6
boolean fontInitialized = false;  // whether the font's been initialized
Serial myPort;                    // The serial port

float[] previousValue = new float[maxNumberOfSensors];  // array of previous values
int xpos = 0;                     // x position of the graph
PFont myFont;                     // font for writing text to the window

public void setup () {
  // set up the window to whatever size you want:
  size(800, 600);        
  // List all the available serial ports:
  println(Serial.list());
  // I know that the first port in the serial list on my mac
  // is always my  Arduino or Wiring module, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  myPort.clear();
  // don't generate a serialEvent() until you get a newline (\n) byte:
  myPort.bufferUntil('\n');
  // create a font with the fourth font available to the system:
 myFont = createFont(PFont.list()[3], 14);
 //myFont = createFont("FFScala", 14);
  textFont(myFont);
  fontInitialized = true;
  // set inital background:
  background(0);
  // turn on antialiasing:
  smooth();
}
public void draw () {

}

public void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  // if it's not empty:
  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);

    // convert to an array of ints:
    int incomingValues[] = PApplet.parseInt(split(inString, ","));

    // print out the values
    //  print("length: " + incomingValues.length + " values.\t");
    if (incomingValues.length <= maxNumberOfSensors && incomingValues.length > 0) {
      for (int i = 0; i < incomingValues.length; i++) {

        // map the incoming values (0 to  1023) to an appropriate
        // graphing range (0 to window height/number of values):
        float ypos = map(incomingValues[i], 100, 50, 0, height/incomingValues.length);

        // figure out the y position for this particular graph:
        float graphBottom = i * height/incomingValues.length;
        ypos = ypos + graphBottom;

        // make a black block to erase the previous text:
        noStroke();
        fill(0);
        rect(10, graphBottom+1, 110, 20);

        // print the sensor numbers to the screen:
       
        
        fill(255);
       
        int textPos = PApplet.parseInt(graphBottom) + 14;
        
        // sometimes serialEvent() can happen before setup() is done.
        // so you need to make sure the font is initialized before
        // you text():
        if (fontInitialized) {
          fill(0);
          rect(0, textPos-15, 200, 15);
          fill(255);
          text("Thermocouple " + i + ":" + incomingValues[i], 10, textPos);
        }
        // draw a line at the bottom of each graph:
        stroke(127);
        line(0, graphBottom, width, graphBottom);
        // change colors to draw the graph line in light blue:
        stroke(0xff34A3EC);
        line(xpos, previousValue[i], xpos+1, ypos);
        // save the current value to be the next time's previous value:
        previousValue[i] = ypos;
      }
    }
    // if you've drawn to the edge of the window, start at the beginning again:
    if (xpos >= width) {
      xpos = 0;
      background(0);
    } 
    else {
      xpos++;
    }
  }
}
public void mousePressed() {

x++;
 
save("graphFrame" + x +".png");
  println("frame"+ x+ "saved");
}



  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "graphhhhh" });
  }
}
