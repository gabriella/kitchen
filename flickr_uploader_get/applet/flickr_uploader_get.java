import processing.core.*; 
import processing.xml.*; 

import processing.video.*; 
import javax.imageio.*; 
import java.awt.image.*; 
import com.aetrion.flickr.*; 

import com.aetrion.flickr.photosets.comments.*; 
import com.aetrion.flickr.commons.*; 
import com.aetrion.flickr.interestingness.*; 
import com.aetrion.flickr.urls.*; 
import com.aetrion.flickr.test.*; 
import com.aetrion.flickr.photos.upload.*; 
import com.aetrion.flickr.groups.*; 
import com.aetrion.flickr.reflection.*; 
import com.aetrion.flickr.photosets.*; 
import com.aetrion.flickr.photos.*; 
import com.aetrion.flickr.uploader.*; 
import com.aetrion.flickr.util.*; 
import com.aetrion.flickr.activity.*; 
import com.aetrion.flickr.favorites.*; 
import com.aetrion.flickr.prefs.*; 
import com.aetrion.flickr.groups.pools.*; 
import com.aetrion.flickr.people.*; 
import com.aetrion.flickr.photos.transform.*; 
import com.aetrion.flickr.panda.*; 
import com.aetrion.flickr.photos.geo.*; 
import com.aetrion.flickr.photos.comments.*; 
import com.aetrion.flickr.groups.members.*; 
import com.aetrion.flickr.machinetags.*; 
import com.aetrion.flickr.auth.*; 
import com.aetrion.flickr.blogs.*; 
import com.aetrion.flickr.contacts.*; 
import com.aetrion.flickr.photos.notes.*; 
import com.aetrion.flickr.places.*; 
import com.aetrion.flickr.tags.*; 
import com.aetrion.flickr.photos.licenses.*; 
import com.aetrion.flickr.*; 

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

public class flickr_uploader_get extends PApplet {

// Simple sketch to demonstrate uploading directly from a Processing sketch to Flickr.
// Uses a camera as a data source, uploads a frame every time you click the mouse.






// Fill in your own apiKey and secretKey values.
String apiKey = "7c18ae2ca6c9d08b0ba8d809eeea6c02";
String secretKey = "76f8b34febd05a3b";
                    
Flickr flickr;
Uploader uploader;
Auth auth;
String frob = "";
String token = "";

Capture cam;

public void setup() {
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

public void draw() {
  if (cam.available()) {
    cam.read();
    image(cam, 0, 0);
    text("Click to upload to Flickr", 10, height - 13);
  }
  fill(255,0,0);
  rect(0,0,25,25);
}

public void mousePressed() {
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
public void authenticate() {
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

// FLICKR AUTHENTICATION HELPER FUNCTIONS
// Attempts to authneticate with a given token
public void authenticateWithToken(String _token) {
  AuthInterface authInterface = flickr.getAuthInterface();  
  
  // make sure the token is legit
  try {
    authInterface.checkToken(_token);
  }
  catch (Exception e) {
    println("Token is bad, getting a new one");
    getAuthentication();
    return;
  }
  
  auth = new Auth();

  RequestContext requestContext = RequestContext.getRequestContext();
  requestContext.setSharedSecret(secretKey);    
  requestContext.setAuth(auth);
  
  auth.setToken(_token);
  auth.setPermission(Permission.WRITE);
  flickr.setAuth(auth);
  println("Authentication success");
}


// Goes online to get user authentication from Flickr.
public void getAuthentication() {
  AuthInterface authInterface = flickr.getAuthInterface();
  
  try {
    frob = authInterface.getFrob();
  } 
  catch (Exception e) {
    e.printStackTrace();
  }

  try {
    URL authURL = authInterface.buildAuthenticationUrl(Permission.WRITE, frob);
    
    // open the authentication URL in a browser
    open(authURL.toExternalForm());    
  }
  catch (Exception e) {
    e.printStackTrace();
  }

  println("You have 15 seconds to approve the app!");  
  int startedWaiting = millis();
  int waitDuration = 15 * 1000; // wait 10 seconds  
  while ((millis() - startedWaiting) < waitDuration) {
    // just wait
  }
  println("Done waiting");

  try {
    auth = authInterface.getToken(frob);
    println("Authentication success");
    // This token can be used until the user revokes it.
    token = auth.getToken();
    // save it for future use
    saveToken(token);
  }
  catch (Exception e) {
    e.printStackTrace();
  }
  
  // complete authentication
  authenticateWithToken(token);
}

// Writes the token to a file so we don't have
// to re-authenticate every time we run the app
public void saveToken(String _token) {
  String[] toWrite = { _token };
  saveStrings("token.txt", toWrite);  
}

public boolean fileExists(String filename) {
  File file = new File(sketchPath(filename));
  return file.exists();
}

// Load the token string from a file
public String loadToken() {
  String[] toRead = loadStrings("token.txt");
  return toRead[0];
}

// IMAGE COMPRESSION HELPER FUNCTION

// Takes a PImage and compresses it into a JPEG byte stream
// Adapted from Dan Shiffman's UDP Sender code
public byte[] compressImage(PImage img) {
  // We need a buffered image to do the JPG encoding
  BufferedImage bimg = new BufferedImage( img.width,img.height, BufferedImage.TYPE_INT_RGB );

  img.loadPixels();
  bimg.setRGB(0, 0, img.width, img.height, img.pixels, 0, img.width);

  // Need these output streams to get image as bytes for UDP communication
  ByteArrayOutputStream baStream	= new ByteArrayOutputStream();
  BufferedOutputStream bos		= new BufferedOutputStream(baStream);

  // Turn the BufferedImage into a JPG and put it in the BufferedOutputStream
  // Requires try/catch
  try {
    ImageIO.write(bimg, "jpg", bos);
  } 
  catch (IOException e) {
    e.printStackTrace();
  }

  // Get the byte array, which we will send out via UDP!
  return baStream.toByteArray();
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#666666", "--hide-stop", "flickr_uploader_get" });
  }
}
