<%@ page contentType="text/plain;charset=UTF-8" language="java" isELIgnored="false" trimDirectiveWhitespaces="true" %>
<%
    String requestUrlOut = (String) session.getAttribute("requestUrlOut");
    if (requestUrlOut != null) {
        out.print(requestUrlOut);
    } else {
        out.print("Error");
    }
%>