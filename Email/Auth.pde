// Daniel Shiffman               
// http://www.shiffman.net       

// Simple Authenticator          
// Careful, this is terribly unsecure!!

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Auth extends Authenticator {

  public Auth() {
    super();
  }

  public PasswordAuthentication getPasswordAuthentication() {
    String username, password;
    username = "gabriella.levine@gmail.com";
    password = "9ijnhy678";
    System.out.println("authenticating. . ");
    return new PasswordAuthentication(username, password);
  }
}
