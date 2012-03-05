




/*
import javax.mail.*;
import javax.mail.internet.*;
long num=0;


void sendMail() {
  // Create a session
  String host="smtp.gmail.com";
  Properties props=new Properties();

  // SMTP Session
  props.put("mail.transport.protocol", "smtp");
  props.put("mail.smtp.host", host);
  props.put("mail.smtp.port", "25");
  props.put("mail.smtp.auth", "true");
  // We need TTLS, which gmail requires
  props.put("mail.smtp.starttls.enable","true");

  // Create a session
  Session session = Session.getDefaultInstance(props, new Auth());

  try
  {
    // Make a new message
    MimeMessage message = new MimeMessage(session);

    // Who is this message from
    message.setFrom(new InternetAddress("gabbbles@gmail.com", "Gabriella"));

    // Who is this message to (we could do fancier things like make a list or add CC's)
    message.setRecipients(Message.RecipientType.TO, InternetAddress.parse("gabriella.levine@gmail.com", false));

    // Subject and body
    message.setSubject("got a mouse!"+num);
    message.setText("I detected motion. . .");

    // We can do more here, set the date, the headers, etc.
    //Transport.send(message);
    println("Mail sent!");
  }
  catch(Exception e)
  {
    e.printStackTrace();
  }
num++;
}

*/
