// Daniel Shiffman               
// http://www.shiffman.net       

// Example functions that check mail (pop3) and send mail (smtp)
// You can also do imap, but that's not included here

// A function to check a mail account
void checkMail() {
  try {
    Properties props = System.getProperties();

    props.put("mail.pop3.host", "pop.gmail.com");
    
    // These are security settings required for gmail
    // May need different code depending on the account
    props.put("mail.pop3.port", "995");
    props.put("mail.pop3.starttls.enable", "true");
    props.setProperty("mail.pop3.socketFactory.fallback", "false");
    props.setProperty("mail.pop3.socketFactory.class","javax.net.ssl.SSLSocketFactory");

    // Create authentication object
    Auth auth = new Auth();
    
    // Make a session
    Session session = Session.getDefaultInstance(props, auth);
    Store store = session.getStore("pop3");
    store.connect();
    
    // Get inbox
    Folder folder = store.getFolder("INBOX");
    folder.open(Folder.READ_ONLY);
    System.out.println(folder.getMessageCount() + " total messages.");
    
    // Get array of messages and display them
    Message message[] = folder.getMessages();
    for (int i=0; i < message.length; i++) {
      System.out.println("---------------------");
      System.out.println("Message # " + (i+1));
      System.out.println("From: " + message[i].getFrom()[0]);
      System.out.println("Subject: " + message[i].getSubject());
      System.out.println("Message:");
      String content = message[i].getContent().toString(); 
      System.out.println(content);
    }
    
    // Close the session
    folder.close(false);
    store.close();
  } 
  // This error handling isn't very good
  catch (Exception e) {
    e.printStackTrace();
  }
}

// A function to send mail
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
    message.setFrom(new InternetAddress("gabriella.levine@gmail.com", "Gabriella"));

    // Who is this message to (we could do fancier things like make a list or add CC's)
    message.setRecipients(Message.RecipientType.TO, InternetAddress.parse("gabriella.levine@gmail.com", false));

    // Subject and body
    message.setSubject("got a mouse!");
    message.setText("I detected motion. . .");

    // We can do more here, set the date, the headers, etc.
    Transport.send(message);
    
    println("Mail sent!");
  }
  catch(Exception e)
  {
    e.printStackTrace();
  }

}


