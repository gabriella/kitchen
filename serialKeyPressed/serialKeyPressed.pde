
import processing.serial.*;
Serial myPort;


void setup(){
myPort = new Serial(this, Serial.list()[0], 9600);//tis, portname, speed
}

void draw()
{
}

void keyReleased()
{
 myPort.write(key); 
}
