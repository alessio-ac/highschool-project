import javax.crypto.*;
import javax.crypto.spec.*;
import java.security.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import org.apache.commons.codec.binary.Hex;

public class codificaDES extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head><title>Codificatore DES</title></head>");
        out.println("<body>");
        out.println("<h1>Codificatore DES utilizzando JSP</h1>");
        out.println("<form method=\"post\">");
        out.println("Inserisci il messaggio da cifrare:");
        out.println("<input type='text' name='message'>");
        out.println("<input type='submit' value='Invia'>");
        out.println("</form>");
        out.println("</body></html>");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String message = request.getParameter("message");

        try {
            // Genera la chiave DES
            KeyGenerator myGenerator = KeyGenerator.getInstance("DES");
            SecretKey myKey = myGenerator.generateKey();

            // Crea algoritmo cifrario
            Cipher myCipher = Cipher.getInstance("DES/ECB/PKCS5Padding");
            
            // Imposta modlita encrypt con la chiave gnerata
            myCipher.init(Cipher.ENCRYPT_MODE, myKey);

            // Otteniamo un array di byte dal messaggio del form poichè DES lavora con i byte
            byte[] messageByte = message.getBytes();
            
            // Crittografiamo l'array di byte con il nostro cifrario
            byte[] encryptedBytes = myCipher.doFinal(messageByte);

            // Convertiamo la nostra chiave ed il messaggio cifrato in esadecimale
            String encodedKey = Hex.encodeHexString(myKey.getEncoded());
            String encodedMessage = Hex.encodeHexString(encryptedBytes);

            out.println("<html>");
            out.println("<head><title>Codificatore DES</title></head>");
            out.println("<body>");
            out.println("<h1>Codificatore DES utilizzando JSP</h1>");
            out.println("<p><strong>Messaggio crittografato:</strong> " + encodedMessage + "</p>");
            out.println("<p><strong>Chiave:</strong> " + encodedKey + "</p>");
            out.println("</body></html>");

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
