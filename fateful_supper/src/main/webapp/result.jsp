<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>
<%
    HttpSession session = request.getSession();
    String placesResponse = (String) session.getAttribute("placesResponse");
    JSONObject jsonResponse = new JSONObject(placesResponse);
    JSONArray results = jsonResponse.getJSONArray("results");
%>
<html>
<body>
    <h1>Search Results</h1>
    <table border="1">
        <tr>
            <th>Name</th>
            <th>Address</th>
            <th>Location (Lat, Lng)</th>
        </tr>
        <%
            for (int i = 0; i < results.length(); i++) {
                JSONObject place = results.getJSONObject(i);
                String name = place.getString("name");
                String address = place.getString("formattedAddress");
                JSONObject location = place.getJSONObject("location");
                double lat = location.getDouble("latitude");
                double lng = location.getDouble("longitude");
        %>
        <tr>
            <td><%= name %></td>
            <td><%= address %></td>
            <td><%= lat %>, <%= lng %></td>
        </tr>
        <%
            }
        %>
    </table>
    <br>
    <a href="index.jsp">Back to Search</a>
</body>
</html>