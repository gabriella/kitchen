int changeThreshold = 200;
int changedPixelsThreshold = 40;
int skip = 15;//5; // this is an optimization: don't look at all the pixels, just look at every (skip) pixels
int timerToLog = 10000;//3000; // the time to wait before deciding movement/no movement
int grayVal=0;
long counter = 0;

int[] oldFrame;
int[] lastSeen = {
  0, 0, 0, 0
}; // this will keep track of when we last saw movement in the quadrants
boolean[] movement = {
  false, false, false, false
}; // whether there is movement in the quadrants
void trackMovement(PImage frame) {
  if (oldFrame == null) oldFrame = new int[frame.width*frame.height];

  int[] quadrants = {
    0, 0, 0, 0
  }; // keep track of # of changed pixels in each quadrant

  // loop through all the pixels
  for (int x = 0; x < frame.width; x+=skip) {
    for (int y = 0; y < frame.height; y+=skip) {
      int i = y*frame.width + x;

      int diff = (int) abs(brightness(oldFrame[i]) - brightness(frame.pixels[i]));
      if (diff > changeThreshold) {
        // determine the quadrant
        int quadrant = 0;
        if (x > frame.width / 2) quadrant+=1;
        if (y > frame.height / 2) quadrant+=2;
        // log that the pixel changed
        quadrants[quadrant]++;
      }

      // update oldFrame
      oldFrame[i] = frame.pixels[i];
    }
  }

  int currentMillis = millis();
  if (counter >=75) {
    for (int i = 0; i < 4; i++) {
      if (quadrants[i] > changedPixelsThreshold) {
        // I see movement!
        lastSeen[i] = currentMillis;
      }
      // log movement change events
      if (!movement[i] && currentMillis == lastSeen[i]) {
        movement[i] = true;

        //sendMail();
        putToFlickr();
        saveFrame("images/mouses####.png");
        println("movement!");

        logPeople(i+1, movement[i]);
         
      } 
      else if (movement[i] && currentMillis - lastSeen[i] > timerToLog) {
        movement[i] = false;
        logPeople(i+1, movement[i]);
      }

      // for debugging
      int x = (i%2)*frame.width/2;
      int y = ((i < 2) ? 0 : frame.height/2) + 14;
      int dx = (x - viewX) * viewScale;
      int dy = (y - viewY) * viewScale;
      fill(255, 0, 0);
      text("movement: "+movement[i], dx, dy);

if(movement[i]==true)
{
  noFill();
  strokeWeight(20);
  stroke(255); 
rect(0,0,width, height);
}


    }
  }
  counter++;
}


void putToFlickr() {
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
