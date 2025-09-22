<%@ page contentType="application/json;charset=UTF-8" language="java" isELIgnored="false" %>
<%
    String placesResponse = (String) session.getAttribute("placesResponse");
    if (placesResponse != null) {
        out.print(placesResponse);
    } else {
        out.print("{\"message\": \"No results found.\"}");
    }
%>