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
    <TITLE>Calcolo Derivata</TITLE>
</HEAD>
    <BODY>
        <H1>Calcolo derivata con REST API implementata in JSP</H1>
        
        <%
        // Dichiariamo la stringa che sarà calcolata, persa dal parametro del form

        String message = request.getParameter("input");

        String inputString = message;
        // String inputString = "y = (x^2/2) - (2/x^2)";
        //String inputString = "y = -8x + x^5";

        // Codifica della stringa in un formato leggibile dall API
        String encodedString = URLEncoder.encode(inputString, "UTF-8")
        .replace("+", "%20")
        .replace("-", "%2D")
        .replace("*", "%2A")
        .replace("/", "%2F")
        .replace("^", "%5E")
        .replace("(", "%28")
        .replace(")", "%29")
        .replace("=", "%3D");
        
        // Creazione della query completa, concatneando tutte le parti necessarie
        String apiUrl = "http://api.wolframalpha.com/v2/query?appid=378JW6-969628P8KA&input=derivative[" + encodedString + "]&output=json";

        // Mandiamo la richiesta GET all'API e otteniamo la risposta
        URL url = new URL(apiUrl);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");

        // Leggiamo la risposta
        BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        StringBuilder responseBuilder = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            responseBuilder.append(line);
        }
        reader.close();

        // Trasformiamo la risposta in un oggetto JSON
        JSONObject data = new JSONObject(responseBuilder.toString());

        JSONArray pods = data.getJSONObject("queryresult").getJSONArray("pods");

        String result = "";
        String expResult = "";

        // Cerchiamo i risultati necessari, ovvero "Result" e "Expanded form"
        for (int i = 0; i < pods.length(); i++) {
            JSONObject pod = pods.getJSONObject(i);
            if (pod.getString("title").equals("Result")) {
                JSONArray subpods = pod.getJSONArray("subpods");
                JSONObject subpod = subpods.getJSONObject(0); 
                JSONObject img = subpod.getJSONObject("img");
                result = img.getString("src");
            }
            if (pod.getString("title").equals("Expanded form")) {
                JSONArray subpods = pod.getJSONArray("subpods");
                JSONObject subpod = subpods.getJSONObject(0); 
                JSONObject img = subpod.getJSONObject("img");
                expResult = img.getString("src");
            }
        }
 
        String displayResult = result;
        String expDisplay = expResult;
        %>

        <%-- Mandiamo in output chiave e messaggio --%>

        <P><b>Risultato:</b></P>
        <img src=<%=displayResult%> alt="Image">
        <p>
        
        <%-- Nel caso della presenza di una expanded form, mandiamo in outut anch'essa --%>
        <%
        if (expDisplay != null && !expDisplay.isEmpty()) {
        %>
            <p><b>Forma espansa:</b></p>
            <IMG SRC=<%=expDisplay%> ALT="image">
        <%
            }
        %>
        <p><b>Query all'API:</b></p>
        <a href="<%=apiUrl %>"><%=apiUrl %></a>
    </BODY>
</HTML>
