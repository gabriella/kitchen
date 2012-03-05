

import processing.pdf.*;
import org.seltar.Bytes2Web.*;
PDFToWeb pdf=new PDFToWeb(this);

void saveImage(){

  pdf.addPage(); // if you want each frame to be on it's own page



  String url = "http://levinegabriella.com/Upload.php"; 
  
  
    if(!pdf.isRecording()){
      pdf.startRecording();
    }else{
      pdf.save("pdf");
      pdf.post("test",url,"pdf-test",true);
    }
  

  
    ImageToWeb img = new ImageToWeb(this);
    img.setType(ImageToWeb.PNG);
    img.save("png",true);
    img.post("test",url,"png-test",true);
  }

	


void sendEmail(){

String imageName="hellso";
loadStrings("http://levinegabriella.com/Portent/sendMail.php?imageName=http://levinegabriella.com/saved/test/");
  
}
