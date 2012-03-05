// Simple sketch to demonstrate uploading directly from a Processing sketch to Flickr.
// Uses a camera as a data source, uploads a frame every time you click the mouse.

import processing.video.*;
import javax.imageio.*;
import java.awt.image.*;
import com.aetrion.flickr.*;

// Fill in your own apiKey and secretKey values.
String apiKey = "7c18ae2ca6c9d08b0ba8d809eeea6c02";
String secretKey = "76f8b34febd05a3b";
                    
Flickr flickr;
Uploader uploader;
Auth auth;
String frob = "";
String token = "";

Capture cam;

void setup() {
  size(320, 240);


 String[] devices = Capture.list();
  println(devices);
  // Set up the camera.
//  cam = new Capture(this, 320, 240);  
  cam = new Capture(this, width, height, devices[10]);


//cam.start();
  // Set up Flickr.
  flickr = new Flickr(apiKey, secretKey, (new Flickr(apiKey)).getTransport());
  
  // Authentication is the hard part.
  // If you're authenticating for the first time, this will open up
  // a web browser with Flickr's authentication web page and ask you to
  // give the app permission. You'll have 15 seconds to do this before the Processing app
  // gives up waiting fr you.
  
  // After the initial authentication, your info will be saved locally in a text file,
  // so you shouldn't have to go through the authentication song and dance more than once
  authenticate();

  // Create an uploader
  uploader = flickr.getUploader();
}

void draw() {
  if (cam.available()) {
    cam.read();
    image(cam, 0, 0);
    text("Click to upload to Flickr", 10, height - 13);
  }
  fill(255,0,0);
  rect(0,0,25,25);
}

void mousePressed() {
  // Upload the current camera frame.
  println("Uploading");
  
  loadPixels();
  PImage scrImg = get(0,0,width, height);
  // First compress it as a jpeg.
  byte[] compressedImage = compressImage(scrImg);
  
  // Set some meta data.
  UploadMetaData uploadMetaData = new UploadMetaData(); 
  uploadMetaData.setTitle("Frame " + frameCount + " Uploaded from Processing"); 
  uploadMetaData.setDescription("mouseFound");   
  uploadMetaData.setPublicFlag(true);

  // Finally, upload/
  try {
    uploader.upload(compressedImage, uploadMetaData);
  }
  catch (Exception e) {
    println("Upload failed");
  }
  
  println("Finished uploading");  
}

// Attempts to authenticate. Note this approach is bad form,
// it uses side effects, etc.
void authenticate() {
  // Do we already have a token?
  if (fileExists("token.txt")) {
    token = loadToken();    
    println("Using saved token " + token);
    authenticateWithToken(token);
  }
  else {
   println("No saved token. Opening browser for authentication");    
   getAuthentication();
  }
}


