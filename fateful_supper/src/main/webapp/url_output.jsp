<%@ page contentType="application/json;charset=UTF-8" language="java" isELIgnored="false" %>
<%
    String requestUrlOut = (String) session.getAttribute("requestUrlOut");
    if (requestUrlOut != null) {
        out.print(requestUrlOut);
    } else {
        out.print("{\"message\": \"No results found.\"}");
    }
%>