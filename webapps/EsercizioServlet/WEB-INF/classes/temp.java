import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class NameServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        PrintWriter out = response.getWriter();
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Name Form</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h1>Name Form</h1>");
        out.println("<form method='post'>");
        out.println("<label for='firstName'>First Name:</label>");
        out.println("<input type='text' id='firstName' name='firstName'><br>");
        out.println("<label for='lastName'>Last Name:</label>");
        out.println("<input type='text' id='lastName' name='lastName'><br>");
        out.println("<input type='submit' value='Submit'>");
        out.println("</form>");

        out.println("</body>");
        out.println("</html>");
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");

        response.setContentType("text/html");

        PrintWriter out = response.getWriter();
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Name Result</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h1>Name Result</h1>");
        out.println("<p>First Name: " + firstName + "</p>");
        out.println("<p>Last Name: " + lastName + "</p>");
        out.println("</body>");
        out.println("</html>");
    }
}