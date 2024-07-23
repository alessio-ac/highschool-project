import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.time.LocalDateTime;  
import java.time.format.DateTimeFormatter;  

public class EsercizioServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException {

      response.setContentType("text/html");
      PrintWriter output = response.getWriter();

      output.println("<!DOCTYPE html><html>");
      output.println("<head>");
      output.println("<title>Esercitazione #5</title>");
      output.println("</head>");
      output.println("<body bgcolor=\"#ffffff\">");
      output.println("<h2>Inserimento dati</h2>");
      output.println("<form method='post'>");
      output.println("<table>");
      output.println("<tr><td>Nome:</td><td><input type='text' name='formName'><br></td></tr>");
      output.println("<tr><td>Cognome</td><td><input type='text' name='formLastName'><br></td></tr>");
      output.println("</table>");
      output.println("<input type='submit' value='Invia'>");
      output.println("</form>");
      output.println("</body>");
      output.println("</html>");
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException {

      response.setContentType("text/html");
      PrintWriter output = response.getWriter();

      String firstName = request.getParameter("formName");
      String lastName = request.getParameter("formLastName");

      java.util.Date date = new java.util.Date();    

      output.println("<!DOCTYPE html><html>");
      output.println("<head>");
      output.println("<title>Esercitazione #5</title>");
      output.println("</head>");
      output.println("<body bgcolor=\"#ffffff\">");
      output.println("<h2>Dati Inseriti</h2>");
      output.println("<p>Nome: " + firstName + "</p>");
      output.println("<p>Cognome: " + lastName + "</p>");
      output.println("<p><b>La data di oggi è " + date + "</b></p>");
      output.println("</body>");
      output.println("</html>");
    }
}
