<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>

<!DOCTYPE HTML>
<HTML>
<HEAD>
    <TITLE>Calcolo Integrale</TITLE>
</HEAD>
    <BODY>
        <H1>Calcolo integrale indefinito con REST API implementata in JSP</H1>
        
        <%
        // Define the static string to be calculated

        String message = request.getParameter("input");

        String inputString = message;
        // String inputString = "(2 x - 1)/(x^2 + 2 x + 1)";
        //String inputString = "(4x + 1)/(4x^2 + 4x + 1)";

        // URL encode the input string
        String encodedString = URLEncoder.encode(inputString, "UTF-8")
        .replace("+", "%20")
        .replace("-", "%2D")
        .replace("*", "%2A")
        .replace("/", "%2F")
        .replace("^", "%5E")
        .replace("(", "%28")
        .replace(")", "%29")
        .replace("=", "%3D");
        // Construct the API query URL
        String apiUrl = "http://api.wolframalpha.com/v2/query?appid=378JW6-969628P8KA&input=integrate" + encodedString + "&output=json";

        // Send a GET request to the API and retrieve the response
        URL url = new URL(apiUrl);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");

        // Read the response from the API
        BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        StringBuilder responseBuilder = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            responseBuilder.append(line);
        }
        reader.close();

        // Parse the response as JSON
        JSONObject data = new JSONObject(responseBuilder.toString());

        JSONArray pods = data.getJSONObject("queryresult").getJSONArray("pods");

        String result = "";

        for (int i = 0; i < pods.length(); i++) {
            JSONObject pod = pods.getJSONObject(i);
            if (pod.getString("title").equals("Indefinite integral")) {
                JSONArray subpods = pod.getJSONArray("subpods");
                JSONObject subpod = subpods.getJSONObject(0); 
                JSONObject img = subpod.getJSONObject("img");
                result = img.getString("src");
            }
        }

        String displayResult = result; 
        %>

        <%-- Mandiamo in output chiave e messaggio --%>

        <P><b>Risultato:</b></P>
        <img src=<%=displayResult%> alt="Image">
        
    </BODY>
</HTML>
